#!/usr/bin/env python3
"""
NVIDIA Patent Filings Trend Visualization
Generates a line chart showing patent filings over time (1997-2025)
"""

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

def create_patent_trend_chart():
    """Create line chart of NVIDIA patent filings by year"""
    
    print("Loading data...")
    # Read the patent data
    df = pd.read_csv('data_cleaned/nvidia_patent.csv')
    
    # Convert patent_date to datetime
    df['patent_date'] = pd.to_datetime(df['patent_date'])
    
    # Extract year from patent_date
    df['filing_year'] = df['patent_date'].dt.year
    
    # Filter years between 1997 and 2025
    df_filtered = df[(df['filing_year'] >= 1997) & (df['filing_year'] <= 2025)]
    
    # Count patents by year
    patent_counts = df_filtered.groupby('filing_year')['patent_id'].count().reset_index()
    patent_counts.columns = ['filing_year', 'total_patents']
    
    # Sort by year
    patent_counts = patent_counts.sort_values('filing_year')
    
    print(f"\nPatent filings by year:\n{patent_counts.to_string(index=False)}\n")
    
    # Create the line chart
    fig, ax = plt.subplots(figsize=(16, 10))
    
    # Plot line with markers
    ax.plot(patent_counts['filing_year'], 
            patent_counts['total_patents'],
            marker='o',
            linewidth=2.5,
            markersize=6,
            color='#76B947',  # NVIDIA green
            markerfacecolor='black',
            markeredgewidth=0)
    
    # Add value labels on each point
    for x, y in zip(patent_counts['filing_year'], patent_counts['total_patents']):
        ax.annotate(str(y),
                   xy=(x, y),
                   xytext=(0, 8),
                   textcoords='offset points',
                   ha='center',
                   fontsize=9,
                   fontweight='bold',
                   color='#333333')
    
    # Customize the chart
    ax.set_title('NVIDIA Patent Filings Over Time (1997–2025)',
                fontsize=20,
                fontweight='bold',
                color='#76B947',
                pad=20)
    
    ax.set_xlabel('FILING YEAR',
                 fontsize=12,
                 fontweight='bold',
                 color='#555555')
    
    ax.set_ylabel('NUMBER OF PATENTS',
                 fontsize=12,
                 fontweight='bold',
                 color='#555555')
    
    # Set x-axis to show all years
    ax.set_xticks(patent_counts['filing_year'])
    ax.set_xticklabels(patent_counts['filing_year'], rotation=45, ha='right')
    
    # Format y-axis
    ax.yaxis.set_major_locator(ticker.MultipleLocator(50))
    
    # Add grid
    ax.grid(True, alpha=0.3, linestyle='--', linewidth=0.5)
    ax.set_axisbelow(True)
    
    # Set background color
    ax.set_facecolor('#F8F9FA')
    fig.patch.set_facecolor('white')
    
    # Adjust layout to make room for text
    plt.tight_layout(rect=[0, 0.15, 1, 1])
    
    # Add insight text below the chart
    insight_text = (
        "Insight:\n\n"
        "NVIDIA's patent filings rose sharply from fewer than 50 per year in the early 2000s to over 400 by 2024. "
        "Major surges correspond to key innovation waves — the launch of CUDA (2007), deep learning expansion (2015–2018), "
        "and the AI hardware boom (2022–2024).\n"
        "This steady upward trend highlights NVIDIA's long-term commitment to R&D leadership in AI, data centers, and semiconductor design."
    )
    
    fig.text(0.5, 0.08, insight_text,
            ha='center',
            va='center',
            fontsize=11,
            color='#333333',
            style='italic',
            wrap=True,
            bbox=dict(boxstyle='round,pad=1', facecolor='#F8F9FA', edgecolor='#CCCCCC', alpha=0.8))
    
    # Save the chart
    output_file = 'analysis_report/nvidia_patent_trend_chart.png'
    plt.savefig(output_file, dpi=300, bbox_inches='tight', facecolor='white')
    print(f"✅ Chart saved as '{output_file}'")
    
    # Display the chart
    plt.show()
    
    # Print summary statistics
    print("\n📊 Summary Statistics:")
    print(f"   Total patents: {patent_counts['total_patents'].sum()}")
    print(f"   Peak year: {patent_counts.loc[patent_counts['total_patents'].idxmax(), 'filing_year']}")
    print(f"   Peak patents: {patent_counts['total_patents'].max()}")
    print(f"   Average per year: {patent_counts['total_patents'].mean():.1f}")

if __name__ == "__main__":
    create_patent_trend_chart()

