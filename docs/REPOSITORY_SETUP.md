# RDF Repository Setup Guide

This guide walks you through setting up the Renewable Data Framework (RDF) repository with dual-remote configuration for Bitbucket (internal) and GitHub (public).

## Overview

The RDF repository uses a dual-remote setup:
- **Bitbucket** (`origin`) → Internal canonical source of truth, integrated with CleanCast
- **GitHub** (`github`) → Public mirror for external collaboration and open-source community

## Prerequisites

- Git installed and configured with SSH keys for both Bitbucket and GitHub
- Access to GoodPower Bitbucket organization
- Access to goodpower-open GitHub organization

## Step 1: Create Both Remote Repositories

### Create Bitbucket Repository (Internal)
1. Go to Bitbucket: `https://bitbucket.org/goodpower`
2. Create new repository: `RDF`
3. Set visibility to **Private** or **Internal**
4. Do not initialize with README (we'll push from local)

### Create GitHub Repository (Public)
1. Go to GitHub: `https://github.com/goodpower-open`
2. Create new repository: `RDF`
3. Set visibility to **Public**
4. Do not initialize with README, .gitignore, or license

## Step 2: Clone and Configure Local Repository

```bash
# Clone from Bitbucket (this becomes 'origin')
git clone git@bitbucket.org:goodpower/RDF.git
cd RDF

# Add GitHub as second remote
git remote add github git@github.com:goodpower-open/RDF.git

# Verify both remotes are configured
git remote -v
# Should show:
# origin    git@bitbucket.org:goodpower/RDF.git (fetch)
# origin    git@bitbucket.org:goodpower/RDF.git (push)
# github    git@github.com:goodpower-open/RDF.git (fetch)
# github    git@github.com:goodpower-open/RDF.git (push)
```

## Step 3: Initialize Repository Content

Copy the RDF content from your CleanCast project:

```bash
# Assuming you're in the RDF directory
# Copy the prepared structure from CleanCast/RDF to this repo
cp -r /path/to/cleancast/RDF/* .

# Or manually create the structure:
mkdir -p schemas sql_templates datasets docs versions/v0.1

# Add all files
git add .
git commit -m "Initial RDF v0.1: site schema, SQL templates, sample dataset"
```

## Step 4: Push to Both Remotes

```bash
# Push to Bitbucket (internal canonical)
git push origin main

# Push to GitHub (public mirror)
git push github main
```

## Step 5: Configure Branch Protection (Optional but Recommended)

### On GitHub:
1. Go to Settings → Branches
2. Add branch protection rule for `main`
3. Enable:
   - Require pull request reviews before merging
   - Require status checks to pass before merging
   - Include administrators (optional)

### On Bitbucket:
1. Go to Repository Settings → Branch permissions
2. Add restriction for `main` branch
3. Require pull request approvals

## Day-to-Day Workflow

### Making Changes (Internal Work)

```bash
# Work on your local clone
git checkout -b feature/new-schema
# Make changes...
git add .
git commit -m "Add Permitting domain schema v0.2"

# Push to Bitbucket for review
git push origin feature/new-schema
# Create PR in Bitbucket

# After PR is approved and merged to main:
git checkout main
git pull origin main

# Mirror to GitHub
git push github main
```

### Using the Sync Script

Use the included `sync_github.sh` script to push to both remotes:

```bash
./sync_github.sh
```

This will:
1. Push main branch to both Bitbucket and GitHub
2. Push all tags to both remotes
3. Keep both repositories in sync

## Step 6: Integrate with CleanCast (Bitbucket)

### Option A: Git Submodule (Recommended)

From your CleanCast repository:

```bash
cd /path/to/cleancast
git submodule add git@bitbucket.org:goodpower/RDF.git rdf
git commit -m "Add RDF as submodule"
git push
```

To update CleanCast when RDF changes:

```bash
cd /path/to/cleancast/rdf
git fetch origin
git checkout main
git pull
cd ..
git add rdf
git commit -m "Update RDF submodule to latest main"
git push
```

### Option B: Vendor the Schemas

Use CI/CD to copy schemas at build time (more advanced).

## Handling External Contributions from GitHub

When external partners submit PRs on GitHub:

```bash
# Pull the merged changes from GitHub
git checkout main
git pull github main

# Push to Bitbucket to sync
git push origin main
```

Now both remotes are in sync, and CleanCast (which depends on Bitbucket) sees the latest changes.

## Tagging Releases

When releasing a new version:

```bash
# Create annotated tag
git tag -a v0.1 -m "RDF v0.1 - Initial Site Identification schema"

# Push tag to both remotes
git push origin v0.1
git push github v0.1

# Or use the sync script which handles tags automatically
./sync_github.sh
```

## Troubleshooting

### Permission Denied
- Ensure SSH keys are configured for both Bitbucket and GitHub
- Test connections: `ssh -T git@bitbucket.org` and `ssh -T git@github.com`

### Remotes Out of Sync
```bash
# Force sync GitHub to match Bitbucket
git push github main --force

# Only use --force when you're certain Bitbucket is the source of truth
```

### Forgot to Push to GitHub
```bash
# Check what's in Bitbucket but not in GitHub
git log github/main..origin/main

# Push the difference
git push github main
```

## Security Notes

- Never push sensitive credentials or internal CleanCast data to GitHub
- Review changes carefully before pushing to the public GitHub repository
- Use `.gitignore` to exclude any sensitive files
- Consider setting up automated CI checks before mirroring to GitHub

## Next Steps

- Set up Bitbucket Pipelines for automated mirroring (see `bitbucket-pipelines.yml`)
- Establish RDF Working Group for governance
- Create documentation for external partners on how to contribute
