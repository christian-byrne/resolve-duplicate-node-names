# ComfyUI Node Duplicate Resolution

This repository provides a complete workflow for identifying and resolving duplicate node names in the ComfyUI ecosystem. When multiple packages define nodes with the same name, users experience conflicts and confusion. This system systematically resolves these conflicts through prioritization and name claiming.

## 🎯 Problem Statement

Multiple ComfyUI packages often define nodes with identical names (e.g., "SaveText", "LoadImage", "StringReplace"), causing:
- User confusion about which package provides which functionality
- Search result conflicts in the ComfyUI interface
- Installation conflicts between packages

## 📊 Current Status

- **957 duplicate node names** identified across different packages
- **464 conflicts resolved** (65% resolution rate) through automated and manual processes
- **250 conflicts remaining** for future resolution

## 🔄 Complete Workflow

### Stage 1: Data Collection
```bash
# Download latest node data from production database
./download-db.sh
```
**Generates**: `nodes_data.sql` (211MB of node/package data)

### Stage 2: Duplicate Detection
Automated SQL queries identify exact node name matches across different packages.

**Output**: `duplicate-node-names.json` containing 957 duplicate entries
```json
{
  "name": "SaveText",
  "distinct_node_count": 3,
  "total_record_count": 15,
  "node_ids": "package1,package2,package3"
}
```

### Stage 3: Analysis & Prioritization
Run analysis scripts to understand conflict scope and impact:

```bash
# Analyze which packages cause the most conflicts
python analyze_priority_impact.py

# Identify automatically resolvable conflicts  
python analyze_resolvable_duplicates.py

# Check current resolution progress
python analyze_resolution_status.py
```

### Stage 4: Resolution Strategy

The system resolves conflicts through two complementary mechanisms:

#### 4a. Search Priority Changes (326 conflicts resolved)
Globally adjust package search rankings:
- **Test packages**: Set priority to 10 (lowest ranking)
- **Fork packages**: Set priority to 6-8 (lower than originals)
- **Authoritative packages**: Keep priority 5 (default/highest)

#### 4b. Node Name Claiming (138 additional nodes resolved)
Assign specific node names to authoritative packages:
- "OllamaGenerate" → claimed by "comfyui-ollama"
- "ShowText" → claimed by "comfyui-show-text"
- etc.

### Stage 5: Resolution Tools

#### Automated Resolution
```bash
# Use download count heuristics (3x difference threshold)
python simple_resolver.py
```

#### Manual Resolution
```bash
# Interactive tool for complex conflicts requiring human judgment
python manual_resolver.py
```

#### Final Cleanup
```bash
# Handle remaining edge cases
python resolve_remaining.py
```

### Stage 6: Generate Database Updates
```bash
# Analyze resolutions and determine what's actually resolved
python resolution_engine.py
```

**Generates**: `duplicate-resolution-queries.sql` with production-ready SQL:
- UPDATE statements for search priority changes
- INSERT statements for node name claims
- Verification queries

### Stage 7: Verification
```bash
# Validate resolution counts match expectations
python final_verification.py
```

### Stage 8: Database Deployment
Execute the generated SQL against production database:
```sql
-- Updates nodes.search_priority field
-- Inserts into preempted_node_names table
-- Includes verification queries for safety
```

## 📁 File Structure

### Core Data Files
- `duplicate-node-names.json` - All identified duplicates (957 entries)
- `nodes_data.sql` - Local copy of production database (211MB)
- `duplicate-resolution-results.json` - Final resolution summary
- `duplicate-resolution-queries.sql` - Production-ready SQL updates

### Resolution State
- `resolution-cache.json` - All resolution decisions and API cache
- `unresolved_conflicts.json` - Remaining conflicts after processing

### Scripts by Purpose

**Data Collection**
- `download-db.sh` - Download latest data from Supabase

**Analysis**
- `analyze_priority_impact.py` - Impact analysis
- `analyze_resolution_status.py` - Progress tracking  
- `analyze_resolvable_duplicates.py` - Auto-resolution identification

**Resolution Tools**
- `resolution_engine.py` - Main resolution logic
- `simple_resolver.py` - Automated resolution via heuristics
- `manual_resolver.py` - Interactive manual resolution
- `resolve_remaining.py` - Final cleanup

**Utilities**
- `final_verification.py` - Validates results
- `clear_bad_cache.py` - Cache management
- `find_discrepancy.py` - Data consistency checks

**Documentation**
- `process-raw-human-text.md` - Manual resolution guidelines
- `openapi.yml` - API specification

## 🚀 Quick Start

1. **Setup Environment**
   ```bash
   # Create .env file with database connection
   echo "SUPABASE_CONNECTION_STRING=postgres://..." > .env
   ```

2. **Run Full Pipeline**
   ```bash
   # Download latest data
   ./download-db.sh
   
   # Analyze conflicts
   python analyze_priority_impact.py
   
   # Run automated resolution
   python simple_resolver.py
   
   # Handle remaining conflicts manually
   python manual_resolver.py
   
   # Generate SQL updates
   python resolution_engine.py
   
   # Verify results
   python final_verification.py
   ```

3. **Deploy to Production**
   ```bash
   # Review generated SQL
   cat duplicate-resolution-queries.sql
   
   # Execute against production database
   psql $SUPABASE_CONNECTION_STRING -f duplicate-resolution-queries.sql
   ```

## 💡 Resolution Logic

### Automatic Resolution Criteria
- **3x Download Difference**: Package with 3x+ more downloads wins
- **Test vs Production**: Production packages always win over test packages
- **Original vs Fork**: Original repositories win over forks
- **Recency**: More recently updated packages preferred

### Manual Resolution Factors
- Package popularity and community adoption
- Code quality and maintenance status
- Feature completeness and documentation
- Developer reputation and project stability

## 📈 Results Summary

| Metric | Count | Percentage |
|--------|-------|------------|
| Total Duplicates | 957 | 100% |
| Resolved via Priority | 326 | 34% |
| Resolved via Claims | 138 | 14% |
| **Total Resolved** | **464** | **48%** |
| Remaining Conflicts | 493 | 52% |

## 🔧 Configuration

### Required Environment Variables
```bash
SUPABASE_CONNECTION_STRING=postgres://user:pass@host:port/db
```

### Cache Management
- Resolution decisions cached in `resolution-cache.json`
- API calls cached to respect rate limits
- Clear cache with `python clear_bad_cache.py`

## 🤝 Contributing

1. Run analysis scripts to understand current state
2. Use manual resolver for complex conflicts
3. Test resolution logic with verification scripts
4. Update documentation for new processes

## 📚 Additional Resources

- [Manual Resolution Guidelines](process-raw-human-text.md)
- [API Documentation](openapi.yml)
- [Project Technical Details](CLAUDE.md)