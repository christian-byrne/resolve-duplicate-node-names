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

# Find records with exactly one priority package
exactly_one_priority = []
for i, record in enumerate(duplicates):
    node_ids = record['node_ids'].split(',')
    priority_matches = [pkg for pkg in priority_packages.keys() if pkg in node_ids]
    
    if len(priority_matches) == 1:
        exactly_one_priority.append({
            'index': i,
            'name': record['name'],
            'node_ids': record['node_ids'],
            'priority_package': priority_matches[0],
            'distinct_count': record['distinct_node_count'],
            'total_count': record['total_record_count']
        })

print(f"Records with exactly one priority package: {len(exactly_one_priority)}")

# Let's see if there are any records that might have been excluded
# Maybe records that are already resolved in some other way?

# Check for records that contain both versions of similar packages (like the Ryan case)
potential_exclusions = []
for record in exactly_one_priority:
    node_ids = record['node_ids'].split(',')
    
    # Check for cases where both versions exist (like comfyui_ryanontheinside and comfyui_ryanonyheinside)
    if 'comfyui_ryanontheinside' in node_ids and 'comfyui_ryanonyheinside' in node_ids:
        potential_exclusions.append(record)
        continue
    
    # Check for cases where both KurtHokke versions exist
    if 'ComfyUI_KurtHokke-Nodes' in node_ids and 'ComfyUI_KurtHokke_Nodes' in node_ids:
        potential_exclusions.append(record)
        continue

print(f"Potential exclusions (records with competing versions): {len(potential_exclusions)}")

# The actual count that would be used for the claim
final_count = len(exactly_one_priority) - len(potential_exclusions)
print(f"Final count after exclusions: {final_count}")

if final_count == 326:
    print("✓ This matches the claimed 326!")
    print("\nExplanation: The claim counts records with exactly one priority package,")
    print("excluding cases where both competing versions are present in the same record.")
else:
    print(f"✗ Still doesn't match 326, difference: {abs(final_count - 326)}")

# Show the potential exclusions
print(f"\nPotential exclusions:")
for record in potential_exclusions:
    print(f"  {record['name']}: {record['node_ids']} (priority: {record['priority_package']})")

# Let's check if there are exactly 2 more records that might be excluded for other reasons
remaining_diff = len(exactly_one_priority) - len(potential_exclusions) - 326
print(f"\nRemaining difference: {remaining_diff}")

if remaining_diff == 2:
    print("Looking for 2 more records that might be excluded...")
    
    # Maybe records that have other priority packages mentioned but not in our list?
    # Or records that have some other characteristic?
    
    # Check for records that might be test nodes or similar
    test_like = []
    for record in exactly_one_priority:
        if record in potential_exclusions:
            continue
        
        # Check if this might be a test node or something similar
        if 'test' in record['name'].lower() or 'test' in record['node_ids'].lower():
            test_like.append(record)
    
    print(f"Test-like records: {len(test_like)}")
    for record in test_like:
        print(f"  {record['name']}: {record['node_ids']}")

# Summary
print(f"\n" + "="*60)
print("ANALYSIS SUMMARY:")
print(f"Total duplicate records: {len(duplicates)}")
print(f"Records with any priority package: 368")
print(f"Records with exactly one priority package: {len(exactly_one_priority)}")
print(f"Records likely excluded (competing versions): {len(potential_exclusions)}")
print(f"Final calculated count: {len(exactly_one_priority) - len(potential_exclusions)}")
print(f"Claimed count: 326")
print(f"Difference: {abs((len(exactly_one_priority) - len(potential_exclusions)) - 326)}")

print(f"\nFirst 50 records analysis:")
first_50 = duplicates[:50]
first_50_affected = 0
first_50_resolvable = 0

for record in first_50:
    node_ids = record['node_ids'].split(',')
    priority_matches = [pkg for pkg in priority_packages.keys() if pkg in node_ids]
    
    if len(priority_matches) > 0:
        first_50_affected += 1
        if record['distinct_node_count'] == 2:
            first_50_resolvable += 1

print(f"First 50 records affected by priority changes: {first_50_affected}")
print(f"First 50 records that would be fully resolved (2-way): {first_50_resolvable}")