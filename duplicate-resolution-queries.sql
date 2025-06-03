-- Node Duplicate Resolution SQL Queries
-- Generated: 2025-01-06
-- Purpose: Update search priorities and implement node name claiming

-- =============================================================================
-- SECTION 1: UPDATE SEARCH PRIORITIES
-- =============================================================================
-- Lower priority numbers indicate higher search ranking
-- Default priority is 5, adjustments range from 6-10

-- Priority 6: Minor deprioritization for forks with fewer downloads
UPDATE nodes 
SET search_priority = 6 
WHERE id = 'comfyui_ryanontheinside';
-- Reason: Fork with fewer downloads (1,374) vs typo version (5,331)

UPDATE nodes 
SET search_priority = 6 
WHERE id = 'comfyui_essentials_mb';
-- Reason: Fork with fewer downloads (2,145) vs original (457,540)

UPDATE nodes 
SET search_priority = 6 
WHERE id = 'comfyui_ipadapter_plus_fork';
-- Reason: Fork with much fewer downloads (927) vs original (268,329)

-- Priority 8: Moderate deprioritization for security concerns
UPDATE nodes 
SET search_priority = 8 
WHERE id = 'ComfyUI_KurtHokke-Nodes';
-- Reason: Security concerns - multiple flags for subprocess, exec/eval usage

UPDATE nodes 
SET search_priority = 8 
WHERE id = 'ComfyUI_KurtHokke_Nodes';
-- Reason: Security concerns - multiple flags for subprocess, exec/eval usage

-- Priority 10: Significant deprioritization for test packs
UPDATE nodes 
SET search_priority = 10 
WHERE id = 'node-registry-test';
-- Reason: Test pack should not compete with production pack comfyui-animatediff-evolved

-- =============================================================================
-- SECTION 2: NODE NAME CLAIMING (PREEMPTED_NODE_NAMES TABLE)
-- =============================================================================
-- Insert or update preempted node names to establish authoritative ownership

-- Text processing nodes claimed by comfyui-mixlab-nodes
INSERT INTO preempted_node_names (node_name, node_id, reason, created_at)
VALUES 
    ('TextSplitByDelimiter', 'comfyui-mixlab-nodes', 'Higher downloads (127,430 vs 16,043) and broader multimedia scope', NOW()),
    ('Color', 'comfyui-mixlab-nodes', '10x more downloads (127,430 vs 13,082) and broader color/image functionality', NOW())
ON CONFLICT (node_name) DO UPDATE SET
    node_id = EXCLUDED.node_id,
    reason = EXCLUDED.reason,
    updated_at = NOW();

-- Ollama nodes claimed by comfyui-ollama
INSERT INTO preempted_node_names (node_name, node_id, reason, created_at)
VALUES 
    ('OllamaGenerate', 'comfyui-ollama', 'Original implementation with 19x more downloads (65,789 vs 3,455)', NOW()),
    ('OllamaGenerateAdvance', 'comfyui-ollama', 'Original implementation with 19x more downloads (65,789 vs 3,455)', NOW()),
    ('OllamaVision', 'comfyui-ollama', 'Original implementation with 19x more downloads (65,789 vs 3,455)', NOW())
ON CONFLICT (node_name) DO UPDATE SET
    node_id = EXCLUDED.node_id,
    reason = EXCLUDED.reason,
    updated_at = NOW();

-- ReActor nodes claimed by comfyui-reactor-node
INSERT INTO preempted_node_names (node_name, node_id, reason, created_at)
VALUES 
    ('ImageRGBA2RGB', 'comfyui-reactor-node', 'comfyui-reactor not found in actual database registry', NOW()),
    ('ReActorBuildFaceModel', 'comfyui-reactor-node', 'comfyui-reactor not found in actual database registry', NOW()),
    ('ReActorFaceSwap', 'comfyui-reactor-node', 'comfyui-reactor not found in actual database registry', NOW())
ON CONFLICT (node_name) DO UPDATE SET
    node_id = EXCLUDED.node_id,
    reason = EXCLUDED.reason,
    updated_at = NOW();

-- =============================================================================
-- SECTION 3: VERIFICATION QUERIES
-- =============================================================================
-- Run these to verify the changes were applied correctly

-- Verify priority changes
SELECT id, search_priority 
FROM nodes 
WHERE id IN (
    'comfyui_ryanontheinside',
    'comfyui_essentials_mb', 
    'comfyui_ipadapter_plus_fork',
    'ComfyUI_KurtHokke-Nodes',
    'ComfyUI_KurtHokke_Nodes',
    'node-registry-test'
)
ORDER BY search_priority, id;

-- Verify claimed node names
SELECT node_name, node_id, reason 
FROM preempted_node_names 
WHERE node_name IN (
    'TextSplitByDelimiter',
    'Color', 
    'OllamaGenerate',
    'OllamaGenerateAdvance',
    'OllamaVision',
    'ImageRGBA2RGB',
    'ReActorBuildFaceModel',
    'ReActorFaceSwap'
)
ORDER BY node_name;

-- =============================================================================
-- SUMMARY
-- =============================================================================
-- Priority Changes: 6 node packs adjusted (priorities 6, 8, 10)
-- Node Claims: 8 specific node names claimed by authoritative packs
-- Conflicts Resolved: 334 of 714 total duplicate conflicts
-- Remaining: 380 conflicts (primarily data-analysis vs pt-wrapper intentional ties)