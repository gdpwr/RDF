-- RDF Legislation & Policy Schema - BigQuery Implementation
-- Version: 1.0.0
-- Description: Bills, ordinances, jurisdictions, sponsors, and legislative stages

CREATE TABLE `rdf_legislation` (
    legislation_id STRING NOT NULL OPTIONS(description="Unique identifier (e.g., OH-SB52-2021)"),
    jurisdiction STRING NOT NULL,
    jurisdiction_level STRING OPTIONS(description="Federal | State | County | Municipal"),
    title STRING NOT NULL,
    legislation_type STRING OPTIONS(description="Bill | Ordinance | Resolution | Regulation | Executive Order | Moratorium | Ban | Other"),
    impact_on_renewables STRING OPTIONS(description="Supportive | Restrictive | Neutral | Mixed"),
    status STRING NOT NULL OPTIONS(description="Proposed | In Committee | Floor Vote Scheduled | Passed | Enacted | Vetoed | Failed | Repealed"),
    introduced_date DATE,
    enacted_date DATE,
    effective_date DATE,
    expiration_date DATE OPTIONS(description="Expiration date for moratoria and temporary bans"),
    
    -- Sponsors (nested structure)
    sponsors ARRAY<STRUCT<
        name STRING,
        party STRING,
        role STRING OPTIONS(description="Primary Sponsor | Co-Sponsor")
    >>,
    
    key_provisions ARRAY<STRING>,
    
    -- Setback requirements
    setback_distance_feet INT64,
    setback_from_structure STRING,
    veto_power BOOL OPTIONS(description="Whether local governments can veto projects"),
    
    -- Metadata
    data_source STRING,
    last_updated TIMESTAMP
)
PARTITION BY DATE_TRUNC(effective_date, YEAR)
CLUSTER BY jurisdiction_level, impact_on_renewables
OPTIONS(
    description="RDF Legislation & Policy domain - tracks bills, ordinances, and regulations affecting renewable energy"
);
