#!/usr/bin/env python3
"""
SQL Generator for Node Duplicate Resolutions

Reads resolution-cache.json and generates duplicate-resolution-queries.sql
with all the priority updates and node claims needed to resolve conflicts.
"""

import json
from datetime import datetime

def generate_sql_from_cache():
    """Generate SQL queries from the resolution cache"""
    
    # Load cache
    with open('resolution-cache.json', 'r') as f:
        cache = json.load(f)
    
    priority_changes = cache.get('search_priority_changes', {})
    claimed_nodes = cache.get('claimed_node_names', {})
    
    # Generate SQL content
    sql_lines = []
    sql_lines.append("-- Node Duplicate Resolution SQL Queries")
    sql_lines.append(f"-- Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    sql_lines.append("-- Purpose: Update search priorities and implement node name claiming")
    sql_lines.append("")
    
    # Priority updates section
    if priority_changes:
        sql_lines.append("-- =============================================================================")
        sql_lines.append("-- SECTION 1: UPDATE SEARCH PRIORITIES")
        sql_lines.append("-- =============================================================================")
        sql_lines.append("-- Lower priority numbers indicate higher search ranking")
        sql_lines.append("-- Default priority is 5, adjustments range from 6-10")
        sql_lines.append("")
        
        # Group by priority level
        by_priority = {}
        for node_id, priority in priority_changes.items():
            if priority not in by_priority:
                by_priority[priority] = []
            by_priority[priority].append(node_id)
        
        for priority in sorted(by_priority.keys()):
            node_ids = by_priority[priority]
            
            if priority == 6:
                sql_lines.append("-- Priority 6: Minor deprioritization")
            elif priority == 8:
                sql_lines.append("-- Priority 8: Significant deprioritization")
            elif priority == 10:
                sql_lines.append("-- Priority 10: Lowest priority (test packages, deprecated)")
            else:
                sql_lines.append(f"-- Priority {priority}: Custom priority level")
            
            for node_id in node_ids:
                sql_lines.append(f"UPDATE nodes")
                sql_lines.append(f"SET search_priority = {priority}")
                sql_lines.append(f"WHERE id = '{node_id}';")
                sql_lines.append("")
        
    # Node claims section
    if claimed_nodes:
        sql_lines.append("-- =============================================================================")
        sql_lines.append("-- SECTION 2: NODE NAME PREEMPTION CLAIMS")
        sql_lines.append("-- =============================================================================")
        sql_lines.append("-- Explicit node name ownership to resolve remaining conflicts")
        sql_lines.append("")
        
        # Sort by package for better organization
        by_package = {}
        for node_name, package_id in claimed_nodes.items():
            if package_id not in by_package:
                by_package[package_id] = []
            by_package[package_id].append(node_name)
        
        for package_id in sorted(by_package.keys()):
            node_names = by_package[package_id]
            sql_lines.append(f"-- Claims for package: {package_id} ({len(node_names)} nodes)")
            
            for node_name in sorted(node_names):
                # Escape single quotes in node names
                escaped_name = node_name.replace("'", "''")
                sql_lines.append(f"INSERT INTO preempted_node_names (node_name, node_id)")
                sql_lines.append(f"VALUES ('{escaped_name}', '{package_id}')")
                sql_lines.append(f"ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;")
                sql_lines.append("")
    
    # Rollback section
    sql_lines.append("-- =============================================================================")
    sql_lines.append("-- ROLLBACK QUERIES (for reverting changes if needed)")
    sql_lines.append("-- =============================================================================")
    sql_lines.append("")
    
    if priority_changes:
        sql_lines.append("-- Rollback priority changes to default (5):")
        for node_id in priority_changes.keys():
            sql_lines.append(f"-- UPDATE nodes SET search_priority = 5 WHERE id = '{node_id}';")
        sql_lines.append("")
    
    if claimed_nodes:
        sql_lines.append("-- Rollback node claims:")
        for node_name in claimed_nodes.keys():
            escaped_name = node_name.replace("'", "''")
            sql_lines.append(f"-- DELETE FROM preempted_node_names WHERE node_name = '{escaped_name}';")
        sql_lines.append("")
    
    # Summary
    sql_lines.append("-- =============================================================================")
    sql_lines.append("-- SUMMARY")
    sql_lines.append("-- =============================================================================")
    sql_lines.append(f"-- Priority updates: {len(priority_changes)} packages")
    sql_lines.append(f"-- Node claims: {len(claimed_nodes)} nodes")
    sql_lines.append(f"-- Total operations: {len(priority_changes) + len(claimed_nodes)}")
    
    # Write SQL file
    sql_content = '\n'.join(sql_lines)
    with open('duplicate-resolution-queries.sql', 'w') as f:
        f.write(sql_content)
    
    print(f"✅ Generated duplicate-resolution-queries.sql")
    print(f"   Priority updates: {len(priority_changes)} packages")
    print(f"   Node claims: {len(claimed_nodes)} nodes")
    print(f"   Total operations: {len(priority_changes) + len(claimed_nodes)}")

if __name__ == "__main__":
    generate_sql_from_cache()