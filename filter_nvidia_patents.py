import pandas as pd
from pathlib import Path

# Project directories
project_root = Path(__file__).parent
data_raw = project_root / "data_raw"
data_cleaned = project_root / "data_cleaned"

# Ensure output directory exists
data_cleaned.mkdir(exist_ok=True)

# Load assignee table
assignee_file = data_raw / "g_assignee_disambiguated.tsv"
print(f"Loading assignee data from: {assignee_file}")
assignee_df = pd.read_csv(assignee_file, sep="\t", dtype=str, low_memory=False)

# Filter NVIDIA patents
nvidia_assignee = assignee_df[
    assignee_df["disambig_assignee_organization"].str.contains("NVIDIA", case=False, na=False)
]
nvidia_assignee.to_csv(data_cleaned / "nvidia_assignee.csv", index=False)
print(f"✅ NVIDIA patents found: {len(nvidia_assignee)}")

# Collect NVIDIA patent_ids
nvidia_patent_ids = set(nvidia_assignee["patent_id"])

# Function to filter other tables
def filter_table(file_name, out_name):
    input_path = data_raw / file_name
    output_path = data_cleaned / out_name
    print(f"Processing: {file_name}...")
    df = pd.read_csv(input_path, sep="\t", dtype=str, low_memory=False)
    df = df[df["patent_id"].isin(nvidia_patent_ids)]
    df.to_csv(output_path, index=False)
    print(f"✅ Saved {len(df)} rows → {out_name}")

# Filter main tables
filter_table("g_patent.tsv", "nvidia_patent.csv")
filter_table("g_patent_abstract.tsv", "nvidia_patent_abstract.csv")
filter_table("g_cpc_current.tsv", "nvidia_cpc.csv")
filter_table("g_inventor_disambiguated.tsv", "nvidia_inventor.csv")

print(f"\n🎉 Done! NVIDIA subset saved to: {data_cleaned}")
print(f"\nOutput files:")
print(f"  - nvidia_assignee.csv")
print(f"  - nvidia_patent.csv")
print(f"  - nvidia_patent_abstract.csv")
print(f"  - nvidia_cpc.csv")
print(f"  - nvidia_inventor.csv")
