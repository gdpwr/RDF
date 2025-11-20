-- RDF Legislation & Policy Schema - PostgreSQL Implementation
-- Version: 1.0.0
-- Description: Bills, ordinances, jurisdictions, sponsors, and legislative stages

CREATE TABLE rdf_legislation (
    legislation_id VARCHAR(50) PRIMARY KEY,
    jurisdiction TEXT NOT NULL,
    jurisdiction_level VARCHAR(20) CHECK (jurisdiction_level IN ('Federal', 'State', 'County', 'Municipal')),
    title TEXT NOT NULL,
    legislation_type VARCHAR(30) CHECK (legislation_type IN (
        'Bill',
        'Ordinance',
        'Resolution',
        'Regulation',
        'Executive Order',
        'Moratorium',
        'Ban',
        'Other'
    )),
    impact_on_renewables VARCHAR(20) CHECK (impact_on_renewables IN ('Supportive', 'Restrictive', 'Neutral', 'Mixed')),
    status VARCHAR(30) NOT NULL CHECK (status IN (
        'Proposed',
        'In Committee',
        'Floor Vote Scheduled',
        'Passed',
        'Enacted',
        'Vetoed',
        'Failed',
        'Repealed'
    )),
    introduced_date DATE,
    enacted_date DATE,
    effective_date DATE,
    expiration_date DATE,
    key_provisions TEXT[],
    setback_distance_feet INTEGER,
    setback_from_structure TEXT,
    veto_power BOOLEAN,
    
    -- Metadata
    data_source TEXT,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Constraints
    CONSTRAINT valid_dates CHECK (
        (enacted_date IS NULL OR introduced_date IS NULL OR enacted_date >= introduced_date) AND
        (effective_date IS NULL OR enacted_date IS NULL OR effective_date >= enacted_date)
    )
);

-- Sponsors table (one-to-many relationship)
CREATE TABLE rdf_legislation_sponsors (
    id SERIAL PRIMARY KEY,
    legislation_id VARCHAR(50) NOT NULL REFERENCES rdf_legislation(legislation_id) ON DELETE CASCADE,
    sponsor_name TEXT NOT NULL,
    party VARCHAR(50),
    role VARCHAR(20) CHECK (role IN ('Primary Sponsor', 'Co-Sponsor')),
    
    UNIQUE(legislation_id, sponsor_name)
);

-- Indexes
CREATE INDEX idx_legislation_jurisdiction ON rdf_legislation(jurisdiction);
CREATE INDEX idx_legislation_level ON rdf_legislation(jurisdiction_level);
CREATE INDEX idx_legislation_status ON rdf_legislation(status);
CREATE INDEX idx_legislation_impact ON rdf_legislation(impact_on_renewables);
CREATE INDEX idx_legislation_type ON rdf_legislation(legislation_type);
CREATE INDEX idx_legislation_effective ON rdf_legislation(effective_date) WHERE status = 'Enacted';
CREATE INDEX idx_legislation_moratorium ON rdf_legislation(expiration_date) WHERE legislation_type IN ('Moratorium', 'Ban');
CREATE INDEX idx_sponsors_legislation ON rdf_legislation_sponsors(legislation_id);

-- Comments
COMMENT ON TABLE rdf_legislation IS 'RDF Legislation & Policy domain - tracks bills, ordinances, and regulations affecting renewable energy';
COMMENT ON COLUMN rdf_legislation.legislation_id IS 'Unique identifier (e.g., OH-SB52-2021)';
COMMENT ON COLUMN rdf_legislation.veto_power IS 'Whether local governments can veto projects (e.g., Ohio SB52)';
COMMENT ON COLUMN rdf_legislation.setback_distance_feet IS 'Required setback distance from structures';
COMMENT ON TABLE rdf_legislation_sponsors IS 'Legislators who sponsored or co-sponsored the legislation';
