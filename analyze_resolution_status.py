#!/usr/bin/env python3
"""
Analyze the current state of duplicate node name resolutions.
"""

import json
from collections import defaultdict

def load_data():
    """Load duplicate records and resolution cache"""
    with open('duplicate-node-names.json', 'r') as f:
        duplicates = json.load(f)
    
    with open('resolution-cache.json', 'r') as f:
        cache = json.load(f)
    
    return duplicates, cache

def get_effective_priority(pack_id, priority_changes):
    """Get effective search priority for a pack (default 5 if not specified)"""
    return priority_changes.get(pack_id, 5)

def analyze_record(record, priority_changes, claimed_names):
    """Analyze a single duplicate record to determine resolution status"""
    node_name = record['name']
    node_ids = record['node_ids'].split(',')
    
    # Check if resolved by claiming
    if node_name in claimed_names:
        claimed_by = claimed_names[node_name]
        if claimed_by in node_ids:
            return 'resolved_by_claim', claimed_by
        else:
            # Edge case: claimed by a pack not in this duplicate set
            return 'claimed_by_external', claimed_by
    
    # Check if resolved by priority differences
    priorities = [get_effective_priority(node_id, priority_changes) for node_id in node_ids]
    unique_priorities = set(priorities)
    
    if len(unique_priorities) > 1:
        # Find the highest priority pack(s)
        max_priority = max(priorities)
        winners = [node_ids[i] for i, p in enumerate(priorities) if p == max_priority]
        return 'resolved_by_priority', {'priorities': dict(zip(node_ids, priorities)), 'winners': winners}
    
    # Still unresolved - all have same priority and no claim
    return 'unresolved', {'priority': priorities[0], 'node_ids': node_ids}

def main():
    duplicates, cache = load_data()
    priority_changes = cache['search_priority_changes']
    claimed_names = cache['claimed_node_names']
    
    # Analysis counters
    stats = {
        'resolved_by_claim': [],
        'resolved_by_priority': [],
        'claimed_by_external': [],
        'unresolved': []
    }
    
    print(f"Analyzing {len(duplicates)} duplicate node name records...")
    print(f"Priority changes applied to {len(priority_changes)} packs")
    print(f"Node names claimed: {len(claimed_names)}")
    print("-" * 60)
    
    # Analyze each record
    for record in duplicates:
        status, details = analyze_record(record, priority_changes, claimed_names)
        stats[status].append((record, details))
    
    # Print summary
    print("RESOLUTION STATUS SUMMARY:")
    print(f"  Resolved by claims: {len(stats['resolved_by_claim'])}")
    print(f"  Resolved by priority: {len(stats['resolved_by_priority'])}")
    print(f"  Claimed by external pack: {len(stats['claimed_by_external'])}")
    print(f"  Still unresolved: {len(stats['unresolved'])}")
    print(f"  Total records: {sum(len(v) for v in stats.values())}")
    print()
    
    total_resolved = len(stats['resolved_by_claim']) + len(stats['resolved_by_priority'])
    total_records = len(duplicates)
    resolution_rate = (total_resolved / total_records) * 100
    print(f"Overall resolution rate: {total_resolved}/{total_records} ({resolution_rate:.1f}%)")
    print()
    
    # Show examples from each category
    print("EXAMPLES BY CATEGORY:")
    print()
    
    # Resolved by claims
    if stats['resolved_by_claim']:
        print("1. RESOLVED BY CLAIMS (examples):")
        for i, (record, claimed_by) in enumerate(stats['resolved_by_claim'][:5]):
            print(f"   • {record['name']} - claimed by '{claimed_by}'")
            print(f"     Competing packs: {record['node_ids']}")
        if len(stats['resolved_by_claim']) > 5:
            print(f"     ... and {len(stats['resolved_by_claim']) - 5} more")
        print()
    
    # Resolved by priority
    if stats['resolved_by_priority']:
        print("2. RESOLVED BY PRIORITY (examples):")
        for i, (record, details) in enumerate(stats['resolved_by_priority'][:5]):
            print(f"   • {record['name']}")
            print(f"     Priorities: {details['priorities']}")
            print(f"     Winner(s): {details['winners']}")
        if len(stats['resolved_by_priority']) > 5:
            print(f"     ... and {len(stats['resolved_by_priority']) - 5} more")
        print()
    
    # External claims (edge cases)
    if stats['claimed_by_external']:
        print("3. CLAIMED BY EXTERNAL PACK (edge cases):")
        for record, claimed_by in stats['claimed_by_external']:
            print(f"   • {record['name']} - claimed by '{claimed_by}' (not in competing set)")
            print(f"     Competing packs: {record['node_ids']}")
        print()
    
    # Still unresolved
    if stats['unresolved']:
        print("4. STILL UNRESOLVED (examples):")
        for i, (record, details) in enumerate(stats['unresolved'][:10]):
            print(f"   • {record['name']} - all packs have priority {details['priority']}")
            print(f"     Competing packs: {record['node_ids']}")
        if len(stats['unresolved']) > 10:
            print(f"     ... and {len(stats['unresolved']) - 10} more")
        print()
    
    # Priority distribution analysis
    print("PRIORITY DISTRIBUTION ANALYSIS:")
    priority_usage = defaultdict(int)
    for record, _ in stats['unresolved']:
        node_ids = record['node_ids'].split(',')
        for node_id in node_ids:
            priority = get_effective_priority(node_id, priority_changes)
            priority_usage[priority] += 1
    
    print("Unresolved packs by priority level:")
    for priority in sorted(priority_usage.keys()):
        print(f"  Priority {priority}: {priority_usage[priority]} pack instances")
    print()
    
    # Suggest next steps
    print("NEXT STEPS SUGGESTIONS:")
    if stats['unresolved']:
        print(f"1. {len(stats['unresolved'])} records still need resolution")
        print("2. Consider adjusting priorities for high-conflict packs")
        print("3. Consider claiming node names for authoritative packs")
        
        # Find most problematic packs
        pack_conflicts = defaultdict(int)
        for record, _ in stats['unresolved']:
            for pack in record['node_ids'].split(','):
                pack_conflicts[pack] += 1
        
        print("\nMost conflicted packs (in unresolved records):")
        sorted_conflicts = sorted(pack_conflicts.items(), key=lambda x: x[1], reverse=True)
        for pack, count in sorted_conflicts[:10]:
            current_priority = get_effective_priority(pack, priority_changes)
            print(f"   • {pack}: {count} conflicts (current priority: {current_priority})")

if __name__ == '__main__':
    main()