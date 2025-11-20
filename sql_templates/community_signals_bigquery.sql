-- RDF Community & Opposition Signals Schema - BigQuery Implementation
-- Version: 1.0.0
-- Description: Public hearings, lawsuits, protests, and community engagement

CREATE TABLE `rdf_community_signals` (
    signal_id STRING NOT NULL OPTIONS(description="Unique community signal identifier"),
    project_id STRING NOT NULL OPTIONS(description="Reference to associated project"),
    signal_type STRING NOT NULL OPTIONS(description="Public Hearing | Lawsuit | Protest | Opposition Group | Petition | Media Coverage | Public Comment | Community Meeting | Other"),
    date DATE NOT NULL,
    sentiment STRING OPTIONS(description="Supportive | Opposed | Neutral | Mixed"),
    organized_opposition BOOL,
    opposition_group_name STRING,
    petition_signatures INT64,
    
    -- Hearing details (nested structure)
    hearing_details STRUCT<
        attendance INT64,
        speakers_for INT64,
        speakers_against INT64,
        duration_hours NUMERIC
    >,
    
    -- Lawsuit details (nested structure)
    lawsuit_details STRUCT<
        plaintiff STRING,
        defendant STRING,
        case_number STRING,
        court STRING,
        status STRING OPTIONS(description="Filed | Pending | Settled | Dismissed | Ruled for Plaintiff | Ruled for Defendant"),
        grounds ARRAY<STRING>
    >,
    
    -- Primary concerns
    primary_concerns ARRAY<STRING> OPTIONS(description="Visual Impact | Property Values | Noise | Health Concerns | Environmental Impact | Wildlife/Birds | Flicker | Traffic | Agricultural Land Use | Other"),
    
    -- Disinformation tracking
    disinformation_present BOOL,
    disinformation_examples ARRAY<STRING>,
    
    -- Media coverage (nested structure)
    media_coverage STRUCT<
        outlet STRING,
        headline STRING,
        url STRING,
        tone STRING OPTIONS(description="Positive | Negative | Neutral | Balanced")
    >,
    
    -- Metadata
    data_source STRING,
    last_updated TIMESTAMP
)
PARTITION BY DATE_TRUNC(date, MONTH)
CLUSTER BY signal_type, sentiment
OPTIONS(
    description="RDF Community & Opposition Signals domain - tracks public engagement, opposition, and community sentiment"
);
