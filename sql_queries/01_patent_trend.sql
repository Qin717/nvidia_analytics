-- NVIDIA Patent Filings by Year (2000–2025)

SELECT
    EXTRACT(YEAR FROM patent_date) AS filing_year,
    COUNT(DISTINCT patent_id) AS total_patents
FROM
    nvidia_patent
WHERE
    EXTRACT(YEAR FROM patent_date) BETWEEN 2000 AND 2025
GROUP BY
    filing_year
ORDER BY
    filing_year;

