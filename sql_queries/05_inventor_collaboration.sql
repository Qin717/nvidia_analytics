-- Inventor Collaboration Network
-- Shows patents with multiple inventors and collaboration patterns

WITH patent_inventor_count AS (
    SELECT 
        patent_id,
        COUNT(*) AS inventor_count
    FROM g_inventor_disambiguated
    WHERE patent_id IN (
        SELECT DISTINCT patent_id 
        FROM g_assignee_disambiguated 
        WHERE disambig_assignee_organization ILIKE '%NVIDIA%'
    )
    GROUP BY patent_id
)
SELECT 
    CASE 
        WHEN inventor_count = 1 THEN '1 inventor'
        WHEN inventor_count BETWEEN 2 AND 3 THEN '2-3 inventors'
        WHEN inventor_count BETWEEN 4 AND 5 THEN '4-5 inventors'
        ELSE '6+ inventors'
    END AS collaboration_size,
    COUNT(*) AS patent_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM patent_inventor_count
GROUP BY 
    CASE 
        WHEN inventor_count = 1 THEN '1 inventor'
        WHEN inventor_count BETWEEN 2 AND 3 THEN '2-3 inventors'
        WHEN inventor_count BETWEEN 4 AND 5 THEN '4-5 inventors'
        ELSE '6+ inventors'
    END
ORDER BY 
    CASE collaboration_size
        WHEN '1 inventor' THEN 1
        WHEN '2-3 inventors' THEN 2
        WHEN '4-5 inventors' THEN 3
        ELSE 4
    END;

