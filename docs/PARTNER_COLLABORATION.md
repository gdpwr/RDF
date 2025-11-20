# Partner Collaboration Guide for RDF

## Overview

This guide explains how external partners can collaborate on the Renewable Data Framework (RDF) using GitHub, without needing access to GoodPower's internal systems.

## What is RDF?

The Renewable Data Framework (RDF) is an open standard for structuring and sharing data about clean energy projects across their full lifecycle:
- **Site identification** → permitting → legislation → project execution → community signals
- **Multi-organization collaboration** → developers, NGOs, researchers, policymakers
- **Open source** → public GitHub repository for transparency and community contribution

## How to Use RDF

### 1. **Download and Implement**

You can immediately start using RDF in your systems:

```bash
# Clone the public repository
git clone https://github.com/goodpower-open/RDF.git

# Navigate to schemas
cd RDF/schemas
```

**What you'll find:**
- **JSON Schema definitions** → Define data structure for sites, permits, projects
- **SQL templates** → PostgreSQL, BigQuery, Snowflake implementations
- **Sample datasets** → GeoJSON/CSV examples showing RDF in action
- **Documentation** → Field descriptions, usage guides, implementation examples

### 2. **Map Your Data to RDF**

Align your existing databases to RDF formats:

**Example: Mapping site data**
```json
{
  "site_id": "your-internal-id",
  "location_point": [-118.25, 34.05],
  "land_use_type": "agricultural",
  "ownership_type": "private",
  "transmission_distance_km": 2.5
}
```

### 3. **Build Tools on RDF**

- Create dashboards and visualizations
- Build APIs that export/import RDF-formatted data
- Develop analysis tools using the standard schema
- Share data with partners using a common format

## How to Contribute

### GitHub Workflow

All collaboration happens through GitHub using standard open-source practices:

#### **Step 1: Fork the Repository**

```bash
# On GitHub.com, click "Fork" on goodpower-open/RDF
# This creates your personal copy: yourname/RDF
```

#### **Step 2: Clone Your Fork**

```bash
git clone https://github.com/yourname/RDF.git
cd RDF
```

#### **Step 3: Create a Branch**

```bash
# Create a descriptive branch name
git checkout -b feature/add-permitting-schema
# or
git checkout -b fix/clarify-land-use-types
```

#### **Step 4: Make Your Changes**

Examples of valuable contributions:
- **New schema domains** (e.g., permitting, legislation)
- **Field additions** to existing schemas
- **Documentation improvements**
- **Sample datasets** from your organization
- **SQL template enhancements**
- **Bug fixes or clarifications**

#### **Step 5: Commit and Push**

```bash
git add .
git commit -m "Add permitting schema with jurisdiction fields"
git push origin feature/add-permitting-schema
```

#### **Step 6: Open a Pull Request**

1. Go to https://github.com/goodpower-open/RDF
2. Click "Pull Requests" → "New Pull Request"
3. Select "compare across forks"
4. Choose your fork and branch
5. Write a clear description:
   - What you changed
   - Why it's useful
   - How it fits into RDF's mission

**Example PR description:**
```
## Add Permitting Schema v0.2

### Changes
- New permit.schema.json with jurisdiction, status, timeline fields
- PostgreSQL template for permit tracking
- Sample dataset from 3 counties

### Rationale
Permitting is a critical bottleneck in clean energy deployment.
This schema captures the key data points needed to track and 
analyze permit processes across jurisdictions.

### Testing
- Validated against our internal permit database (1,200 records)
- Tested SQL template on PostgreSQL 14+
```

### Review Process

1. **Initial Review** → RDF maintainers review for completeness
2. **Community Discussion** → Other contributors provide feedback
3. **Working Group Review** → Multi-org governance body approves major changes
4. **Merge** → Changes are incorporated into main branch
5. **Release** → Included in next version (v0.2, v0.3, v1.0)

## Ways to Contribute (Without Coding)

### GitHub Issues

Open issues to:
- **Propose new features** → "Add support for community opposition signals"
- **Report problems** → "Field X definition is ambiguous"
- **Ask questions** → "How should we represent multi-phase projects?"
- **Share use cases** → "We need to track legislative bill status"

**Example issue:**
```
Title: Add support for multi-phase project timelines

We track projects that have 3 phases: development, construction, operation.
Current RDF schema doesn't support phase-specific milestones. 

Proposed solution:
- Add "project_phases" array field
- Each phase has: name, start_date, end_date, status, milestones

Would this fit RDF's design philosophy?
```

### Discussions

Participate in GitHub Discussions for:
- Design decisions
- Best practices
- Implementation questions
- Cross-organization coordination

## Licensing

### Your Contributions

When you submit a PR, you agree that:
- **Schema contributions** → MIT License (very permissive)
- **Documentation/datasets** → CC BY 4.0 (requires attribution)

### Using RDF

You can:
- ✅ Use RDF schemas in commercial products
- ✅ Modify schemas for your needs
- ✅ Share data in RDF format
- ✅ Build proprietary tools using RDF

You must:
- 📋 Provide attribution: "Uses Renewable Data Framework (RDF), founded by GoodPower, led by Roger Lopez"

## Release Cycle

- **Minor releases** → Every 6 months (v0.1, v0.2, v0.3)
- **Major releases** → Every 18-24 months (v1.0, v2.0)
- **Process** → Draft → Public Comment → Working Group Approval → Release

### Semantic Versioning

- **v0.1 → v0.2** → New fields added, backward compatible
- **v1.0 → v2.0** → Breaking changes, migration guide provided

## Getting Help

### Documentation
- Read `/docs/README.md` for overview
- Check schema comments for field definitions
- Review sample datasets for examples

### Community Support
- **GitHub Issues** → Technical questions
- **GitHub Discussions** → Design discussions
- **Email** → psc.contact@psc.ky.gov (for governance questions)

### Best Practices

**Do:**
- ✅ Start small (fix typos, add examples)
- ✅ Open an issue before big changes
- ✅ Include examples and documentation
- ✅ Test your changes with real data
- ✅ Follow existing schema patterns

**Don't:**
- ❌ Submit PRs without discussion for major changes
- ❌ Break backward compatibility without approval
- ❌ Include proprietary or sensitive data
- ❌ Make changes that benefit only your organization

## Real-World Example: Contributing a Permit Schema

Let's walk through a complete contribution:

### 1. Research & Proposal

```bash
# Open an issue first
Title: Proposal - Add Permitting Schema
Body: 
We've analyzed permit data from 50 counties and identified
20 core fields needed to track clean energy permits effectively.
Before creating a full PR, wanted to validate the approach.

Attached: draft field list, sample data
```

### 2. Implementation

```bash
# Fork and clone
git clone https://github.com/yourname/RDF.git
cd RDF
git checkout -b feature/permitting-schema

# Create files
vim schemas/permit.schema.json
vim sql_templates/permit_postgres.sql
vim datasets/sample_permits.geojson

# Test locally
python tools/validate_schema.py schemas/permit.schema.json
```

### 3. Documentation

```bash
# Update changelog
vim docs/CHANGELOG.md

## v0.2 (Pending)
- Added Permitting domain schema
- New fields: permit_type, jurisdiction, status, timeline
- 50-county dataset included
```

### 4. Submit PR

```bash
git add .
git commit -m "Add permitting schema v0.2 with 50-county validation"
git push origin feature/permitting-schema

# Open PR on GitHub with detailed description
```

### 5. Iterate

```
Maintainer comment: "Great work! Can you add a 'risk_score' field?"
You respond: "Added in commit abc123"
Working Group: "Approved for v0.2 release"
```

### 6. Celebrate

```
Your contribution is now part of RDF v0.2!
It will help accelerate clean energy deployment across the ecosystem.
```

## Code of Conduct

- **Be respectful** → Diverse perspectives strengthen RDF
- **Be collaborative** → We're building this together
- **Be mission-focused** → Every change should accelerate clean energy
- **Be transparent** → Document decisions and rationale
- **Be patient** → Governance takes time but ensures quality

## FAQ

**Q: Do I need permission to use RDF?**  
A: No! It's open source (MIT/CC BY). Use it freely.

**Q: Can I modify RDF for my internal use?**  
A: Yes! You can fork and customize without contributing back.

**Q: How do I know if my contribution will be accepted?**  
A: Open an issue first to discuss. Align with RDF's mission and design principles.

**Q: What if I disagree with a decision?**  
A: Voice concerns in GitHub. Governance is transparent. You can always fork.

**Q: Can I join the RDF Working Group?**  
A: Yes! Active contributors are invited to join governance discussions.

**Q: Is there a mailing list or Slack?**  
A: Currently GitHub is the primary communication channel. We may add more as community grows.

**Q: How do I report security issues?**  
A: Email psc.contact@psc.ky.gov directly (do not open public issue).

---

## Summary: Your Path to Contributing

1. **Start using RDF** → Download, implement in your systems
2. **Identify gaps** → What's missing for your use case?
3. **Open an issue** → Propose your idea, get feedback
4. **Fork & code** → Make your changes in your fork
5. **Submit PR** → Clear description, examples, tests
6. **Iterate** → Respond to feedback, refine
7. **Merge** → Your contribution helps the entire ecosystem!

**Thank you for helping build the future of clean energy data!**

---

*Renewable Data Framework (RDF)*  
*Founded by GoodPower | Led by Roger Lopez*  
*https://github.com/goodpower-open/RDF*
