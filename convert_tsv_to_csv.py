import pandas as pd
import csv
from pathlib import Path

# Project directories
project_root = Path(__file__).parent
data_raw = project_root / "data_raw"

# List of .tsv files to convert
tsv_files = [
    "g_patent.tsv",
    "g_assignee_disambiguated.tsv",
    "g_inventor_disambiguated.tsv",
    "g_cpc_current.tsv",
    "g_patent_abstract.tsv"
]

print("Converting TSV files to CSV format (PostgreSQL compatible)...\n")

# Convert each file
for tsv_file in tsv_files:
    input_path = data_raw / tsv_file
    output_path = data_raw / tsv_file.replace(".tsv", ".csv")
    
    if not input_path.exists():
        print(f"⚠️  Warning: {tsv_file} not found in data_raw/ - skipping")
        continue
    
    # Read TSV file
    print(f"Processing: {tsv_file}...")
    df = pd.read_csv(input_path, sep="\t", dtype=str, low_memory=False)
    
    # Save as CSV with all fields quoted (PostgreSQL compatible format)
    df.to_csv(
        output_path,
        index=False,
        quoting=csv.QUOTE_ALL,
        doublequote=True,
        lineterminator='\n'
    )
    
    print(f"✅ Converted: {tsv_file} → {output_path.name} ({len(df):,} rows)")

print(f"\n🎉 All files converted successfully!")
print(f"CSV files saved to: {data_raw}")
