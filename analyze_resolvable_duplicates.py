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

# Analyze which records can be FULLY resolved by priority changes
# A record can be fully resolved if:
# 1. It's a 2-way duplicate (distinct_node_count = 2), OR
# 2. It has 3+ duplicates but one of them is a priority package (giving it highest priority would resolve the conflict)

fully_resolvable = []
partially_helped = []
not_helped = []

for i, record in enumerate(duplicates):
    node_ids = record['node_ids'].split(',')
    distinct_count = record['distinct_node_count']
    
    # Check if any of the node_ids match priority packages
    priority_matches = [pkg for pkg in priority_packages.keys() if pkg in node_ids]
    
    if len(priority_matches) > 0:
        if distinct_count == 2:
            # 2-way duplicate with priority package = fully resolvable
            fully_resolvable.append({
                'index': i + 1,
                'name': record['name'],
                'node_ids': record['node_ids'],
                'distinct_node_count': distinct_count,
                'total_record_count': record['total_record_count'],
                'priority_packages': priority_matches
            })
        else:
            # 3+ way duplicate with priority package = partially helped (reduces conflict but doesn't eliminate)
            partially_helped.append({
                'index': i + 1,
                'name': record['name'],
                'node_ids': record['node_ids'],
                'distinct_node_count': distinct_count,
                'total_record_count': record['total_record_count'],
                'priority_packages': priority_matches
            })
    else:
        # No priority package = not helped at all
        not_helped.append({
            'index': i + 1,
            'name': record['name'],
            'node_ids': record['node_ids'],
            'distinct_node_count': distinct_count,
            'total_record_count': record['total_record_count']
        })

print(f"\nDETAILED ANALYSIS:")
print(f"Records FULLY resolvable (2-way duplicates with priority pkg): {len(fully_resolvable)}")
print(f"Records partially helped (3+ way with priority pkg): {len(partially_helped)}")
print(f"Records not helped at all: {len(not_helped)}")

print(f"\nBREAKDOWN BY DUPLICATE COUNT:")
two_way_total = len([r for r in duplicates if r['distinct_node_count'] == 2])
three_way_total = len([r for r in duplicates if r['distinct_node_count'] == 3])
four_plus_way_total = len([r for r in duplicates if r['distinct_node_count'] >= 4])

two_way_priority = len([r for r in fully_resolvable if r['distinct_node_count'] == 2])
three_way_priority = len([r for r in partially_helped if r['distinct_node_count'] == 3])
four_plus_way_priority = len([r for r in partially_helped if r['distinct_node_count'] >= 4])

print(f"2-way duplicates: {two_way_total} total, {two_way_priority} with priority packages ({two_way_priority/two_way_total:.1%})")
print(f"3-way duplicates: {three_way_total} total, {three_way_priority} with priority packages ({three_way_priority/three_way_total:.1%})")
if four_plus_way_total > 0:
    print(f"4+ way duplicates: {four_plus_way_total} total, {four_plus_way_priority} with priority packages ({four_plus_way_priority/four_plus_way_total:.1%})")
else:
    print(f"4+ way duplicates: {four_plus_way_total} total, {four_plus_way_priority} with priority packages")

print(f"\nEXAMPLES OF FULLY RESOLVABLE (first 5):")
for example in fully_resolvable[:5]:
    print(f"  {example['name']}: {example['node_ids']} (priority: {example['priority_packages']})")

print(f"\nEXAMPLES OF PARTIALLY HELPED (first 5):")
for example in partially_helped[:5]:
    print(f"  {example['name']}: {example['node_ids']} (priority: {example['priority_packages']})")

print(f"\nEXAMPLES OF NOT HELPED (first 5):")
for example in not_helped[:5]:
    print(f"  {example['name']}: {example['node_ids']}")

print(f"\n" + "="*60)
print(f"CLAIM VERIFICATION:")
print(f"Claimed: 6 priority changes could resolve 326 conflicts")
print(f"Actual fully resolvable: {len(fully_resolvable)}")
print(f"Actual partially helped: {len(partially_helped)}")
print(f"Total affected: {len(fully_resolvable) + len(partially_helped)}")

if len(fully_resolvable) == 326:
    print(f"VERDICT: CORRECT if claim meant 'fully resolve 2-way conflicts'")
elif len(fully_resolvable) + len(partially_helped) == 326:
    print(f"VERDICT: CORRECT if claim meant 'affect any conflicts'")
else:
    print(f"VERDICT: INCORRECT - numbers don't match")