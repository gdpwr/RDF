# 🌍 Renewable Data Framework (RDF)

The **Renewable Data Framework (RDF)** is the first open-source standard for renewable energy siting and permitting data.  
It provides a **common language** across the full clean energy lifecycle — from **site identification** to **permitting**, **legislation**, **project execution**, and **community signals**.

RDF is founded by **GoodPower**, convened by **Roger Lopez (Chief Growth & Data Officer)**, and developed collaboratively with the clean energy ecosystem.

---

## 📖 Mission
Enable collaboration, transparency, and acceleration of clean energy deployment by creating an **open, modular, interoperable data framework**.

---

## 🧩 Core Domains
- **Site Identification** → location, land use, transmission, environmental overlays.
- **Permitting & Process** → permit type, jurisdiction, status, timeline, risk.
- **Legislation & Policy** → bills, jurisdictions, sponsors, stages.
- **Project Execution** → developer, capacity (MW), milestones, operational status.
- **Community & Opposition Signals** → hearings, lawsuits, protests, disinformation.

---

## ⚙️ Technical Starting Point
- **Schemas** in JSON/GeoJSON format.
- **SQL templates** for Postgres, BigQuery, and Snowflake.
- **Sample datasets** (GeoJSON/CSV) to demonstrate real-world use.
- **Versioning** using semantic versioning (v0.1 → v1.0).

---

## 🏗️ Current Status
**RDF v1.0** is now available with schemas for all 5 core domains:
- ✅ **Site Identification** → `schemas/site.schema.json`
- ✅ **Permitting & Process** → `schemas/permit.schema.json`
- ✅ **Legislation & Policy** → `schemas/legislation.schema.json`
- ✅ **Project Execution** → `schemas/project.schema.json`
- ✅ **Community & Opposition Signals** → `schemas/community_signals.schema.json`

## 📅 Roadmap
- **2025 Q4** ✅ RDF v1.0 release (all 5 core domains).
- **2026 H1** → Add SQL templates for all domains, expand sample datasets.
- **2026 H2** → Convene RDF Working Group, community adoption.
- **2027** → RDF v2.0 with advanced domains (interconnection, economics, construction).

---

## 📜 Licensing
- **MIT License** → Schema definitions.
- **CC BY 4.0** → Documentation & datasets.

---

## 👥 Attribution
RDF was **founded by GoodPower** and **led by Roger Lopez** as part of GoodPower's mission to accelerate a decarbonized economy.  

See [AUTHORS.md](AUTHORS.md) for full credits and contributors.
