-- RDF Project Execution Schema - BigQuery Implementation
-- Version: 1.0.0
-- Description: Project identity, developer, capacity, milestones, and operational status

CREATE TABLE `rdf_project` (
    project_id STRING NOT NULL OPTIONS(description="Unique project identifier (e.g., TX-ERCOT-001)"),
    project_name STRING NOT NULL,
    technology_type STRING NOT NULL OPTIONS(description="Solar PV | Wind | BESS | Hybrid | Other"),
    nameplate_capacity_mw NUMERIC NOT NULL OPTIONS(description="Total installed capacity in megawatts"),
    developer_company STRING,
    current_status STRING NOT NULL OPTIONS(description="Pre-Development | Permitting | Permitted | Under Construction | Operational | Decommissioned | Canceled | Withdrawn"),
    status_date DATE,
    expected_cod DATE OPTIONS(description="Expected Commercial Operation Date"),
    actual_cod DATE OPTIONS(description="Actual Commercial Operation Date"),
    
    -- Milestones
    site_control_date DATE,
    permit_filed_date DATE,
    permit_approved_date DATE,
    construction_start_date DATE,
    substantial_completion_date DATE,
    
    -- Cancellation tracking
    cancellation_reason STRING OPTIONS(description="Permit Denied | Community Opposition | Interconnection Costs | Economics | Developer Decision | Other"),
    
    -- Metadata
    data_source STRING,
    last_updated TIMESTAMP OPTIONS(description="When this record was last updated")
)
PARTITION BY DATE_TRUNC(expected_cod, YEAR)
CLUSTER BY technology_type, current_status
OPTIONS(
    description="RDF Project Execution domain - tracks renewable energy projects through development lifecycle"
);
