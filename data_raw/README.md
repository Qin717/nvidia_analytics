# Raw Patent Data

This folder should contain the raw TSV files downloaded from [USPTO PatentsView](https://patentsview.org/download/data-download-tables).

## Required Files

Place the following files in this directory:

- `g_patent.tsv` - Main patent records (~9.2M rows)
- `g_assignee_disambiguated.tsv` - Patent assignee information (~8.5M rows)
- `g_inventor_disambiguated.tsv` - Inventor information (~23.4M rows)
- `g_cpc_current.tsv` - CPC classification codes (~57.1M rows)
- `g_patent_abstract.tsv` - Patent abstracts (~9.2M rows)

## Download Instructions

1. Visit https://patentsview.org/download/data-download-tables
2. Download the files listed above
3. Extract and place them in this directory
4. Run `convert_tsv_to_csv.py` (optional, for PostgreSQL import)
5. Run `filter_nvidia_patents.py` to extract NVIDIA patents

## Note

**These files are not included in the repository** due to their large size (multiple GB). The `.gitignore` file excludes `.tsv` and `.csv` files from version control.

