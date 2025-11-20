-- Renewable Data Framework (RDF) v0.1 – Site Identification (PostgreSQL with PostGIS)
-- Founded by GoodPower, led by Roger Lopez
-- 
-- This SQL template creates the RDF Sites table for PostgreSQL with PostGIS support.
-- Requires PostGIS extension for geographic data types.

-- Enable PostGIS if not already enabled
CREATE EXTENSION IF NOT EXISTS postgis;

-- Create the RDF Sites table
CREATE TABLE rdf_sites (
    site_id UUID PRIMARY KEY,
    location_point GEOGRAPHY(Point, 4326) NOT NULL,
    location_geometry GEOGRAPHY(Polygon, 4326),
    land_use_type TEXT NOT NULL,
    ownership_type TEXT NOT NULL,
    transmission_distance_km NUMERIC,
    transmission_capacity_mw NUMERIC,
    environmental_overlays TEXT[],
    community_impact_score INTEGER CHECK (community_impact_score BETWEEN 0 AND 100),
    data_source TEXT,
    last_updated TIMESTAMP DEFAULT now()
);

-- Create spatial index for efficient geographic queries
CREATE INDEX idx_rdf_sites_location_point ON rdf_sites USING GIST (location_point);
CREATE INDEX idx_rdf_sites_location_geometry ON rdf_sites USING GIST (location_geometry);

-- Create indexes for common query patterns
CREATE INDEX idx_rdf_sites_land_use ON rdf_sites (land_use_type);
CREATE INDEX idx_rdf_sites_ownership ON rdf_sites (ownership_type);

-- Add comments for documentation
COMMENT ON TABLE rdf_sites IS 'Renewable Data Framework (RDF) v0.1 - Site Identification';
COMMENT ON COLUMN rdf_sites.site_id IS 'Unique identifier for the site';
COMMENT ON COLUMN rdf_sites.location_point IS 'Geographic coordinates of site center point';
COMMENT ON COLUMN rdf_sites.location_geometry IS 'GeoJSON geometry representing site boundary';
COMMENT ON COLUMN rdf_sites.land_use_type IS 'Primary land use classification';
COMMENT ON COLUMN rdf_sites.ownership_type IS 'Ownership classification';
COMMENT ON COLUMN rdf_sites.transmission_distance_km IS 'Distance to nearest transmission infrastructure in kilometers';
COMMENT ON COLUMN rdf_sites.transmission_capacity_mw IS 'Capacity of nearest transmission line in megawatts';
COMMENT ON COLUMN rdf_sites.environmental_overlays IS 'Environmental constraints or features';
COMMENT ON COLUMN rdf_sites.community_impact_score IS 'Quantitative assessment of community impact (0-100)';
COMMENT ON COLUMN rdf_sites.data_source IS 'Source of the data';
COMMENT ON COLUMN rdf_sites.last_updated IS 'Timestamp of last data update';
