#!/usr/bin/env python3
"""
Resolution Engine for ComfyUI Node Duplicates

This script determines which duplicate node records are truly resolved
based on priority differences and preemption claims.
"""

import json
from typing import Dict, List, Tuple, Set
from collections import defaultdict

class ResolutionEngine:
    def __init__(self, duplicates_file: str, cache_file: str):
        self.duplicates_file = duplicates_file
        self.cache_file = cache_file
        self.default_priority = 5
        
        # Load data
        with open(duplicates_file, 'r') as f:
            self.duplicates = json.load(f)
        
        with open(cache_file, 'r') as f:
            cache = json.load(f)
            self.priority_changes = cache.get('search_priority_changes', {})
            self.claimed_nodes = cache.get('claimed_node_names', {})
    
    def get_effective_priority(self, node_id: str) -> int:
        """Get the effective search priority for a node_id"""
        return self.priority_changes.get(node_id, self.default_priority)
    
    def is_record_resolved(self, record: Dict) -> Tuple[bool, str]:
        """
        Check if a duplicate record is resolved.
        Returns (is_resolved, resolution_type)
        """
        name = record['name']
        node_ids = [nid.strip() for nid in record['node_ids'].split(',')]
        
        # Check if name is claimed/preempted
        if name in self.claimed_nodes:
            claiming_pack = self.claimed_nodes[name]
            if claiming_pack in node_ids:
                return True, f"preempted_by_{claiming_pack}"
        
        # Check for priority differences
        priorities = [self.get_effective_priority(nid) for nid in node_ids]
        unique_priorities = set(priorities)
        
        if len(unique_priorities) > 1:
            min_priority = min(priorities)
            winners = [nid for nid, p in zip(node_ids, priorities) if p == min_priority]
            if len(winners) == 1:
                return True, f"priority_winner_{winners[0]}"
            else:
                # Multiple winners with same min priority - still unresolved
                return False, f"priority_tie_{min_priority}"
        
        # All have same priority and no preemption
        return False, f"unresolved_priority_{priorities[0]}"
    
    def analyze_all_records(self) -> Dict:
        """Analyze all duplicate records and categorize them"""
        results = {
            'resolved': [],
            'unresolved': [],
            'resolution_stats': defaultdict(int),
            'unresolved_patterns': defaultdict(list)
        }
        
        for record in self.duplicates:
            is_resolved, resolution_type = self.is_record_resolved(record)
            
            if is_resolved:
                results['resolved'].append({
                    'record': record,
                    'resolution_type': resolution_type
                })
                results['resolution_stats'][resolution_type.split('_')[0]] += 1
            else:
                results['unresolved'].append({
                    'record': record,
                    'reason': resolution_type
                })
                
                # Pattern analysis for unresolved
                node_ids = record['node_ids']
                results['unresolved_patterns'][node_ids].append(record['name'])
        
        return results
    
    def get_unresolved_by_pattern(self) -> List[Dict]:
        """Get unresolved records grouped by node_id patterns"""
        unresolved_patterns = defaultdict(list)
        
        for record in self.duplicates:
            is_resolved, _ = self.is_record_resolved(record)
            if not is_resolved:
                node_ids = record['node_ids']
                unresolved_patterns[node_ids].append(record)
        
        # Convert to list sorted by frequency
        pattern_list = []
        for node_ids, records in unresolved_patterns.items():
            pattern_list.append({
                'node_ids': node_ids,
                'conflict_count': len(records),
                'records': records,
                'sample_names': [r['name'] for r in records[:5]]  # First 5 as sample
            })
        
        return sorted(pattern_list, key=lambda x: x['conflict_count'], reverse=True)

def main():
    engine = ResolutionEngine('duplicate-node-names.json', 'resolution-cache.json')
    
    print("=== ComfyUI Node Duplicate Resolution Analysis ===\n")
    
    # Analyze all records
    analysis = engine.analyze_all_records()
    
    # Summary stats
    total = len(engine.duplicates)
    resolved = len(analysis['resolved'])
    unresolved = len(analysis['unresolved'])
    
    print(f"Total Records: {total}")
    print(f"Resolved: {resolved} ({resolved/total*100:.1f}%)")
    print(f"Unresolved: {unresolved} ({unresolved/total*100:.1f}%)\n")
    
    # Resolution breakdown
    print("Resolution Methods:")
    for method, count in analysis['resolution_stats'].items():
        print(f"  {method}: {count}")
    
    print(f"\nTop Unresolved Patterns:")
    unresolved_patterns = engine.get_unresolved_by_pattern()
    for i, pattern in enumerate(unresolved_patterns[:10]):
        print(f"{i+1}. {pattern['node_ids']} ({pattern['conflict_count']} conflicts)")
        print(f"   Sample nodes: {', '.join(pattern['sample_names'])}")
    
    # Save detailed unresolved list
    with open('unresolved_conflicts.json', 'w') as f:
        json.dump(unresolved_patterns, f, indent=2)
    
    print(f"\nDetailed unresolved conflicts saved to: unresolved_conflicts.json")

if __name__ == "__main__":
    main()