-- Top CPC Technology Classes for NVIDIA Patents
-- Identifies the most common technology classifications

SELECT 
    cpc_section,
    cpc_class,
    COUNT(*) AS patent_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM g_cpc_current WHERE patent_id IN 
        (SELECT DISTINCT patent_id FROM g_assignee_disambiguated WHERE disambig_assignee_organization ILIKE '%NVIDIA%')), 2) AS percentage
FROM g_cpc_current
WHERE patent_id IN (
    SELECT DISTINCT patent_id 
    FROM g_assignee_disambiguated 
    WHERE disambig_assignee_organization ILIKE '%NVIDIA%'
)
GROUP BY cpc_section, cpc_class
ORDER BY patent_count DESC
LIMIT 20;

