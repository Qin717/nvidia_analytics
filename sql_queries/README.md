# SQL Analysis Queries

This folder contains pre-written SQL queries for analyzing NVIDIA patent data in PostgreSQL.

## Available Queries

### 1. Patent Trend Analysis (`01_patent_trend.sql`)
Analyzes the number of NVIDIA patents filed per year to identify innovation trends.

**Use Case:** Visualize patent activity over time, identify peak innovation periods.

### 2. Top CPC Technology Classes (`02_top_cpc_classes.sql`)
Identifies the most common technology classifications (CPC codes) in NVIDIA's patent portfolio.

**Use Case:** Understand NVIDIA's primary technology focus areas (e.g., GPUs, AI, networking).

### 3. Top Inventors (`03_top_inventors.sql`)
Lists the most prolific inventors at NVIDIA by patent count.

**Use Case:** Identify key innovators and subject matter experts.

### 4. Average Claims Per Year (`04_avg_claims_per_year.sql`)
Analyzes patent complexity trends by examining the average number of claims per patent over time.

**Use Case:** Assess patent quality and complexity evolution.

### 5. Inventor Collaboration Patterns (`05_inventor_collaboration.sql`)
Analyzes collaboration patterns by grouping patents by number of inventors.

**Use Case:** Understand team dynamics and collaborative innovation.

## How to Use

1. Import the cleaned NVIDIA CSV files into PostgreSQL
2. Open pgAdmin or `psql` command-line tool
3. Copy and run any of these queries
4. Export results to CSV for visualization in Excel/Tableau

## Database Setup

Make sure you have the following tables in PostgreSQL:
- `g_patent`
- `g_assignee_disambiguated`
- `g_inventor_disambiguated`
- `g_cpc_current`
- `g_patent_abstract`

See the main README for schema definitions and import instructions.

