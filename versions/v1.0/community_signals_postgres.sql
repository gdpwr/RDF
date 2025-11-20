-- RDF Community & Opposition Signals Schema - PostgreSQL Implementation
-- Version: 1.0.0
-- Description: Public hearings, lawsuits, protests, and community engagement

CREATE TABLE rdf_community_signals (
    signal_id VARCHAR(50) PRIMARY KEY,
    project_id VARCHAR(50) NOT NULL,
    signal_type VARCHAR(30) NOT NULL CHECK (signal_type IN (
        'Public Hearing',
        'Lawsuit',
        'Protest',
        'Opposition Group',
        'Petition',
        'Media Coverage',
        'Public Comment',
        'Community Meeting',
        'Other'
    )),
    date DATE NOT NULL,
    sentiment VARCHAR(20) CHECK (sentiment IN ('Supportive', 'Opposed', 'Neutral', 'Mixed')),
    organized_opposition BOOLEAN,
    opposition_group_name TEXT,
    petition_signatures INTEGER,
    
    -- Hearing details
    hearing_attendance INTEGER,
    hearing_speakers_for INTEGER,
    hearing_speakers_against INTEGER,
    hearing_duration_hours NUMERIC(4,2),
    
    -- Lawsuit details
    lawsuit_plaintiff TEXT,
    lawsuit_defendant TEXT,
    lawsuit_case_number VARCHAR(100),
    lawsuit_court TEXT,
    lawsuit_status VARCHAR(30) CHECK (lawsuit_status IN (
        'Filed',
        'Pending',
        'Settled',
        'Dismissed',
        'Ruled for Plaintiff',
        'Ruled for Defendant'
    )),
    lawsuit_grounds TEXT[],
    
    -- Primary concerns
    primary_concerns TEXT[],
    
    -- Disinformation tracking
    disinformation_present BOOLEAN,
    disinformation_examples TEXT[],
    
    -- Media coverage
    media_outlet TEXT,
    media_headline TEXT,
    media_url TEXT,
    media_tone VARCHAR(20) CHECK (media_tone IN ('Positive', 'Negative', 'Neutral', 'Balanced')),
    
    -- Metadata
    data_source TEXT,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_signal_project ON rdf_community_signals(project_id);
CREATE INDEX idx_signal_type ON rdf_community_signals(signal_type);
CREATE INDEX idx_signal_date ON rdf_community_signals(date);
CREATE INDEX idx_signal_sentiment ON rdf_community_signals(sentiment);
CREATE INDEX idx_signal_opposition ON rdf_community_signals(organized_opposition) WHERE organized_opposition = true;
CREATE INDEX idx_signal_lawsuit ON rdf_community_signals(lawsuit_status) WHERE signal_type = 'Lawsuit';
CREATE INDEX idx_signal_disinfo ON rdf_community_signals(disinformation_present) WHERE disinformation_present = true;
CREATE INDEX idx_signal_concerns ON rdf_community_signals USING GIN(primary_concerns);

-- Comments
COMMENT ON TABLE rdf_community_signals IS 'RDF Community & Opposition Signals domain - tracks public engagement, opposition, and community sentiment';
COMMENT ON COLUMN rdf_community_signals.signal_id IS 'Unique community signal identifier';
COMMENT ON COLUMN rdf_community_signals.project_id IS 'Reference to associated project in rdf_project table';
COMMENT ON COLUMN rdf_community_signals.organized_opposition IS 'Whether opposition is organized (group/campaign)';
COMMENT ON COLUMN rdf_community_signals.disinformation_present IS 'Whether disinformation was identified';
COMMENT ON COLUMN rdf_community_signals.primary_concerns IS 'Array of key concerns raised by community';
