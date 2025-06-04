#!/usr/bin/env python3
"""
Interactive Resolution Tool for Remaining Conflicts

Systematically resolve the remaining 250 duplicate conflicts by:
1. Analyzing package patterns
2. Making automatic decisions based on common patterns
3. Interactive decisions for complex cases
"""

import json
import requests
from typing import Dict, List, Tuple
from collections import defaultdict

class ConflictResolver:
    def __init__(self):
        self.base_url = "https://api.comfy.org"
        self.session = requests.Session()
        
        # Load existing data
        with open('unresolved_conflicts.json', 'r') as f:
            self.unresolved_patterns = json.load(f)
        
        with open('resolution-cache.json', 'r') as f:
            self.cache = json.load(f)
        
        self.new_priority_changes = {}
        self.new_claimed_nodes = {}
    
    def get_package_info(self, package_id: str) -> Dict:
        """Fetch package information from API"""
        if package_id in self.cache.get('api_cache', {}):
            return self.cache['api_cache'][package_id]
        
        try:
            # Search for the specific package
            response = self.session.get(
                f"{self.base_url}/nodes/search",
                params={'search': package_id, 'limit': 100}
            )
            if response.status_code == 200:
                data = response.json()
                nodes = data.get('nodes', [])
                
                # Find exact match
                for node in nodes:
                    if node.get('node_id') == package_id:
                        info = {
                            'description': node.get('description', 'No description'),
                            'author': node.get('author', 'Unknown'),
                            'downloads': node.get('stats', {}).get('downloads', 0),
                            'status': node.get('status', 'unknown'),
                            'repository_url': node.get('repository_url', ''),
                            'last_updated': node.get('last_updated', ''),
                            'tags': node.get('tags', [])
                        }
                        
                        # Cache the result
                        if 'api_cache' not in self.cache:
                            self.cache['api_cache'] = {}
                        self.cache['api_cache'][package_id] = info
                        return info
                
                # If no exact match, return basic info
                return {'error': 'Package not found in search results'}
            
        except Exception as e:
            return {'error': f'API error: {str(e)}'}
        
        return {'error': 'Unknown error'}
    
    def analyze_automatic_patterns(self) -> List[Dict]:
        """Identify patterns that can be resolved automatically"""
        auto_resolutions = []
        
        for pattern in self.unresolved_patterns:
            node_ids = pattern['node_ids'].split(',')
            node_ids = [nid.strip() for nid in node_ids]
            
            if len(node_ids) == 2:
                # Check for common automatic resolution patterns
                decision = self.check_automatic_patterns(node_ids[0], node_ids[1])
                if decision:
                    auto_resolutions.append({
                        'pattern': pattern,
                        'decision': decision,
                        'node_ids': node_ids
                    })
        
        return auto_resolutions
    
    def check_automatic_patterns(self, pack1: str, pack2: str) -> Dict:
        """Check if two packages match automatic resolution patterns"""
        
        # Pattern 1: Test vs Production
        if 'test' in pack1.lower() and 'test' not in pack2.lower():
            return {'type': 'priority', 'winner': pack2, 'reason': 'Production over test package'}
        if 'test' in pack2.lower() and 'test' not in pack1.lower():
            return {'type': 'priority', 'winner': pack1, 'reason': 'Production over test package'}
        
        # Pattern 2: Fork vs Original (based on naming)
        if pack1.endswith('-fork') or pack1.endswith('_fork'):
            return {'type': 'priority', 'winner': pack2, 'reason': 'Original over fork'}
        if pack2.endswith('-fork') or pack2.endswith('_fork'):
            return {'type': 'priority', 'winner': pack1, 'reason': 'Original over fork'}
        
        # Pattern 3: Legacy vs Non-legacy
        if 'legacy' in pack1.lower() and 'legacy' not in pack2.lower():
            return {'type': 'priority', 'winner': pack2, 'reason': 'Current over legacy'}
        if 'legacy' in pack2.lower() and 'legacy' not in pack1.lower():
            return {'type': 'priority', 'winner': pack1, 'reason': 'Current over legacy'}
        
        # Pattern 4: Hyphen vs Underscore (prefer hyphen convention)
        pack1_norm = pack1.replace('_', '-')
        pack2_norm = pack2.replace('_', '-')
        if pack1_norm == pack2_norm:
            if '-' in pack1 and '_' in pack2:
                return {'type': 'priority', 'winner': pack1, 'reason': 'Hyphen naming convention preferred'}
            if '-' in pack2 and '_' in pack1:
                return {'type': 'priority', 'winner': pack2, 'reason': 'Hyphen naming convention preferred'}
        
        # Pattern 5: Longer descriptive names vs short names
        if len(pack1) > len(pack2) * 1.5 and pack2 in pack1:
            return {'type': 'priority', 'winner': pack1, 'reason': 'More descriptive package name'}
        if len(pack2) > len(pack1) * 1.5 and pack1 in pack2:
            return {'type': 'priority', 'winner': pack2, 'reason': 'More descriptive package name'}
        
        return None
    
    def resolve_large_conflicts(self):
        """Handle the largest conflict patterns first"""
        
        print("=== Resolving Large Conflict Patterns ===\n")
        
        # Sort by conflict count descending
        sorted_patterns = sorted(self.unresolved_patterns, 
                               key=lambda x: x['conflict_count'], reverse=True)
        
        for i, pattern in enumerate(sorted_patterns[:5]):  # Top 5 largest
            print(f"\n{i+1}. LARGE CONFLICT: {pattern['node_ids']}")
            print(f"   Conflicts: {pattern['conflict_count']}")
            print(f"   Sample nodes: {', '.join(pattern['sample_names'])}")
            
            node_ids = pattern['node_ids'].split(',')
            node_ids = [nid.strip() for nid in node_ids]
            
            # Get package info for each
            package_info = {}
            for nid in node_ids:
                print(f"\n   Fetching info for {nid}...")
                info = self.get_package_info(nid)
                package_info[nid] = info
                
                if 'error' not in info:
                    print(f"     Description: {info.get('description', 'N/A')}")
                    print(f"     Author: {info.get('author', 'N/A')}")
                    print(f"     Downloads: {info.get('downloads', 0):,}")
                    print(f"     Status: {info.get('status', 'N/A')}")
                else:
                    print(f"     Error: {info['error']}")
            
            # Check for automatic resolution
            if len(node_ids) == 2:
                auto_decision = self.check_automatic_patterns(node_ids[0], node_ids[1])
                if auto_decision:
                    print(f"\n   AUTO RESOLUTION: {auto_decision['reason']}")
                    print(f"   Winner: {auto_decision['winner']}")
                    
                    if auto_decision['type'] == 'priority':
                        # Set loser to lower priority
                        loser = node_ids[0] if auto_decision['winner'] == node_ids[1] else node_ids[1]
                        self.new_priority_changes[loser] = 6
                        print(f"   -> Setting {loser} priority to 6")
                    continue
            
            # Manual decision required
            print(f"\n   MANUAL DECISION REQUIRED:")
            print(f"   1. Set priority for one package (makes it lose)")
            print(f"   2. Claim nodes for specific package") 
            print(f"   3. Skip for now")
            
            choice = input(f"   Choice [1-3]: ").strip()
            
            if choice == '1':
                print(f"   Which package should have LOWER priority?")
                for j, nid in enumerate(node_ids):
                    print(f"   {j+1}. {nid}")
                
                pkg_choice = input(f"   Package [1-{len(node_ids)}]: ").strip()
                try:
                    pkg_idx = int(pkg_choice) - 1
                    if 0 <= pkg_idx < len(node_ids):
                        selected_pkg = node_ids[pkg_idx]
                        self.new_priority_changes[selected_pkg] = 6
                        print(f"   -> Setting {selected_pkg} priority to 6")
                except:
                    print("   Invalid choice, skipping")
            
            elif choice == '2':
                print(f"   Which package should claim the nodes?")
                for j, nid in enumerate(node_ids):
                    print(f"   {j+1}. {nid}")
                
                pkg_choice = input(f"   Package [1-{len(node_ids)}]: ").strip()
                try:
                    pkg_idx = int(pkg_choice) - 1
                    if 0 <= pkg_idx < len(node_ids):
                        selected_pkg = node_ids[pkg_idx]
                        # Claim all nodes in this pattern
                        for record in pattern['records']:
                            self.new_claimed_nodes[record['name']] = selected_pkg
                        print(f"   -> Claiming {len(pattern['records'])} nodes for {selected_pkg}")
                except:
                    print("   Invalid choice, skipping")
            
            # Save progress after each large pattern
            self.save_progress()
    
    def save_progress(self):
        """Save current progress to cache"""
        # Update cache with new decisions
        self.cache['search_priority_changes'].update(self.new_priority_changes)
        self.cache['claimed_node_names'].update(self.new_claimed_nodes)
        
        # Save updated cache
        with open('resolution-cache.json', 'w') as f:
            json.dump(self.cache, f, indent=2)
        
        print(f"   Progress saved: {len(self.new_priority_changes)} new priority changes, {len(self.new_claimed_nodes)} new claims")

def main():
    resolver = ConflictResolver()
    
    print("Starting resolution of remaining conflicts...")
    print(f"Total unresolved patterns: {len(resolver.unresolved_patterns)}")
    
    # First, handle automatic patterns
    auto_resolutions = resolver.analyze_automatic_patterns()
    print(f"Automatic resolutions found: {len(auto_resolutions)}")
    
    for resolution in auto_resolutions:
        pattern = resolution['pattern']
        decision = resolution['decision']
        print(f"AUTO: {pattern['node_ids']} -> {decision['reason']}")
        
        if decision['type'] == 'priority':
            loser = [nid for nid in resolution['node_ids'] if nid != decision['winner']][0]
            resolver.new_priority_changes[loser] = 6
    
    # Save automatic resolutions
    resolver.save_progress()
    
    # Then handle large conflicts interactively
    resolver.resolve_large_conflicts()
    
    print(f"\nResolution session complete!")
    print(f"New priority changes: {len(resolver.new_priority_changes)}")
    print(f"New node claims: {len(resolver.new_claimed_nodes)}")

if __name__ == "__main__":
    main()