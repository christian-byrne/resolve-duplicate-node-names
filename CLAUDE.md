# ComfyUI Node Duplicate Resolution Project

This repository contains tools and data for identifying and resolving duplicate node names in the ComfyUI ecosystem.

## Current Status

 **Data Collection Complete**
- Downloaded 211MB of node data from production database
- Identified 957 duplicate node names across different packages
- Added 243 new duplicates to the existing dataset

 **Duplicate Detection**
- Exact name matches across different node_ids
- Results stored in `duplicate-node-names.json`
- Sorted by number of conflicting packages (highest priority first)

## Core Files

### Data Files
- `duplicate-node-names.json` - Main database of all identified duplicates (957 entries)
- `nodes_data.sql` - Local copy of relevant database tables (211MB)
- `duplicate-resolution-results.json` - Resolution decisions and results
- `resolution-cache.json` - Cached resolution decisions

### Analysis Scripts
- `analyze_priority_impact.py` - Analyzes impact and priority of duplicates
- `analyze_resolution_status.py` - Tracks resolution progress
- `analyze_resolvable_duplicates.py` - Identifies automatically resolvable conflicts
- `final_verification.py` - Verifies resolution results
- `find_discrepancy.py` - Finds inconsistencies in data

### Resolution Scripts
- `resolution_engine.py` - Main resolution logic and algorithms
- `manual_resolver.py` - Interactive manual resolution tool
- `simple_resolver.py` - Basic automated resolution
- `resolve_remaining.py` - Handles remaining unresolved conflicts

### Utilities
- `download-db.sh` - Downloads node data from production database
- `clear_bad_cache.py` - Cleans invalid cached resolutions

### Documentation
- `process-raw-human-text.md` - Manual resolution guidance
- `openapi.yml` - API specification for resolution services

## Data Structure

Each duplicate entry contains:
```json
{
  "name": "NodeName",
  "distinct_node_count": 3,
  "total_record_count": 15,
  "node_ids": "package1,package2,package3"
}
```

## Usage

1. **Download latest data**: `./download-db.sh`
2. **Analyze duplicates**: `python analyze_priority_impact.py`
3. **Resolve conflicts**: `python resolution_engine.py`
4. **Verify results**: `python final_verification.py`

## Commands

- Run linting: `python -m flake8 .` (if configured)
- Run tests: `python -m pytest .` (if configured)

## Environment Variables

Required in `.env`:
- `SUPABASE_CONNECTION_STRING` - Database connection string for data access