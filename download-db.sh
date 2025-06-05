#!/bin/bash

# Load .env file if it exists
if [ -f .env ]; then
    source .env
fi

# Check if connection string is provided
if [ -z "$SUPABASE_CONNECTION_STRING" ]; then
    echo "Error: SUPABASE_CONNECTION_STRING environment variable not set"
    echo "Usage: SUPABASE_CONNECTION_STRING='your-connection-string' ./download-db.sh"
    echo "Or export it first: export SUPABASE_CONNECTION_STRING='your-connection-string'"
    exit 1
fi

# Try downloading just the specific tables we need using pg_dump directly
echo "Downloading specific tables using pg_dump..."
pg_dump "$SUPABASE_CONNECTION_STRING" \
  --data-only \
  --table=public.nodes \
  --table=public.comfy_nodes \
  --table=public.node_versions \
  --no-owner \
  --no-privileges \
  -f nodes_data.sql

echo "Download complete!"