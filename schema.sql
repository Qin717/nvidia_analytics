-- PostgreSQL Schema for USPTO PatentsView Data
-- For use with NVIDIA Patent Analytics project

-- Drop existing tables if they exist
DROP TABLE IF EXISTS g_patent CASCADE;
DROP TABLE IF EXISTS g_assignee_disambiguated CASCADE;
DROP TABLE IF EXISTS g_inventor_disambiguated CASCADE;
DROP TABLE IF EXISTS g_patent_abstract CASCADE;
DROP TABLE IF EXISTS g_cpc_current CASCADE;

-- ============================================================================
-- Main Patent Table
-- ============================================================================
CREATE TABLE g_patent (
    patent_id TEXT,
    patent_type TEXT,
    patent_date TEXT,
    patent_title TEXT,
    wipo_kind TEXT,
    num_claims TEXT,
    withdrawn TEXT,
    filename TEXT
);

COMMENT ON TABLE g_patent IS 'Main patent records from USPTO';
COMMENT ON COLUMN g_patent.patent_id IS 'Unique patent identifier';
COMMENT ON COLUMN g_patent.patent_date IS 'Patent grant date (YYYY-MM-DD)';
COMMENT ON COLUMN g_patent.num_claims IS 'Number of claims in patent';

-- ============================================================================
-- Assignee Table (Patent Owners/Companies)
-- ============================================================================
CREATE TABLE g_assignee_disambiguated (
    patent_id TEXT,
    assignee_sequence TEXT,
    assignee_id TEXT,
    disambig_assignee_individual_name_first TEXT,
    disambig_assignee_individual_name_last TEXT,
    disambig_assignee_organization TEXT,
    assignee_type TEXT,
    location_id TEXT
);

COMMENT ON TABLE g_assignee_disambiguated IS 'Patent assignee (owner) information with disambiguated names';
COMMENT ON COLUMN g_assignee_disambiguated.disambig_assignee_organization IS 'Standardized organization name (e.g., NVIDIA Corporation)';
COMMENT ON COLUMN g_assignee_disambiguated.assignee_type IS 'Type: 2=US Company, 3=Foreign Company, etc.';

-- ============================================================================
-- Inventor Table
-- ============================================================================
CREATE TABLE g_inventor_disambiguated (
    patent_id TEXT,
    inventor_sequence TEXT,
    inventor_id TEXT,
    disambig_inventor_name_first TEXT,
    disambig_inventor_name_last TEXT,
    gender_code TEXT,
    location_id TEXT
);

COMMENT ON TABLE g_inventor_disambiguated IS 'Patent inventor information with disambiguated names';
COMMENT ON COLUMN g_inventor_disambiguated.inventor_id IS 'Unique disambiguated inventor identifier';
COMMENT ON COLUMN g_inventor_disambiguated.gender_code IS 'Inferred gender: M=Male, F=Female';

-- ============================================================================
-- Patent Abstract Table
-- ============================================================================
CREATE TABLE g_patent_abstract (
    patent_id TEXT,
    patent_abstract TEXT
);

COMMENT ON TABLE g_patent_abstract IS 'Patent abstracts (brief summaries)';
COMMENT ON COLUMN g_patent_abstract.patent_abstract IS 'Full text of patent abstract';

-- ============================================================================
-- CPC Classification Table (Technology Categories)
-- ============================================================================
CREATE TABLE g_cpc_current (
    patent_id TEXT,
    cpc_sequence TEXT,
    cpc_section TEXT,
    cpc_class TEXT,
    cpc_subclass TEXT,
    cpc_group TEXT,
    cpc_type TEXT
);

COMMENT ON TABLE g_cpc_current IS 'Cooperative Patent Classification codes';
COMMENT ON COLUMN g_cpc_current.cpc_section IS 'High-level CPC section (A-H, Y)';
COMMENT ON COLUMN g_cpc_current.cpc_class IS 'CPC class (e.g., G06F for computing)';
COMMENT ON COLUMN g_cpc_current.cpc_type IS 'inventive or additional classification';

-- ============================================================================
-- Indexes for Performance
-- ============================================================================

-- Primary key-like indexes on patent_id
CREATE INDEX idx_patent_id ON g_patent(patent_id);
CREATE INDEX idx_assignee_patent_id ON g_assignee_disambiguated(patent_id);
CREATE INDEX idx_inventor_patent_id ON g_inventor_disambiguated(patent_id);
CREATE INDEX idx_abstract_patent_id ON g_patent_abstract(patent_id);
CREATE INDEX idx_cpc_patent_id ON g_cpc_current(patent_id);

-- Additional indexes for common queries
CREATE INDEX idx_patent_date ON g_patent(patent_date);
CREATE INDEX idx_assignee_org ON g_assignee_disambiguated(disambig_assignee_organization);
CREATE INDEX idx_inventor_id ON g_inventor_disambiguated(inventor_id);
CREATE INDEX idx_cpc_section_class ON g_cpc_current(cpc_section, cpc_class);

-- ============================================================================
-- Import Instructions
-- ============================================================================

-- After creating tables, import CSV files using:
-- 
-- Method 1: psql command line
-- \COPY g_patent FROM '/path/to/g_patent.csv' WITH (FORMAT csv, HEADER true);
-- \COPY g_assignee_disambiguated FROM '/path/to/g_assignee_disambiguated.csv' WITH (FORMAT csv, HEADER true);
-- \COPY g_inventor_disambiguated FROM '/path/to/g_inventor_disambiguated.csv' WITH (FORMAT csv, HEADER true);
-- \COPY g_cpc_current FROM '/path/to/g_cpc_current.csv' WITH (FORMAT csv, HEADER true);
-- \COPY g_patent_abstract FROM '/path/to/g_patent_abstract.csv' WITH (FORMAT csv, HEADER true);
--
-- Method 2: Use pgAdmin's Import/Export tool
-- Right-click table → Import/Export → Select CSV file → Import

-- For large files, increase memory settings:
-- SET work_mem = '256MB';
-- SET maintenance_work_mem = '1GB';
-- SET temp_buffers = '256MB';

-- ============================================================================
-- Analysis Views (Optional)
-- ============================================================================

-- View: NVIDIA Patents Only
CREATE OR REPLACE VIEW nvidia_patents AS
SELECT 
    p.*,
    a.disambig_assignee_organization
FROM g_patent p
INNER JOIN g_assignee_disambiguated a ON p.patent_id = a.patent_id
WHERE a.disambig_assignee_organization ILIKE '%NVIDIA%';

COMMENT ON VIEW nvidia_patents IS 'Filtered view showing only NVIDIA patents';

-- View: Patent with Primary CPC
CREATE OR REPLACE VIEW patents_with_primary_cpc AS
SELECT 
    p.patent_id,
    p.patent_title,
    p.patent_date,
    c.cpc_section,
    c.cpc_class,
    c.cpc_subclass
FROM g_patent p
LEFT JOIN g_cpc_current c ON p.patent_id = c.patent_id AND c.cpc_sequence = '0';

COMMENT ON VIEW patents_with_primary_cpc IS 'Patents with their primary (first) CPC classification';

-- ============================================================================
-- Verification Queries
-- ============================================================================

-- Check row counts
-- SELECT 'g_patent' as table_name, COUNT(*) as row_count FROM g_patent
-- UNION ALL
-- SELECT 'g_assignee_disambiguated', COUNT(*) FROM g_assignee_disambiguated
-- UNION ALL
-- SELECT 'g_inventor_disambiguated', COUNT(*) FROM g_inventor_disambiguated
-- UNION ALL
-- SELECT 'g_cpc_current', COUNT(*) FROM g_cpc_current
-- UNION ALL
-- SELECT 'g_patent_abstract', COUNT(*) FROM g_patent_abstract;

-- Check NVIDIA patent count
-- SELECT COUNT(DISTINCT patent_id) as nvidia_patent_count
-- FROM g_assignee_disambiguated
-- WHERE disambig_assignee_organization ILIKE '%NVIDIA%';

