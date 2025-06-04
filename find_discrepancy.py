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

# Find records with priority packages
priority_affected = []
ryan_both_versions = []

for i, record in enumerate(duplicates):
    node_ids = record['node_ids'].split(',')
    
    # Check if any priority packages are present
    priority_matches = [pkg for pkg in priority_packages.keys() if pkg in node_ids]
    
    if len(priority_matches) > 0:
        priority_affected.append({
            'index': i,
            'name': record['name'],
            'node_ids': record['node_ids'],
            'priority_packages': priority_matches
        })
        
        # Special case: check for records with both Ryan versions
        if 'comfyui_ryanontheinside' in node_ids and 'comfyui_ryanonyheinside' in node_ids:
            ryan_both_versions.append({
                'index': i,
                'name': record['name'],
                'node_ids': record['node_ids']
            })

print(f"Total records with priority packages: {len(priority_affected)}")
print(f"Records with both Ryan versions: {len(ryan_both_versions)}")

print(f"\nRecords with both comfyui_ryanontheinside (deprioritized) and comfyui_ryanonyheinside (kept at default):")
for record in ryan_both_versions:
    print(f"  {record['name']}: {record['node_ids']}")

# Check if removing the Ryan-both-versions records gets us to 326
adjusted_count = len(priority_affected) - len(ryan_both_versions)
print(f"\nAdjusted count (removing Ryan both-versions): {adjusted_count}")

if adjusted_count == 326:
    print("✓ This matches the claimed 326!")
else:
    print(f"✗ Still doesn't match 326, difference: {abs(adjusted_count - 326)}")

# Let's also check for other patterns
print(f"\nChecking for other patterns...")

# Maybe they only counted records where the priority package is the ONLY one getting a priority change
only_one_priority_change = []
for record in priority_affected:
    node_ids = record['node_ids'].split(',')
    priority_count = sum(1 for pkg in priority_packages.keys() if pkg in node_ids)
    if priority_count == 1:
        only_one_priority_change.append(record)

print(f"Records with exactly one priority package: {len(only_one_priority_change)}")

# Check if this gives us 326
if len(only_one_priority_change) == 326:
    print("✓ This matches the claimed 326!")
else:
    print(f"✗ Still doesn't match 326, difference: {abs(len(only_one_priority_change) - 326)}")

# Let's check what the difference is between the two counts
difference_records = []
for record in priority_affected:
    node_ids = record['node_ids'].split(',')
    priority_count = sum(1 for pkg in priority_packages.keys() if pkg in node_ids)
    if priority_count > 1:
        difference_records.append(record)

print(f"\nRecords with multiple priority packages (might be double-counted): {len(difference_records)}")
for record in difference_records[:10]:  # Show first 10
    print(f"  {record['name']}: {record['node_ids']} (priority packages: {record['priority_packages']})")

print(f"\nCalculation check:")
print(f"Total affected: {len(priority_affected)}")
print(f"Only one priority: {len(only_one_priority_change)}")
print(f"Multiple priorities: {len(difference_records)}")
print(f"Verification: {len(only_one_priority_change)} + {len(difference_records)} = {len(only_one_priority_change) + len(difference_records)}")