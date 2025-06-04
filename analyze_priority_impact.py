#!/usr/bin/env python3
import json

# Priority packages that got changes
priority_packages = {
    'comfyui_ryanontheinside': 6,
    'node-registry-test': 10, 
    'comfyui_essentials_mb': 6,
    'ComfyUI_KurtHokke-Nodes': 8,
    'ComfyUI_KurtHokke_Nodes': 8,
    'comfyui_ipadapter_plus_fork': 6
}

# Load the duplicate data
with open('duplicate-node-names.json', 'r') as f:
    duplicates = json.load(f)

print(f"Total duplicate records: {len(duplicates)}")

# Analyze first 50 records
first_50 = duplicates[:50]
resolved_count = 0
would_resolve_examples = []
would_not_resolve_examples = []

for i, record in enumerate(first_50):
    node_ids = record['node_ids'].split(',')
    
    # Check if any of the node_ids match priority packages
    has_priority_package = any(pkg in node_ids for pkg in priority_packages.keys())
    
    if has_priority_package:
        resolved_count += 1
        would_resolve_examples.append({
            'index': i + 1,
            'name': record['name'],
            'node_ids': record['node_ids'],
            'distinct_node_count': record['distinct_node_count'],
            'total_record_count': record['total_record_count']
        })
    else:
        would_not_resolve_examples.append({
            'index': i + 1,
            'name': record['name'],
            'node_ids': record['node_ids'],
            'distinct_node_count': record['distinct_node_count'],
            'total_record_count': record['total_record_count']
        })

print(f"\nAnalysis of first 50 duplicate records:")
print(f"Records that would be resolved by priority changes: {resolved_count}")
print(f"Records that would NOT be resolved: {50 - resolved_count}")
print(f"Resolution rate: {resolved_count/50:.1%}")

print(f"\nExamples of records that WOULD be resolved (showing first 5):")
for example in would_resolve_examples[:5]:
    print(f"  {example['index']}. {example['name']}")
    print(f"     Node IDs: {example['node_ids']}")
    print(f"     Distinct nodes: {example['distinct_node_count']}, Total records: {example['total_record_count']}")

print(f"\nExamples of records that would NOT be resolved (showing first 5):")
for example in would_not_resolve_examples[:5]:
    print(f"  {example['index']}. {example['name']}")
    print(f"     Node IDs: {example['node_ids']}")
    print(f"     Distinct nodes: {example['distinct_node_count']}, Total records: {example['total_record_count']}")

# Now let's count across ALL records
all_resolved_count = 0
all_affected_records = []

for i, record in enumerate(duplicates):
    node_ids = record['node_ids'].split(',')
    has_priority_package = any(pkg in node_ids for pkg in priority_packages.keys())
    
    if has_priority_package:
        all_resolved_count += 1
        all_affected_records.append({
            'index': i + 1,
            'name': record['name'],
            'node_ids': record['node_ids'],
            'distinct_node_count': record['distinct_node_count'],
            'total_record_count': record['total_record_count']
        })

print(f"\n" + "="*60)
print(f"ANALYSIS OF ALL {len(duplicates)} DUPLICATE RECORDS:")
print(f"Records that would be resolved by priority changes: {all_resolved_count}")
print(f"Records that would NOT be resolved: {len(duplicates) - all_resolved_count}")
print(f"Overall resolution rate: {all_resolved_count/len(duplicates):.1%}")

# Count by priority package
package_counts = {}
for package in priority_packages.keys():
    count = 0
    for record in duplicates:
        if package in record['node_ids'].split(','):
            count += 1
    package_counts[package] = count

print(f"\nBreakdown by priority package:")
for package, count in package_counts.items():
    print(f"  {package}: {count} records")

print(f"\nClaim verification:")
print(f"Claimed: 6 priority changes could resolve 326 conflicts")
print(f"Actual: 6 priority changes would resolve {all_resolved_count} out of {len(duplicates)} conflicts")
print(f"Verification: {'INCORRECT' if all_resolved_count != 326 else 'CORRECT'}")