-- RDF Permitting & Process Schema - PostgreSQL Implementation
-- Version: 1.0.0
-- Description: Permit applications, jurisdictions, status, timelines, and approval risk

CREATE TABLE rdf_permit (
    permit_id VARCHAR(50) PRIMARY KEY,
    project_id VARCHAR(50) NOT NULL,
    permit_type VARCHAR(50) NOT NULL CHECK (permit_type IN (
        'Zoning',
        'Conditional Use',
        'Special Use',
        'Building',
        'Environmental',
        'Utility Interconnection',
        'Other'
    )),
    jurisdiction TEXT NOT NULL,
    jurisdiction_level VARCHAR(20) CHECK (jurisdiction_level IN ('Local', 'County', 'State', 'Federal')),
    status VARCHAR(50) NOT NULL CHECK (status IN (
        'Pre-Application',
        'Application Filed',
        'Under Review',
        'Public Hearing Scheduled',
        'Approved',
        'Approved with Conditions',
        'Denied',
        'Appealed',
        'Withdrawn'
    )),
    filed_date DATE,
    decision_date DATE,
    decision_authority TEXT,
    public_hearing_date DATE,
    timeline_days INTEGER,
    approval_risk VARCHAR(20) CHECK (approval_risk IN ('Low', 'Medium', 'High', 'Unknown')),
    conditions TEXT[],
    denial_reason TEXT,
    appeal_status VARCHAR(30) CHECK (appeal_status IN (
        'Not Appealed',
        'Appeal Filed',
        'Appeal Pending',
        'Appeal Granted',
        'Appeal Denied'
    )),
    
    -- Metadata
    data_source TEXT,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Constraints
    CONSTRAINT valid_timeline CHECK (decision_date IS NULL OR filed_date IS NULL OR decision_date >= filed_date),
    CONSTRAINT timeline_calc CHECK (timeline_days IS NULL OR timeline_days >= 0)
);

-- Indexes
CREATE INDEX idx_permit_project ON rdf_permit(project_id);
CREATE INDEX idx_permit_status ON rdf_permit(status);
CREATE INDEX idx_permit_jurisdiction ON rdf_permit(jurisdiction);
CREATE INDEX idx_permit_type ON rdf_permit(permit_type);
CREATE INDEX idx_permit_risk ON rdf_permit(approval_risk) WHERE status IN ('Application Filed', 'Under Review', 'Public Hearing Scheduled');
CREATE INDEX idx_permit_timeline ON rdf_permit(filed_date, decision_date) WHERE decision_date IS NOT NULL;

-- Comments
COMMENT ON TABLE rdf_permit IS 'RDF Permitting & Process domain - tracks permit applications and approval processes';
COMMENT ON COLUMN rdf_permit.permit_id IS 'Unique permit identifier';
COMMENT ON COLUMN rdf_permit.project_id IS 'Reference to associated project in rdf_project table';
COMMENT ON COLUMN rdf_permit.timeline_days IS 'Number of days from filing to decision';
COMMENT ON COLUMN rdf_permit.approval_risk IS 'Assessed risk of permit denial';
COMMENT ON COLUMN rdf_permit.conditions IS 'Array of conditions attached to approval';
