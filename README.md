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
| `classification_script.R` | Script for applying the predefined classification rules to KO annotations. |
| `references.bib` | Bibliographic references supporting the selection of KO markers and classification criteria. |

## Requirements

The workflow requires bacterial genome annotations containing KEGG Orthology (KO) identifiers.

## Scope and Limitations

This workflow is designed to be applicable to bacterial genomes, regardless of their taxonomic affiliation, provided that suitable KEGG KO annotations are available.

The inferred categories reflect genomic potential based on the selected markers. They do not account for gene expression, enzyme activity, regulation, or other factors that may influence the actual utilization of a substrate under experimental conditions.

## References

The references supporting the selection of KO markers and classification criteria are provided in `references.bib`.
