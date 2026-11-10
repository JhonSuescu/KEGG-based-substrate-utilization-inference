# KEGG-based Substrate Utilization Inference

**A genome-based approach to support substrate selection in bacterial taxonomic characterization.**

**Purpose:** Supporting the selection of substrates for phenotypic characterization of novel bacterial taxa through the inference of genomic metabolic potential.

![Genome-based predictions](https://img.shields.io/badge/Genome--based-predictions-blue)
![50 substrates and activities](https://img.shields.io/badge/50-Substrates%20%26%20activities-green)
![Taxonomic characterization](https://img.shields.io/badge/Taxonomic-characterization-purple)
![KEGG Orthology](https://img.shields.io/badge/KEGG-Orthology-orange)

---
## Overview

The phenotypic characterization of bacterial strains is an essential component of the description of novel taxa. In particular, substrate utilization profiles provide valuable information for distinguishing closely related bacterial species. However, selecting which substrates should be included in experimental characterization can be challenging, especially when the number of available tests is limited.

This repository provides a reproducible workflow to support the selection of substrates for phenotypic characterization based on bacterial genomic data and KEGG Orthology (KO) annotations.

The workflow evaluates the presence of substrate-associated KO markers using predefined, literature-supported criteria to infer the genomic potential of bacterial strains to utilize different carbon sources and perform specific hydrolytic activities.

The current version includes 50 substrates and hydrolytic activities, selected from the broader range of compounds and metabolic activities that can potentially be investigated in bacterial phenotypic characterization.

The resulting classifications provide preliminary genomic evidence that can help guide the selection of substrates for experimental testing, complementing conventional phenotypic characterization during the description of novel bacterial taxa.

This workflow is intended as a complementary tool for taxonomic studies, rather than a replacement for experimental phenotypic characterization.

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

## License

This repository is licensed under the
[Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0)](https://creativecommons.org/licenses/by-nc/4.0/).

You are free to share and adapt the material for non-commercial purposes, provided appropriate credit is given.

[![CC BY-NC 4.0](https://licensebuttons.net/l/by-nc/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc/4.0/)

## Contact

For questions, suggestions, or further information regarding this workflow, please contact:

**Jhon A. Suescún-Sepúlveda**

University of Salamanca, Spain

Email: [jass94@usal.es](mailto:jass94@usal.es)
