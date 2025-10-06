# 🎯 NVIDIA Patent Analytics

A comprehensive toolkit for filtering, analyzing, and visualizing NVIDIA Corporation's patent portfolio from USPTO PatentsView data.

![Python](https://img.shields.io/badge/python-3.7+-blue.svg)
![Pandas](https://img.shields.io/badge/pandas-1.3%2B-green.svg)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-12%2B-blue.svg)

## 📋 Overview

This project provides end-to-end tools for patent analytics:
- **Data Extraction**: Filter NVIDIA patents from massive USPTO datasets (9M+ records)
- **Data Processing**: Convert TSV to PostgreSQL-compatible CSV format
- **Analytics**: Pre-written SQL queries for trend analysis, inventor insights, and technology classification
- **Visualization**: Framework for creating Excel dashboards and charts

## 📊 Project Structure

```
nvidia-patent-analytics/
│
├── data_raw/                     # Raw USPTO data files (not in repo)
│   ├── g_patent.tsv
│   ├── g_cpc_current.tsv
│   ├── g_assignee_disambiguated.tsv
│   ├── g_inventor_disambiguated.tsv
│   ├── g_patent_abstract.tsv
│   └── README.md
│
├── data_cleaned/                 # Filtered NVIDIA data (not in repo)
│   ├── nvidia_patent.csv
│   ├── nvidia_inventor.csv
│   ├── nvidia_cpc.csv
│   ├── nvidia_assignee.csv
│   ├── nvidia_patent_abstract.csv
│   └── README.md
│
├── sql_queries/                  # Analysis queries
│   ├── 01_patent_trend.sql
│   ├── 02_top_cpc_classes.sql
│   ├── 03_top_inventors.sql
│   ├── 04_avg_claims_per_year.sql
│   ├── 05_inventor_collaboration.sql
│   └── README.md
│
├── excel_dashboard/              # Visualization outputs
│   └── README.md
│
├── filter_nvidia_patents.py      # Main filtering script
├── convert_tsv_to_csv.py        # TSV to CSV converter
├── schema.sql                    # PostgreSQL table definitions
├── requirements.txt              # Python dependencies
└── README.md                     # This file
```

## 🚀 Quick Start

### Prerequisites

- Python 3.7+
- pandas library
- PostgreSQL 12+ (optional, for SQL analysis)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/nvidia-patent-analytics.git
   cd nvidia-patent-analytics
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Download USPTO data:**
   - Visit [PatentsView Downloads](https://patentsview.org/download/data-download-tables)
   - Download the 5 required TSV files (see `data_raw/README.md`)
   - Place them in the `data_raw/` directory

### Usage

#### Step 1: Filter NVIDIA Patents

```bash
python filter_nvidia_patents.py
```

**Output:** Extracts ~5,169 NVIDIA patents from 9M+ total patents and saves filtered CSV files to `data_cleaned/`

#### Step 2: (Optional) Convert TSV to CSV for PostgreSQL

```bash
python convert_tsv_to_csv.py
```

**Output:** Converts TSV files to PostgreSQL-compatible CSV format with proper quoting

#### Step 3: Import to PostgreSQL (Optional)

```bash
# Create tables
psql -d your_database -f schema.sql

# Import data using pgAdmin or psql \COPY commands
```

#### Step 4: Run Analytics

Execute queries from `sql_queries/` in PostgreSQL to generate insights:
- Patent filing trends over time
- Top technology areas (CPC classifications)
- Most prolific inventors
- Patent complexity analysis
- Collaboration patterns

#### Step 5: Create Visualizations

Export query results and create dashboards in Excel, Tableau, or Python (matplotlib/seaborn).

## 📈 Sample Results

Based on October 2025 USPTO data:

| Metric | Value |
|--------|-------|
| Total NVIDIA Patents | 5,169 |
| Patent Records | 5,169 |
| Abstracts | 5,169 |
| CPC Classifications | 29,580 |
| Inventor Records | 16,402 |
| Unique Inventors | ~3,000+ |

## 📊 Analysis Queries

### 1. Patent Trend Analysis
Tracks NVIDIA's patent filing activity over time to identify innovation peaks and trends.

### 2. Technology Focus Areas
Identifies primary CPC technology classes (e.g., G06F - Computing, H01L - Semiconductors, G06T - Image Processing).

### 3. Top Inventors
Lists the most prolific inventors, useful for identifying key innovators and subject matter experts.

### 4. Patent Complexity
Analyzes the average number of claims per patent over time as a proxy for patent scope and quality.

### 5. Collaboration Networks
Examines team sizes and collaboration patterns in NVIDIA's innovation process.

## 🗄️ Database Schema

PostgreSQL tables match USPTO PatentsView schema:

- `g_patent` - Patent records (patent_id, date, title, type, claims)
- `g_assignee_disambiguated` - Assignee information (organization names)
- `g_inventor_disambiguated` - Inventor details (names, IDs)
- `g_cpc_current` - CPC technology classifications
- `g_patent_abstract` - Patent abstracts

See `schema.sql` for complete DDL statements.

## 🎨 Visualization Ideas

### Recommended Charts

1. **Line Chart**: Patents filed per year (trend analysis)
2. **Treemap**: Technology areas by CPC classification
3. **Bar Chart**: Top 20 inventors by patent count
4. **Stacked Area Chart**: Patent types over time
5. **Network Graph**: Inventor collaboration networks
6. **Heatmap**: Filing activity by year and technology class
7. **Box Plot**: Claims distribution over time

## 📝 Data Source

All data sourced from [USPTO PatentsView](https://patentsview.org/), a comprehensive database of U.S. patent data:
- Updated quarterly
- Includes patents back to 1976
- Disambiguated inventor and assignee names
- Standardized CPC classifications

## 🔧 Configuration

### Customizing the Filter

To filter patents for a different company, edit `filter_nvidia_patents.py`:

```python
# Change this line:
nvidia_assignee = assignee_df[
    assignee_df["disambig_assignee_organization"].str.contains("NVIDIA", case=False, na=False)
]

# To:
target_assignee = assignee_df[
    assignee_df["disambig_assignee_organization"].str.contains("YOUR_COMPANY", case=False, na=False)
]
```

## 📦 File Sizes

Be aware of large file sizes when downloading USPTO data:

| File | Rows | Size |
|------|------|------|
| g_patent.tsv | ~9.2M | ~2GB |
| g_assignee_disambiguated.tsv | ~8.5M | ~1.5GB |
| g_inventor_disambiguated.tsv | ~23.4M | ~3GB |
| g_cpc_current.tsv | ~57.1M | ~4GB |
| g_patent_abstract.tsv | ~9.2M | ~5.7GB |

**Total:** ~16GB of raw data

## 🐛 Troubleshooting

### PostgreSQL Import Errors

If you encounter "out of memory" errors when importing large CSV files:

```sql
SET work_mem = '256MB';
SET maintenance_work_mem = '1GB';
SET temp_buffers = '256MB';
```

### Large File Processing

For machines with limited RAM, consider:
- Processing files in chunks
- Using database COPY commands instead of pandas
- Filtering data before importing to PostgreSQL

## 🤝 Contributing

Contributions welcome! Areas for improvement:
- Additional SQL analysis queries
- Python visualization scripts
- International patent data integration
- Machine learning models for patent classification
- Network analysis of inventor collaborations

## 📄 License

MIT License - Free to use for research, commercial, and educational purposes.

## 🔗 Useful Resources

- [USPTO PatentsView](https://patentsview.org/)
- [CPC Classification System](https://www.cooperativepatentclassification.org/)
- [Patent Data Visualization Examples](https://patentsview.org/visualizations)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## 📧 Contact

For questions, issues, or collaboration opportunities, please open an issue on GitHub.

---

**Built with ❤️ for patent researchers, data scientists, and innovation analysts**

