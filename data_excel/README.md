# Excel Data Files

This directory contains NVIDIA patent data in Excel format (.xlsx), converted from the CSV files in `data_cleaned/`.

## Files

### 1. nvidia_patent.xlsx
- **Rows:** 5,169
- **Columns:** 8
- **Description:** Core patent information including patent IDs, titles, dates, types, and claims count
- **Source:** `data_cleaned/nvidia_patent.csv`

### 2. nvidia_assignee.xlsx
- **Rows:** 5,169
- **Columns:** 8
- **Description:** Patent assignee (owner) information for each patent
- **Source:** `data_cleaned/nvidia_assignee.csv`

### 3. nvidia_inventor.xlsx
- **Rows:** 16,402
- **Columns:** 7
- **Description:** Inventor information for all NVIDIA patents (multiple inventors per patent)
- **Source:** `data_cleaned/nvidia_inventor.csv`

### 4. nvidia_cpc.xlsx
- **Rows:** 29,580
- **Columns:** 7
- **Description:** CPC (Cooperative Patent Classification) technology classifications for each patent
- **Source:** `data_cleaned/nvidia_cpc.csv`

### 5. nvidia_patent_abstract.xlsx
- **Rows:** 5,169
- **Columns:** 2
- **Description:** Patent abstracts (summaries) for each patent
- **Source:** `data_cleaned/nvidia_patent_abstract.csv`

## Usage

These Excel files are ready for:
- Data analysis in Excel
- Creating pivot tables and charts
- Dashboard development
- Business intelligence tools (Power BI, Tableau)
- Easy viewing and filtering without programming

## Conversion

To regenerate these files from CSV sources, run:

```bash
python3 convert_csv_to_excel.py
```

## File Sizes

Excel files are larger than CSVs due to formatting metadata. If you need smaller files for version control, use the CSV versions in `data_cleaned/` instead.

