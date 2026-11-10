
# ============================================================
# KEGG-based Substrate Utilization Inference
# ============================================================
#
# This script infers bacterial substrate utilization potential
# from KEGG Orthology (KO) annotations using predefined
# substrate-associated KO markers and logical classification
# rules.
#
# Input files:
#   - annotation_kegg.csv: KEGG KO annotations from one or
#     multiple bacterial genomes.
#   - KO_criteria.csv: substrate-associated KO markers and
#     logical classification rules.
#
# Required columns:
#
#   annotation_kegg.csv:
#     - genome_id: unique identifier for each bacterial genome.
#     - ko_code: KEGG Orthology identifier.
#
#   KO_criteria.csv:
#     - Substrate
#     - Classification
#     - Classification rule
#     - Description
#     - Reference
#
# Output files:
#   - Metabolic_classification.csv
#   - Metabolic_classification_matrix.csv
#
# ============================================================


# 1. LOAD REQUIRED PACKAGES
# ============================================================

library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(purrr)


# 2. IMPORT INPUT DATA
# ============================================================

# KEGG genome annotations

kegg <- read_csv(
  "annotation_kegg.csv",
  show_col_types = FALSE
) %>%
  distinct(genome_id, ko_code)

# Substrate classification criteria

criteria <- read_csv(
  "KO_criteria.csv",
  show_col_types = FALSE
)


# 3. PREPARE DATA
# ============================================================

# Identify genomes and substrates

genomes <- sort(unique(kegg$genome_id))
substrates <- unique(criteria$Substrate)


# 4. DEFINE LOGICAL OPERATORS
# ============================================================

# These functions allow the evaluation of logical expressions
# defined in KO_criteria.csv.

AND <- function(...) {
  all(unlist(list(...)))
}

OR <- function(...) {
  any(unlist(list(...)))
}

NOT <- function(x) {
  !x
}


# 5. EVALUATE CLASSIFICATION RULES
# ============================================================

evaluate_rule <- function(rule, genome_kos) {
  
  # Extract KO identifiers included in the rule
  
  rule_kos <- unique(
    str_extract_all(rule, "K[0-9]{5}")[[1]]
  )
  
  # Create an isolated evaluation environment
  
  evaluation_environment <- new.env(
    parent = baseenv()
  )
  
  # Define logical operators
  
  evaluation_environment$AND <- AND
  evaluation_environment$OR <- OR
  evaluation_environment$NOT <- NOT
  
  # Assign TRUE or FALSE according to KO presence
  
  for (ko in rule_kos) {
    evaluation_environment[[ko]] <- ko %in% genome_kos
  }
  
  # Evaluate the classification rule
  
  result <- eval(
    parse(text = rule),
    envir = evaluation_environment
  )
  
  as.logical(result)[1]
}


# 6. GROUP KO ANNOTATIONS BY GENOME
# ============================================================

ko_by_genome <- kegg %>%
  group_by(genome_id) %>%
  summarise(
    kos = list(unique(ko_code)),
    .groups = "drop"
  )


# 7. EVALUATE ALL SUBSTRATES IN ALL GENOMES
# ============================================================

results <- expand_grid(
  genome_id = genomes,
  criteria_id = seq_len(nrow(criteria))
) %>%
  left_join(
    criteria %>%
      mutate(criteria_id = row_number()),
    by = "criteria_id"
  ) %>%
  left_join(
    ko_by_genome,
    by = "genome_id"
  ) %>%
  mutate(
    present = map2_lgl(
      `Classification rule`,
      kos,
      evaluate_rule
    )
  ) %>%
  select(
    genome_id,
    Substrate,
    Classification,
    present
  )


# 8. GENERATE FINAL CLASSIFICATION TABLE
# ============================================================

# Retain the classification assigned by the positive rule

classified <- results %>%
  filter(present) %>%
  group_by(genome_id, Substrate) %>%
  summarise(
    classification = paste(
      Classification,
      collapse = "; "
    ),
    .groups = "drop"
  )

# Generate final classification in long format

final_classification <- expand_grid(
  genome_id = genomes,
  Substrate = substrates
) %>%
  left_join(
    classified,
    by = c("genome_id", "Substrate")
  )


# 9. GENERATE SUBSTRATE CLASSIFICATION MATRIX
# ============================================================

substrate_matrix <- final_classification %>%
  pivot_wider(
    names_from = genome_id,
    values_from = classification
  ) %>%
  arrange(Substrate)


# 10. EXPORT RESULTS
# ============================================================

output_directory <- "results"

if (!dir.exists(output_directory)) {
  dir.create(output_directory)
}

# Export long-format classification table

write_csv(
  final_classification,
  file.path(
    output_directory,
    "Metabolic_classification.csv"
  )
)

# Export wide-format classification matrix

write_csv(
  substrate_matrix,
  file.path(
    output_directory,
    "Metabolic_classification_matrix.csv"
  )
)


# ============================================================
# END OF SCRIPT
# ============================================================
