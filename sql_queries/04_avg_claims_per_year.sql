-- Average Claims Per Patent by Year
-- Analyzes patent complexity trends over time

SELECT 
    EXTRACT(YEAR FROM TO_DATE(p.patent_date, 'YYYY-MM-DD')) AS year,
    COUNT(*) AS patent_count,
    ROUND(AVG(CAST(num_claims AS NUMERIC)), 2) AS avg_claims,
    MIN(CAST(num_claims AS NUMERIC)) AS min_claims,
    MAX(CAST(num_claims AS NUMERIC)) AS max_claims
FROM g_patent p
WHERE p.patent_id IN (
    SELECT DISTINCT patent_id 
    FROM g_assignee_disambiguated 
    WHERE disambig_assignee_organization ILIKE '%NVIDIA%'
)
AND p.patent_date IS NOT NULL
AND p.num_claims IS NOT NULL
AND p.num_claims ~ '^[0-9]+$'  -- Only numeric values
GROUP BY EXTRACT(YEAR FROM TO_DATE(p.patent_date, 'YYYY-MM-DD'))
ORDER BY year;

