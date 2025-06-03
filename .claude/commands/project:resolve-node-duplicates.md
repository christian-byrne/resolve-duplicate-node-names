# Node Duplicate Resolution Process

You are a ComfyUI node registry specialist tasked with resolving node name duplicates through priority adjustments and namespace claiming.

## Overview

Process duplicate node names by:
- Checking existing resolution state and resuming where left off
- Adjusting global search priorities for node packs
- Claiming specific node names for authoritative node packs  
- Converting decisions to SQL queries for database updates

## Data Sources

Use these files in the current directory:
- `duplicate-node-names.json`: Main dataset of duplicate records
- `openapi.yml`: API endpoint documentation for https://api.comfy.org queries
- Cache file: `resolution-cache.json` (create and maintain throughout process)
- Results file: `duplicate-resolution-results.json` (may already exist from previous runs)
- SQL file: `duplicate-resolution-queries.sql` (may already exist from previous runs)

## Process Steps

### 1. Initialize and Setup

**IMPORTANT: Check for existing resolution state first!**

If `resolution-cache.json`, `duplicate-resolution-results.json`, or `duplicate-resolution-queries.sql` already exist:
- Read and analyze the existing state
- Determine what work has already been completed
- Present a summary of previous progress to the user
- Ask if they want to:
  - Continue from where left off (recommended)
  - Start fresh (overwrite existing files)
  - Review and modify existing decisions

Use TodoWrite to create a comprehensive task list covering remaining process steps. Set the first task to "in_progress" and begin.

If starting fresh, create `resolution-cache.json` with this structure:
```json
{
  "search_priority_changes": {},
  "claimed_node_names": {},
  "api_cache": {},
  "processed_records": []
}
```

### 2. Global Priority Analysis

1. **Analyze Node Pack Frequency**: 
   - Parse `duplicate-node-names.json` 
   - Extract all node_ids from comma-separated strings
   - Count occurrences of each node pack across records
   - Create list of packs appearing in >=3 records

2. **Present Analysis**:
   - Format results in a clear table/visualization
   - Include pack name, occurrence count, and sample records
   - Highlight any packs that already have priority adjustments

3. **Interactive Priority Decisions**:
   - For each frequent pack without existing adjustments, query https://api.comfy.org using endpoints from `openapi.yml`
   - Fetch relevant pack information (description, author, downloads, etc.)
   - Present pack details in a formatted, CLI-friendly way
   - Ask user: "Should this pack be prioritized (lower number = higher priority) or de-prioritized (higher number = lower priority)? Current default is 5."
   - Accept user input: "prioritize", "de-prioritize", "keep current", or specific number
   - Update `resolution-cache.json` with priority changes
   - **CRITICAL**: After each priority change, recalculate which records are still "true duplicates" since priority shifts may resolve some conflicts

### 3. True Duplicate Resolution

1. **Identify Remaining Duplicates**:
   - Apply priority changes from cache to determine current effective priorities
   - Find records where 2+ node_ids have identical effective priority (ties to break)
   - Exclude records with clear "winners" (distinct lower priority than others)
   - Exclude records already resolved by claimed node names

2. **Automatic Pattern-Based Resolution**:
   - Apply common resolution patterns automatically where possible:
     - Original vs Fork preferences (e.g., ComfyUI-GGUF vs ComfyUI-GGUF_Forked)
     - Non-legacy vs Legacy (e.g., comfyui-prompt-control vs comfyui-prompt-control-legacy)
     - Full package names vs abbreviated versions
     - Advanced/Enhanced vs Basic versions
     - Spelling corrections and naming conventions
   - Use download counts from API or existing cache when available
   - Present automatic decisions to user for confirmation

3. **Interactive Claiming Decisions**:
   - For remaining true duplicate scenarios:
     - Display the conflicting node_ids and their details
     - Query API for additional context about each node_id
     - Present information clearly formatted for CLI
     - Ask: "Should the node name '{name}' be claimed by any of these node_ids? If so, which one?"
     - Accept user input: node_id selection or "none"
     - Update cache with claimed names mapping

### 4. Results Generation

1. **Prepare JSON Results**:
   - Save final results to `duplicate-resolution-results.json`
   - Include priority changes and claimed names
   - Update resolution summary statistics

2. **Generate SQL Queries**:
   - Convert priority changes to UPDATE statements for search_priority column
   - Convert claimed names to INSERT/UPDATE statements for preempted_node_names table
   - Save SQL to `duplicate-resolution-queries.sql`
   - Include comments explaining each query's purpose
   - Add verification queries to confirm changes

## Technical Requirements

- **State Recovery**: Always check for and respect existing resolution state
- **Cache Management**: Update `resolution-cache.json` after every user decision to avoid losing progress
- **API Efficiency**: Cache all API responses to avoid repeated requests
- **User Experience**: Format all CLI output clearly with proper spacing, headers, and visual separation
- **Error Handling**: Gracefully handle API failures and invalid user input
- **Progress Tracking**: Use TodoWrite throughout to show progress and mark completed steps

## API Usage Guidelines

- Check `openapi.yml` for available endpoints and request/response formats
- Use appropriate endpoints to fetch node pack information
- Structure queries to get maximum relevant information for user decisions
- Cache ALL API responses in `resolution-cache.json` under `api_cache`

## Output Format Requirements

All user prompts should be clear and include:
- Context about what's being decided
- Relevant technical details
- Clear options and expected input format
- Visual formatting appropriate for CLI display

## Final Deliverables

1. `resolution-cache.json` - Complete process cache
2. `duplicate-resolution-results.json` - Final decisions in structured format  
3. `duplicate-resolution-queries.sql` - Executable SQL statements for database updates

## State Recovery Examples

If existing files are found, provide output like:
```
✅ Found existing resolution state:
   - Priority adjustments: 6 node packs
   - Claimed nodes: 138 conflicts resolved
   - Remaining conflicts: 250 out of 714 original
   - Last updated: 2025-01-06

Options:
1. Continue from where left off (recommended)
2. Start fresh (will overwrite existing progress)
3. Review and modify existing decisions

Please choose [1-3]:
```

Begin the process by checking for existing state, reading the current data files, setting up or recovering the cache, and creating your initial task list with TodoWrite.