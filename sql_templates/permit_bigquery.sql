-- RDF Permitting & Process Schema - BigQuery Implementation
-- Version: 1.0.0
-- Description: Permit applications, jurisdictions, status, timelines, and approval risk

CREATE TABLE `rdf_permit` (
    permit_id STRING NOT NULL OPTIONS(description="Unique permit identifier"),
    project_id STRING NOT NULL OPTIONS(description="Reference to associated project"),
    permit_type STRING NOT NULL OPTIONS(description="Zoning | Conditional Use | Special Use | Building | Environmental | Utility Interconnection | Other"),
    jurisdiction STRING NOT NULL,
    jurisdiction_level STRING OPTIONS(description="Local | County | State | Federal"),
    status STRING NOT NULL OPTIONS(description="Pre-Application | Application Filed | Under Review | Public Hearing Scheduled | Approved | Approved with Conditions | Denied | Appealed | Withdrawn"),
    filed_date DATE,
    decision_date DATE,
    decision_authority STRING,
    public_hearing_date DATE,
    timeline_days INT64 OPTIONS(description="Days from filing to decision"),
    approval_risk STRING OPTIONS(description="Low | Medium | High | Unknown"),
    conditions ARRAY<STRING> OPTIONS(description="Conditions attached to approval"),
    denial_reason STRING,
    appeal_status STRING OPTIONS(description="Not Appealed | Appeal Filed | Appeal Pending | Appeal Granted | Appeal Denied"),
    
    -- Metadata
    data_source STRING,
    last_updated TIMESTAMP
)
PARTITION BY DATE_TRUNC(filed_date, MONTH)
CLUSTER BY status, jurisdiction_level
OPTIONS(
    description="RDF Permitting & Process domain - tracks permit applications and approval processes"
);
