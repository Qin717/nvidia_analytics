#!/usr/bin/env python3
"""
Convert CSV files to Excel format
Reads CSV files from data_cleaned/ and saves as Excel files in data_excel/
"""

import pandas as pd
import os

def convert_csv_to_excel():
    """Convert all CSV files in data_cleaned to Excel format"""
    
    # Define input and output directories
    input_dir = "data_cleaned"
    output_dir = "data_excel"
    
    # List of CSV files to convert
    csv_files = [
        "nvidia_patent.csv",
        "nvidia_assignee.csv",
        "nvidia_inventor.csv",
        "nvidia_cpc.csv",
        "nvidia_patent_abstract.csv"
    ]
    
    print("Starting CSV to Excel conversion...\n")
    
    for csv_file in csv_files:
        input_path = os.path.join(input_dir, csv_file)
        
        # Check if file exists
        if not os.path.exists(input_path):
            print(f"❌ File not found: {input_path}")
            continue
        
        # Create output filename (replace .csv with .xlsx)
        excel_file = csv_file.replace('.csv', '.xlsx')
        output_path = os.path.join(output_dir, excel_file)
        
        print(f"Converting {csv_file}...")
        
        try:
            # Read CSV file
            df = pd.read_csv(input_path)
            
            # Write to Excel
            df.to_excel(output_path, index=False, engine='openpyxl')
            
            print(f"✅ Created {excel_file} ({len(df)} rows, {len(df.columns)} columns)")
            
        except Exception as e:
            print(f"❌ Error converting {csv_file}: {str(e)}")
    
    print("\n✨ Conversion complete!")

if __name__ == "__main__":
    convert_csv_to_excel()

