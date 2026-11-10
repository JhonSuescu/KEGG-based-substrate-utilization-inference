# KEGG-based Substrate Utilization Inference

## Overview

This repository provides a reproducible workflow for inferring bacterial substrate utilization potential from genomic data based on KEGG Orthology (KO) annotations.

The workflow uses predefined sets of KO markers and evidence-based criteria to assess the genomic potential for utilizing different carbon sources and performing specific hydrolytic activities.

## Methodology

Substrate utilization potential is inferred by identifying substrate-associated KO markers in bacterial genome annotations obtained from KEGG. The presence or absence of these markers is evaluated according to predefined rules that consider the functional relevance and combinations of the corresponding genes.

The resulting genomic evidence is assigned to one of four categories:

- **Probable:** genomic evidence strongly supports the metabolic capacity based on the required KO markers.
- **Possible:** partial genomic evidence is detected, suggesting a potential metabolic capacity.
- **Unconfirmed:** some associated KO markers are identified, but the available evidence is insufficient to support the metabolic capacity.
- **Not identified:** none of the evaluated KO markers are detected.

These categories represent different levels of genomic evidence and do not constitute experimental confirmation of substrate utilization.

## Repository Contents

| File | Description |
|---|---|
| `KO_criteria.csv` | Substrate-associated KO markers and the criteria used for genomic classification. |
| `classification_script.R` | R script for applying the predefined classification rules to KO annotations. |
| `annotation_kegg.csv` | Example input file illustrating the required format for KEGG KO annotations. |
| `references.bib` | Bibliographic references supporting the selection of KO markers and classification criteria. |

## Input Data

The workflow accepts KEGG Orthology annotations from one or multiple bacterial genomes.

The input file must be provided as a CSV file named `annotation_kegg.csv`, containing the following columns:

| Column | Description |
|---|---|
| `genome_id` | Unique identifier assigned to each bacterial genome. |
| `ko_code` | KEGG Orthology identifier associated with the corresponding genome. |

Each row represents a KO annotation associated with a particular genome. Multiple rows can be included for the same genome, allowing several genomes to be analyzed simultaneously.

An example input file (`annotation_kegg.csv`) is included in the repository to illustrate the expected data structure. Users should replace it with their own KEGG KO annotations when performing an analysis.

The classification criteria are provided in `KO_criteria.csv` and should be used without changing the required column names.

## Requirements

The workflow requires:

- R (version 4.2.0 or later recommended).
- The following R packages:
  - `readr`
  - `dplyr`
  - `tidyr`
  - `stringr`
  - `purrr`

Install the required packages using:

```r
install.packages(c(
  "readr",
  "dplyr",
  "tidyr",
  "stringr",
  "purrr"
))
```

## Running the Workflow

1. Download or clone this repository.
2. Prepare the KEGG annotation file using the format described in the Input Data section.
3. Place `annotation_kegg.csv` in the working directory together with `KO_criteria.csv` and `classification_script.R`.
4. Open R or RStudio and set the working directory to the folder containing these files.
5. Run `classification_script.R`.

The script evaluates the predefined classification rules for every genome and substrate and automatically creates a directory named `results` in the current working directory.

## Output Structure

The workflow generates two classification files:

| File | Description |
|---|---|
| `Metabolic_classification.csv` | Long-format table containing the classification assigned to each genome–substrate combination. |
| `Metabolic_classification_matrix.csv` | Wide-format matrix with substrates as rows and bacterial genomes as columns. |

Both files are saved in the automatically generated `results` directory.

## Scope and Limitations

This workflow is designed to be applicable to bacterial genomes, regardless of their taxonomic affiliation, provided that suitable KEGG KO annotations are available.

The inferred categories reflect genomic potential based on the selected markers. They do not account for gene expression, enzyme activity, regulation, or other factors that may influence the actual utilization of a substrate under experimental conditions.

The classification criteria represent manually defined, literature-supported interpretations of genomic evidence. They are not official KEGG classifications and should not be interpreted as experimental confirmation of metabolic activity.

## References

The references supporting the selection of KO markers and classification criteria are provided in `references.bib`.

## Contact

For questions, suggestions, or further information regarding this workflow, please contact:

**Jhon A. Suescún-Sepúlveda**

University of Salamanca, Spain

Email: [jass94@usal.es](mailto:jass94@usal.es)
