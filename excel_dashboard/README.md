# Excel Dashboard & Visualizations

This folder is for storing Excel dashboards and exported visualizations of NVIDIA patent analytics.

## Suggested Contents

### Excel Dashboard
- `NVIDIA_Patent_Insights.xlsx` - Main dashboard with charts and pivot tables

### Visualizations (PNG/PDF exports)
- `Patent_Trend.png` - Line chart of patents filed over time
- `Top_Tech_Treemap.png` - Treemap of technology classifications
- `Top_Inventors_Bar.png` - Bar chart of top inventors
- `Collaboration_Network.png` - Network graph of inventor collaborations
- `Claims_Analysis.png` - Box plot of patent complexity trends

## Creating Visualizations

1. Run SQL queries from `sql_queries/` folder
2. Export results to CSV
3. Import into Excel or other visualization tools
4. Create charts and dashboards
5. Export visualizations as PNG/PDF
6. Save files here for documentation

## Excel Tips

### Recommended Charts
- **Patent Trends**: Line chart with year on X-axis
- **CPC Classes**: Treemap or horizontal bar chart
- **Top Inventors**: Bar chart sorted by patent count
- **Collaboration**: Donut chart or stacked bar chart
- **Claims Analysis**: Box plot or line chart with trend line

### Pivot Table Ideas
- Patents by year and technology class
- Inventor productivity over time
- Geographic distribution (if location data added)

## Note

**Dashboard files are not included in the repository by default**. Add your own Excel files and visualizations here as you create them. Update `.gitignore` if you want to include them in version control.

