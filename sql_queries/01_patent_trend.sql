-- Patent Trend Analysis: NVIDIA patents filed over time
-- Shows the number of patents filed per year

SELECT 
    EXTRACT(YEAR FROM TO_DATE(patent_date, 'YYYY-MM-DD')) AS year,
    COUNT(*) AS patent_count
FROM g_patent
WHERE patent_id IN (
    SELECT DISTINCT patent_id 
    FROM g_assignee_disambiguated 
    WHERE disambig_assignee_organization ILIKE '%NVIDIA%'
)
AND patent_date IS NOT NULL
GROUP BY EXTRACT(YEAR FROM TO_DATE(patent_date, 'YYYY-MM-DD'))
ORDER BY year;

