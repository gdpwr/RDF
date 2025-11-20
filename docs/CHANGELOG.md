# Changelog – Renewable Data Framework (RDF)

## v1.0.0 (November 2024)
### Added - All 5 Core Domains
- **Site Identification** schema (`site.schema.json`) - location, land use, transmission, environmental overlays
- **Permitting & Process** schema (`permit.schema.json`) - permit types, jurisdictions, status, timelines, approval risk
- **Legislation & Policy** schema (`legislation.schema.json`) - bills, ordinances, sponsors, legislative stages
- **Project Execution** schema (`project.schema.json`) - developer info, capacity (MW), milestones, operational status
- **Community & Opposition Signals** schema (`community_signals.schema.json`) - hearings, lawsuits, protests, organized opposition

### Changed
- Expanded from v0.1 (Site only) to v1.0 (all 5 core domains)
- Updated README to reflect v1.0 status
- Replaced proprietary sample data with generic dummy data

### Security
- Removed GoodPower proprietary datasets from public repository
- Added .gitignore rules to protect internal research and analysis

## v0.1 (September 2025)
- Initial release of RDF framework
- Added `Site Identification` schema in JSON + SQL
- Published sample dataset (county-level GeoJSON)
- Established governance and attribution model
