#!/usr/bin/env python3
"""
Clear bad API cache entries that have 'not_found' errors
"""

import json

# Load cache
with open('resolution-cache.json', 'r') as f:
    cache = json.load(f)

# Find and remove entries with 'not_found' error
api_cache = cache.get('api_cache', {})
keys_to_remove = []

for key, value in api_cache.items():
    if isinstance(value, dict) and value.get('error') == 'not_found':
        keys_to_remove.append(key)

print(f"Found {len(keys_to_remove)} entries with 'not_found' error")
print("Removing:", keys_to_remove[:10], "..." if len(keys_to_remove) > 10 else "")

# Remove the bad entries
for key in keys_to_remove:
    del api_cache[key]

# Save updated cache
cache['api_cache'] = api_cache
with open('resolution-cache.json', 'w') as f:
    json.dump(cache, f, indent=2)

print(f"Removed {len(keys_to_remove)} bad cache entries")
print("Now run manual_resolver.py again and it will fetch fresh data from the API")