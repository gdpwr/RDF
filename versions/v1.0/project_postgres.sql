-- RDF Project Execution Schema - PostgreSQL Implementation
-- Version: 1.0.0
-- Description: Project identity, developer, capacity, milestones, and operational status

CREATE TABLE rdf_project (
    project_id VARCHAR(50) PRIMARY KEY,
    project_name TEXT NOT NULL,
    technology_type VARCHAR(20) NOT NULL CHECK (technology_type IN ('Solar PV', 'Wind', 'BESS', 'Hybrid', 'Other')),
    nameplate_capacity_mw NUMERIC NOT NULL CHECK (nameplate_capacity_mw >= 0),
    developer_company TEXT,
    current_status VARCHAR(30) NOT NULL CHECK (current_status IN (
        'Pre-Development',
        'Permitting',
        'Permitted',
        'Under Construction',
        'Operational',
        'Decommissioned',
        'Canceled',
        'Withdrawn'
    )),
    status_date DATE,
    expected_cod DATE,
    actual_cod DATE,
    
    -- Milestones
    site_control_date DATE,
    permit_filed_date DATE,
    permit_approved_date DATE,
    construction_start_date DATE,
    substantial_completion_date DATE,
    
    -- Cancellation tracking
    cancellation_reason VARCHAR(50) CHECK (cancellation_reason IN (
        'Permit Denied',
        'Community Opposition',
        'Interconnection Costs',
        'Economics',
        'Developer Decision',
        'Other'
    )),
    
    -- Metadata
    data_source TEXT,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Constraints
    CONSTRAINT valid_cod_dates CHECK (actual_cod IS NULL OR expected_cod IS NULL OR actual_cod >= expected_cod - INTERVAL '2 years')
);

-- Indexes for common queries
CREATE INDEX idx_project_status ON rdf_project(current_status);
CREATE INDEX idx_project_technology ON rdf_project(technology_type);
CREATE INDEX idx_project_developer ON rdf_project(developer_company);
CREATE INDEX idx_project_cod ON rdf_project(expected_cod) WHERE current_status IN ('Permitting', 'Permitted', 'Under Construction');
CREATE INDEX idx_project_canceled ON rdf_project(cancellation_reason) WHERE current_status IN ('Canceled', 'Withdrawn');

-- Comments
COMMENT ON TABLE rdf_project IS 'RDF Project Execution domain - tracks renewable energy projects through development lifecycle';
COMMENT ON COLUMN rdf_project.project_id IS 'Unique project identifier (e.g., TX-ERCOT-001)';
COMMENT ON COLUMN rdf_project.nameplate_capacity_mw IS 'Total installed capacity in megawatts';
COMMENT ON COLUMN rdf_project.current_status IS 'Current stage in project lifecycle';
COMMENT ON COLUMN rdf_project.expected_cod IS 'Expected Commercial Operation Date';
COMMENT ON COLUMN rdf_project.actual_cod IS 'Actual Commercial Operation Date (if operational)';
