# Cleaned NVIDIA Patent Data

This folder contains filtered patent data specific to NVIDIA Corporation.

## Files Generated

After running `filter_nvidia_patents.py`, you'll find:

- `nvidia_assignee.csv` - NVIDIA assignee records (~5,169 rows)
- `nvidia_patent.csv` - NVIDIA patent details (~5,169 rows)
- `nvidia_patent_abstract.csv` - Patent abstracts (~5,169 rows)
- `nvidia_cpc.csv` - CPC technology classifications (~29,580 rows)
- `nvidia_inventor.csv` - Inventor information (~16,402 rows)

## Usage

These CSV files can be:
- Imported into PostgreSQL for analysis
- Opened in Excel/Google Sheets for visualization
- Used with Python/R for data science projects
- Analyzed using BI tools like Tableau or Power BI

## Note

**These files are not included in the repository** due to size. The `.gitignore` file excludes `.csv` files. You must generate them by running the filtering script on the raw data.

