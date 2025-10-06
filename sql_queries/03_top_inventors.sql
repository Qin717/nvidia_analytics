-- Top NVIDIA Inventors by Patent Count
-- Lists the most prolific inventors at NVIDIA

SELECT 
    inventor_id,
    disambig_inventor_name_first || ' ' || disambig_inventor_name_last AS inventor_name,
    COUNT(DISTINCT patent_id) AS patent_count
FROM g_inventor_disambiguated
WHERE patent_id IN (
    SELECT DISTINCT patent_id 
    FROM g_assignee_disambiguated 
    WHERE disambig_assignee_organization ILIKE '%NVIDIA%'
)
GROUP BY inventor_id, disambig_inventor_name_first, disambig_inventor_name_last
ORDER BY patent_count DESC
LIMIT 50;

