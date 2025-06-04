#!/usr/bin/env python3
"""
Simple Download-Based Conflict Resolver

Strategy:
1. Check download counts for conflicting packages
2. If significant difference (>3x), auto-assign to higher download package
3. If similar downloads, ask for manual decision
"""

import json
import requests
import time
from typing import Dict, List, Optional

class SimpleResolver:
    def __init__(self):
        self.base_url = "https://api.comfy.org"
        self.session = requests.Session()
        
        # Load existing data
        with open('unresolved_conflicts.json', 'r') as f:
            self.unresolved_patterns = json.load(f)
        
        with open('resolution-cache.json', 'r') as f:
            self.cache = json.load(f)
        
        self.new_claimed_nodes = {}
        self.new_priority_changes = {}
        self.api_cache = self.cache.get('api_cache', {})
        
        # Stats
        self.auto_resolved = 0
        self.manual_decisions = 0
        self.skipped = 0
    
    def get_package_downloads(self, package_id: str) -> Optional[int]:
        """Get download count for a package"""
        if package_id in self.api_cache:
            return self.api_cache[package_id].get('downloads', 0)
        
        try:
            print(f"    Fetching: {package_id}...")
            response = self.session.get(
                f"{self.base_url}/nodes/search",
                params={'search': package_id, 'limit': 50}
            )
            
            if response.status_code == 200:
                data = response.json()
                nodes = data.get('nodes', [])
                
                # Find exact match
                for node in nodes:
                    if node.get('node_id') == package_id:
                        downloads = node.get('stats', {}).get('downloads', 0)
                        
                        # Cache the info
                        self.api_cache[package_id] = {
                            'downloads': downloads,
                            'description': node.get('description', ''),
                            'author': node.get('author', ''),
                            'status': node.get('status', 'active')
                        }
                        
                        return downloads
                
                # No exact match found
                print(f"      No exact match found for {package_id}")
                self.api_cache[package_id] = {'downloads': 0, 'error': 'not_found'}
                return 0
                
            else:
                print(f"      API error {response.status_code} for {package_id}")
                return None
                
        except Exception as e:
            print(f"      Exception for {package_id}: {e}")
            return None
        
        # Rate limiting
        time.sleep(0.1)
    
    def resolve_conflicts(self):
        """Resolve all unresolved conflicts"""
        print("=== Simple Download-Based Conflict Resolution ===\n")
        
        total_patterns = len(self.unresolved_patterns)
        
        for i, pattern in enumerate(self.unresolved_patterns):
            print(f"\n[{i+1}/{total_patterns}] {pattern['node_ids']}")
            print(f"  Conflicts: {pattern['conflict_count']}")
            print(f"  Sample nodes: {', '.join(pattern['sample_names'][:3])}...")
            
            node_ids = [nid.strip() for nid in pattern['node_ids'].split(',')]
            
            # Get download counts
            downloads = {}
            for nid in node_ids:
                dl_count = self.get_package_downloads(nid)
                downloads[nid] = dl_count if dl_count is not None else 0
                print(f"    {nid}: {downloads[nid]:,} downloads")
            
            # Check for significant difference (3x or more)
            max_downloads = max(downloads.values())
            min_downloads = min(downloads.values())
            
            if max_downloads == 0:
                print(f"  ❌ SKIP: No download data available")
                self.skipped += 1
                continue
            
            if max_downloads >= min_downloads * 3:
                # Significant difference - auto resolve
                winner = max(downloads.keys(), key=lambda k: downloads[k])
                print(f"  ✅ AUTO: {winner} wins ({downloads[winner]:,} vs others)")
                
                # Claim all nodes for the winner
                for record in pattern['records']:
                    self.new_claimed_nodes[record['name']] = winner
                
                self.auto_resolved += 1
                
            else:
                # Similar downloads - manual decision
                print(f"  ⚠️  MANUAL: Similar download counts")
                
                # Show package info
                for nid in node_ids:
                    info = self.api_cache.get(nid, {})
                    print(f"    {nid}:")
                    print(f"      Downloads: {downloads[nid]:,}")
                    print(f"      Author: {info.get('author', 'Unknown')}")
                    print(f"      Description: {info.get('description', 'No description')[:80]}...")
                    print(f"      Status: {info.get('status', 'unknown')}")
                
                print(f"  Which package should claim these {pattern['conflict_count']} nodes?")
                for j, nid in enumerate(node_ids):
                    print(f"    {j+1}. {nid}")
                print(f"    s. Skip for now")
                
                while True:
                    choice = input(f"  Choice [1-{len(node_ids)}, s]: ").strip().lower()
                    
                    if choice == 's':
                        print(f"  ⏭️  Skipped")
                        self.skipped += 1
                        break
                    
                    try:
                        choice_idx = int(choice) - 1
                        if 0 <= choice_idx < len(node_ids):
                            winner = node_ids[choice_idx]
                            print(f"  ✅ MANUAL: {winner} selected")
                            
                            # Claim all nodes for the winner
                            for record in pattern['records']:
                                self.new_claimed_nodes[record['name']] = winner
                            
                            self.manual_decisions += 1
                            break
                        else:
                            print(f"  Invalid choice. Try again.")
                    except ValueError:
                        print(f"  Invalid choice. Try again.")
            
            # Save progress every 10 patterns
            if (i + 1) % 10 == 0:
                self.save_progress()
                print(f"  💾 Progress saved (auto: {self.auto_resolved}, manual: {self.manual_decisions}, skipped: {self.skipped})")
        
        # Final save
        self.save_progress()
    
    def save_progress(self):
        """Save current progress"""
        # Update cache
        self.cache['claimed_node_names'].update(self.new_claimed_nodes)
        self.cache['search_priority_changes'].update(self.new_priority_changes)
        self.cache['api_cache'] = self.api_cache
        
        # Save cache
        with open('resolution-cache.json', 'w') as f:
            json.dump(self.cache, f, indent=2)
    
    def print_summary(self):
        """Print resolution summary"""
        total_processed = self.auto_resolved + self.manual_decisions + self.skipped
        
        print(f"\n=== RESOLUTION SUMMARY ===")
        print(f"Total patterns processed: {total_processed}")
        print(f"Auto-resolved (download difference): {self.auto_resolved}")
        print(f"Manual decisions: {self.manual_decisions}")
        print(f"Skipped: {self.skipped}")
        print(f"New node claims: {len(self.new_claimed_nodes)}")
        
        if self.new_claimed_nodes:
            print(f"\nSample new claims:")
            for i, (node_name, pkg) in enumerate(list(self.new_claimed_nodes.items())[:5]):
                print(f"  {node_name} -> {pkg}")
            if len(self.new_claimed_nodes) > 5:
                print(f"  ... and {len(self.new_claimed_nodes) - 5} more")

def main():
    resolver = SimpleResolver()
    
    try:
        resolver.resolve_conflicts()
    except KeyboardInterrupt:
        print(f"\n\n⚠️  Interrupted by user. Saving progress...")
        resolver.save_progress()
    
    resolver.print_summary()

if __name__ == "__main__":
    main()