-- Q2: Which technology domains (CPC classes) dominate NVIDIA's patent portfolio?

SELECT 
    c.cpc_subclass AS technology_class,
	COUNT(DISTINCT c.patent_id) AS total_patents
FROM 
    nvidia_cpc AS c
JOIN 
    nvidia_patent AS p
	ON c.patent_id = p.patent_id
WHERE 
    EXTRACT(YEAR FROM p.patent_date) BETWEEN 1997 AND 2025
GROUP BY
    technology_class
ORDER BY 
    total_patents DESC
LIMIT 10;

