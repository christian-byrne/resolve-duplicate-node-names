#!/usr/bin/env python3
"""
Manual Conflict Resolver

Simple tool to manually resolve the largest remaining conflicts one by one.
Shows the node names and package names for informed decisions.
"""

import json
from typing import Dict, List

class ManualResolver:
    def __init__(self):
        # Load existing data
        with open('unresolved_conflicts.json', 'r') as f:
            self.unresolved_patterns = json.load(f)
        
        with open('resolution-cache.json', 'r') as f:
            self.cache = json.load(f)
        
        self.new_claimed_nodes = {}
        self.new_priority_changes = {}
        
        # API setup
        self.base_url = "https://api.comfy.org"
        import requests
        self.session = requests.Session()
        self.api_cache = self.cache.get('api_cache', {})
        
        # Stats
        self.resolved_patterns = 0
        self.total_nodes_resolved = 0
    
    def get_package_info(self, node_id: str) -> Dict:
        """Get package information from API using /nodes/{nodeId} endpoint"""
        if node_id in self.api_cache:
            return self.api_cache[node_id]
        
        try:
            print(f"    Fetching info for {node_id}...")
            response = self.session.get(f"{self.base_url}/nodes/{node_id}")
            
            if response.status_code == 200:
                data = response.json()
                
                # Extract relevant info - note the structure is different!
                info = {
                    'downloads': data.get('downloads', 0),  # downloads is at top level, not in stats
                    'description': data.get('description', 'No description'),
                    'author': data.get('author', 'Unknown') if data.get('author') else 'Unknown',
                    'status': data.get('status', 'unknown'),
                    'repository': data.get('repository', ''),
                    'publisher': data.get('publisher', {}).get('name', 'Unknown'),
                    'name': data.get('name', node_id),
                    'tags': data.get('tags', [])
                }
                
                # Cache the result
                self.api_cache[node_id] = info
                return info
                
            elif response.status_code == 404:
                info = {'downloads': 0, 'error': 'Package not found', 'author': 'Unknown', 'status': 'not_found'}
                self.api_cache[node_id] = info
                return info
            else:
                info = {'downloads': 0, 'error': f'API error {response.status_code}', 'author': 'Unknown', 'status': 'error'}
                self.api_cache[node_id] = info
                return info
                
        except Exception as e:
            info = {'downloads': 0, 'error': f'Request failed: {str(e)}', 'author': 'Unknown', 'status': 'error'}
            self.api_cache[node_id] = info
            return info
    
    def show_pattern_details(self, pattern: Dict):
        """Show detailed information about a conflict pattern"""
        node_ids = [nid.strip() for nid in pattern['node_ids'].split(',')]
        
        print(f"\n{'='*60}")
        print(f"CONFLICT: {pattern['node_ids']}")
        print(f"Total conflicting nodes: {pattern['conflict_count']}")
        print(f"{'='*60}")
        
        print(f"\nPackages involved:")
        for i, nid in enumerate(node_ids):
            # Get package info including downloads
            info = self.get_package_info(nid)
            downloads = info.get('downloads', 0)
            status = info.get('status', 'unknown')
            author = info.get('author', 'Unknown')
            publisher = info.get('publisher', 'Unknown')
            name = info.get('name', nid)
            
            print(f"  {i+1}. {nid} ({name})")
            print(f"      Downloads: {downloads:,}")
            print(f"      Publisher: {publisher}")
            if author and author != 'Unknown':
                print(f"      Author: {author}")
            print(f"      Status: {status}")
            if 'error' in info:
                print(f"      Note: {info['error']}")
            print()
        
        print(f"\nSample conflicting node names:")
        for name in pattern['sample_names'][:10]:  # Show up to 10
            print(f"  - {name}")
        if len(pattern['records']) > len(pattern['sample_names']):
            remaining = len(pattern['records']) - len(pattern['sample_names'])
            print(f"  ... and {remaining} more nodes")
        
        print(f"\nAll conflicting node names:")
        all_names = [record['name'] for record in pattern['records']]
        for i, name in enumerate(all_names):
            if i > 0 and i % 5 == 0:
                print()
            print(f"{name:25}", end=" ")
        print()
    
    def resolve_pattern(self, pattern: Dict) -> bool:
        """Resolve a single conflict pattern. Returns True if resolved."""
        self.show_pattern_details(pattern)
        
        node_ids = [nid.strip() for nid in pattern['node_ids'].split(',')]
        
        print(f"\nResolution options:")
        print(f"1. Claim all nodes for a specific package")
        print(f"2. Set priority (lower priority = wins less often)")
        print(f"3. Skip this conflict for now")
        print(f"4. Exit resolver")
        
        while True:
            choice = input(f"\nChoice [1-4]: ").strip()
            
            if choice == '1':
                # Claim nodes for a package
                print(f"\nWhich package should claim all {pattern['conflict_count']} nodes?")
                for i, nid in enumerate(node_ids):
                    print(f"  {i+1}. {nid}")
                
                while True:
                    pkg_choice = input(f"Package [1-{len(node_ids)}]: ").strip()
                    try:
                        pkg_idx = int(pkg_choice) - 1
                        if 0 <= pkg_idx < len(node_ids):
                            winner = node_ids[pkg_idx]
                            print(f"\n✅ Claiming {pattern['conflict_count']} nodes for: {winner}")
                            
                            # Claim all nodes for the winner
                            for record in pattern['records']:
                                self.new_claimed_nodes[record['name']] = winner
                            
                            self.resolved_patterns += 1
                            self.total_nodes_resolved += pattern['conflict_count']
                            return True
                        else:
                            print(f"Invalid choice. Enter 1-{len(node_ids)}")
                    except ValueError:
                        print(f"Invalid choice. Enter 1-{len(node_ids)}")
            
            elif choice == '2':
                # Set priority
                print(f"\nWhich package should have LOWER priority (loses conflicts)?")
                for i, nid in enumerate(node_ids):
                    print(f"  {i+1}. {nid}")
                
                while True:
                    pkg_choice = input(f"Package [1-{len(node_ids)}]: ").strip()
                    try:
                        pkg_idx = int(pkg_choice) - 1
                        if 0 <= pkg_idx < len(node_ids):
                            loser = node_ids[pkg_idx]
                            
                            print(f"What priority should {loser} have? (higher number = lower priority)")
                            print(f"Current default: 5, Suggested: 6-8")
                            
                            while True:
                                priority_input = input(f"Priority [6-10]: ").strip()
                                try:
                                    priority = int(priority_input)
                                    if 6 <= priority <= 10:
                                        print(f"\n✅ Setting {loser} priority to {priority}")
                                        self.new_priority_changes[loser] = priority
                                        
                                        self.resolved_patterns += 1
                                        self.total_nodes_resolved += pattern['conflict_count']
                                        return True
                                    else:
                                        print(f"Priority should be 6-10")
                                except ValueError:
                                    print(f"Invalid number. Enter 6-10")
                        else:
                            print(f"Invalid choice. Enter 1-{len(node_ids)}")
                    except ValueError:
                        print(f"Invalid choice. Enter 1-{len(node_ids)}")
            
            elif choice == '3':
                print(f"⏭️  Skipping this conflict")
                return False
            
            elif choice == '4':
                print(f"🛑 Exiting resolver")
                return None  # Signal to exit
            
            else:
                print(f"Invalid choice. Enter 1-4")
    
    def resolve_largest_conflicts(self, limit: int = 10):
        """Resolve the largest conflict patterns interactively"""
        print(f"=== Manual Conflict Resolver ===")
        print(f"Total unresolved patterns: {len(self.unresolved_patterns)}")
        print(f"Will process up to {limit} largest conflicts")
        
        # Sort by conflict count descending
        sorted_patterns = sorted(self.unresolved_patterns, 
                               key=lambda x: x['conflict_count'], reverse=True)
        
        for i, pattern in enumerate(sorted_patterns[:limit]):
            print(f"\n[{i+1}/{min(limit, len(sorted_patterns))}] Processing pattern...")
            
            result = self.resolve_pattern(pattern)
            
            if result is None:  # Exit requested
                break
            elif result:  # Pattern resolved
                # Save progress after each resolution
                self.save_progress()
                print(f"💾 Progress saved")
            
            # Ask if user wants to continue
            if i < min(limit, len(sorted_patterns)) - 1:
                continue_choice = input(f"\nContinue to next conflict? [y/n]: ").strip().lower()
                if continue_choice != 'y':
                    break
        
        self.print_summary()
    
    def save_progress(self):
        """Save current progress"""
        # Update cache
        self.cache['claimed_node_names'].update(self.new_claimed_nodes)
        self.cache['search_priority_changes'].update(self.new_priority_changes)
        self.cache['api_cache'] = self.api_cache  # Save API cache too
        
        # Save cache
        with open('resolution-cache.json', 'w') as f:
            json.dump(self.cache, f, indent=2)
    
    def print_summary(self):
        """Print resolution summary"""
        print(f"\n{'='*60}")
        print(f"RESOLUTION SESSION SUMMARY")
        print(f"{'='*60}")
        print(f"Patterns resolved: {self.resolved_patterns}")
        print(f"Total nodes resolved: {self.total_nodes_resolved}")
        print(f"New node claims: {len(self.new_claimed_nodes)}")
        print(f"New priority changes: {len(self.new_priority_changes)}")
        
        if self.new_claimed_nodes:
            print(f"\nNew node claims (sample):")
            for i, (node_name, pkg) in enumerate(list(self.new_claimed_nodes.items())[:5]):
                print(f"  {node_name} -> {pkg}")
            if len(self.new_claimed_nodes) > 5:
                print(f"  ... and {len(self.new_claimed_nodes) - 5} more")
        
        if self.new_priority_changes:
            print(f"\nNew priority changes:")
            for pkg, priority in self.new_priority_changes.items():
                print(f"  {pkg} -> priority {priority}")

def main():
    resolver = ManualResolver()
    
    try:
        # Process up to 15 largest conflicts
        resolver.resolve_largest_conflicts(limit=15)
    except KeyboardInterrupt:
        print(f"\n\n⚠️  Interrupted by user. Saving progress...")
        resolver.save_progress()
        resolver.print_summary()

if __name__ == "__main__":
    main()