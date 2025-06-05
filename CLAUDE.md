# Technical Documentation - ComfyUI Node Duplicate Resolution

Internal technical documentation for the ComfyUI node duplicate resolution system.

## System Architecture

This system implements a two-phase resolution strategy:
1. **Global Priority Adjustments** - Modify `search_priority` field to globally rerank packages
2. **Specific Node Claims** - Insert into `preempted_node_names` to claim specific node names

## Database Schema

### Tables Modified
- `nodes.search_priority` - Controls package ranking (lower = higher priority)
- `preempted_node_names` - Explicit node name ownership claims

### Priority Scale
- `5` - Default/highest priority (authoritative packages)
- `6-8` - Lower priority (forks, alternatives)
- `10` - Lowest priority (test packages, deprecated)

## Caching Strategy

### API Caching
- All `api.comfy.org` calls cached in `resolution-cache.json`
- Respects rate limits and reduces API load
- Cache keys based on package ID and endpoint

### Resolution State Caching
- Manual resolution decisions persist between sessions
- Prevents re-asking same questions
- Enables iterative refinement

## Resolution Algorithms

### Automatic Resolution Criteria
1. **Download Threshold**: 3x difference in download counts
2. **Package Type Priority**: Production > Fork > Test
3. **Maintenance Status**: Active > Archived
4. **Recency**: Recent updates preferred

### Manual Resolution Heuristics
- Community adoption patterns
- Code quality indicators
- Documentation completeness
- Developer reputation metrics

## Data Processing Pipeline

### Input: `duplicate-node-names.json`
```json
{
  "name": "NodeName",
  "distinct_node_count": 3,
  "total_record_count": 15,
  "node_ids": "package1,package2,package3"
}
```

### Output: `duplicate-resolution-queries.sql`
```sql
-- Priority updates
UPDATE nodes SET search_priority = 10 WHERE id = 'test-package';

-- Node claims  
INSERT INTO preempted_node_names (node_name, node_id) VALUES ('SaveText', 'authoritative-package');
```

## Error Handling

### Common Issues
- **API Rate Limits**: Cached responses prevent repeated failures
- **Invalid Package IDs**: Validation checks before processing
- **Conflicting Resolutions**: Manual override capabilities

### Recovery Mechanisms
- `clear_bad_cache.py` - Reset corrupted cache data
- `find_discrepancy.py` - Identify data inconsistencies
- Rollback SQL provided for all changes

## Performance Optimizations

### Database Query Optimization
- Targeted table downloads (nodes, comfy_nodes, node_versions only)
- Efficient duplicate detection using EXISTS clauses
- Bulk operations for priority updates

### Memory Management
- Streaming JSON processing for large datasets
- Lazy loading of package metadata
- Garbage collection after processing phases

## Development Workflow

### Testing Resolution Logic
```bash
# Test with small subset
python resolution_engine.py --limit 10

# Verify specific conflicts
python final_verification.py --verbose

# Check cache consistency
python clear_bad_cache.py --dry-run
```

### Debugging Tools
- Verbose logging in all scripts
- JSON pretty-printing for readability
- Step-by-step resolution tracing

## Deployment Considerations

### Pre-deployment Checklist
1. Verify SQL syntax with `--dry-run` flags
2. Check resolution counts match expectations
3. Review high-impact priority changes
4. Validate node claim uniqueness

### Rollback Procedures
- All SQL changes include rollback statements
- Priority changes reversible via backup values
- Node claims removable via DELETE statements

## Monitoring & Metrics

### Success Metrics
- Resolution rate (currently 65%)
- Conflict reduction over time
- User satisfaction scores

### Alert Conditions
- Resolution rate drops below 50%
- Cache corruption detected
- API failures exceed threshold

## Integration Points

### External APIs
- `api.comfy.org` - Package metadata and download counts
- GitHub API - Repository information and activity
- Supabase API - Production database access

### Internal Systems
- ComfyUI search indexing
- Package recommendation engine
- User interface conflict detection

## Maintenance Tasks

### Regular Maintenance
- Weekly data refresh via `download-db.sh`
- Monthly resolution review and cleanup
- Quarterly algorithm tuning based on results

### Cache Management
- Cache expires after 7 days
- Manual cache clearing for corrupted data
- Backup cache before major updates

## Commands for Development

- Run linting: `python -m flake8 .` (if configured)
- Run tests: `python -m pytest .` (if configured)
- Type checking: `mypy *.py` (if configured)

## Environment Variables

Required in `.env`:
- `SUPABASE_CONNECTION_STRING` - Database connection string for data access