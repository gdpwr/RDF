-- Renewable Data Framework (RDF) v0.1 – Site Identification (BigQuery with GIS)
-- Founded by GoodPower, led by Roger Lopez
-- 
-- This SQL template creates the RDF Sites table for Google BigQuery with GIS support.
-- BigQuery natively supports GEOGRAPHY types for spatial data.

CREATE TABLE `rdf.sites` (
  site_id STRING NOT NULL OPTIONS(description="Unique identifier for the site"),
  location_point GEOGRAPHY NOT NULL OPTIONS(description="Geographic coordinates of site center point"),
  location_geometry GEOGRAPHY OPTIONS(description="GeoJSON geometry representing site boundary"),
  land_use_type STRING NOT NULL OPTIONS(description="Primary land use classification"),
  ownership_type STRING NOT NULL OPTIONS(description="Ownership classification"),
  transmission_distance_km FLOAT64 OPTIONS(description="Distance to nearest transmission infrastructure in kilometers"),
  transmission_capacity_mw FLOAT64 OPTIONS(description="Capacity of nearest transmission line in megawatts"),
  environmental_overlays ARRAY<STRING> OPTIONS(description="Environmental constraints or features"),
  community_impact_score INT64 OPTIONS(description="Quantitative assessment of community impact (0-100)"),
  data_source STRING OPTIONS(description="Source of the data"),
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP() OPTIONS(description="Timestamp of last data update")
)
PARTITION BY DATE(last_updated)
CLUSTER BY land_use_type, ownership_type
OPTIONS(
  description="Renewable Data Framework (RDF) v0.1 - Site Identification",
  labels=[("framework", "rdf"), ("version", "v0_1"), ("domain", "site_identification")]
);

-- Example query: Find sites within 5km of a point
-- SELECT site_id, land_use_type, ownership_type
-- FROM `rdf.sites`
-- WHERE ST_DISTANCE(location_point, ST_GEOGPOINT(-118.25, 34.05)) <= 5000;

-- Example query: Find sites with specific environmental overlays
-- SELECT site_id, environmental_overlays
-- FROM `rdf.sites`
-- WHERE 'wetlands' IN UNNEST(environmental_overlays);
