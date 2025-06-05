-- Node Duplicate Resolution SQL Queries
-- Generated: 2025-06-05 01:40:33
-- Purpose: Update search priorities and implement node name claiming

-- =============================================================================
-- SECTION 1: UPDATE SEARCH PRIORITIES
-- =============================================================================
-- Lower priority numbers indicate higher search ranking
-- Default priority is 5, adjustments range from 6-10

-- Priority 4: Custom priority level
UPDATE nodes
SET search_priority = 4
WHERE id = 'comfyui-rmbg';

-- Priority 6: Minor deprioritization
UPDATE nodes
SET search_priority = 6
WHERE id = 'comfyui_ryanontheinside';

UPDATE nodes
SET search_priority = 6
WHERE id = 'comfyui_essentials_mb';

UPDATE nodes
SET search_priority = 6
WHERE id = 'comfyui_ipadapter_plus_fork';

UPDATE nodes
SET search_priority = 6
WHERE id = 'pt-wrapper';

UPDATE nodes
SET search_priority = 6
WHERE id = 'havocscall_custom_nodes';

UPDATE nodes
SET search_priority = 6
WHERE id = 'comfyui-hakuimg';

UPDATE nodes
SET search_priority = 6
WHERE id = 'comfyui_if_ai_tools';

UPDATE nodes
SET search_priority = 6
WHERE id = 'bongsang';

UPDATE nodes
SET search_priority = 6
WHERE id = 'comfyui-glifnodes-fork';

UPDATE nodes
SET search_priority = 6
WHERE id = 'was-node-suite-comfyui';

UPDATE nodes
SET search_priority = 6
WHERE id = 'comfyui_billbum_api_nodes';

UPDATE nodes
SET search_priority = 6
WHERE id = 'comfuinoda-Navyblue';

UPDATE nodes
SET search_priority = 6
WHERE id = 'comfyui-deforum';

-- Priority 8: Significant deprioritization
UPDATE nodes
SET search_priority = 8
WHERE id = 'ComfyUI_KurtHokke-Nodes';

UPDATE nodes
SET search_priority = 8
WHERE id = 'ComfyUI_KurtHokke_Nodes';

UPDATE nodes
SET search_priority = 8
WHERE id = 'comfyui-pixtralllamavision';

-- Priority 10: Lowest priority (test packages, deprecated)
UPDATE nodes
SET search_priority = 10
WHERE id = 'node-registry-test';

-- =============================================================================
-- SECTION 2: NODE NAME PREEMPTION CLAIMS
-- =============================================================================
-- Explicit node name ownership to resolve remaining conflicts

-- Claims for package: ComfyUI-Fooocus-V2-Expansion (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('FooocusV2Expansion', 'ComfyUI-Fooocus-V2-Expansion')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: ComfyUI-GGUF (5 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('CLIPLoaderGGUF', 'ComfyUI-GGUF')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('DualCLIPLoaderGGUF', 'ComfyUI-GGUF')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('TripleCLIPLoaderGGUF', 'ComfyUI-GGUF')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('UnetLoaderGGUF', 'ComfyUI-GGUF')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('UnetLoaderGGUFAdvanced', 'ComfyUI-GGUF')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: ComfyUI-kokoro-TTS (2 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('(Down)Load Kokoro Model', 'ComfyUI-kokoro-TTS')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Kokoro Audio Generator', 'ComfyUI-kokoro-TTS')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: ComfyUI_Gemini_Expanded_API (2 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SSL_GeminiAPIKeyConfig', 'ComfyUI_Gemini_Expanded_API')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SSL_GeminiTextPrompt', 'ComfyUI_Gemini_Expanded_API')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: ComfyUI_KurtHokke-Nodes (40 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('AIO_Tuner_Pipe', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ApplyCondsExtraOpts', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('BooleanFromPipe', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('BooleanToPipe', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('COND_ExtraOpts', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('COND_ExtraOpts_2', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('COND_SET_STRENGTH_ExtraOpts', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ChainTextEncode', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('CkptPipe', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('EmptyLatentSize', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('EmptyLatentSize64', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ExpMath', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ExpMathDual', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ExpMathQuad', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('LoadUnetAndClip', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('MergeExtraOpts', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ModelPipe1', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ModelPipe2', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('NoModel_CkptLoader', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('NoNegExtraOpts', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Node_BOOL', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Node_Float', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Node_INT', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Node_RandomRange', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Node_String', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Node_StringMultiline', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SEED_ExtraOpts', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SamplerCustomAdvanced_Pipe', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SamplerSel', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SchedulerSel', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SedOnString', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('UnetClipLoraLoader', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('UnetClipLoraLoaderBasic', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('VAE_ExtraOpts', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ViewExtraOpts', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('batchsize_ExtraOpts', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('get_lora_metadata', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('re_sub_str', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('str_str', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('str_str_str_str', 'ComfyUI_KurtHokke-Nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: ComfyUI_Lama_Remover_Revived (2 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('LamaRemover', 'ComfyUI_Lama_Remover_Revived')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('LamaRemoverIMG', 'ComfyUI_Lama_Remover_Revived')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: HJH_StableAnimator (5 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('StableAnimatorDWPoseDetectorAlignedModels', 'HJH_StableAnimator')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('StableAnimatorLoadFramesFromFolderNode', 'HJH_StableAnimator')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('StableAnimatorModels', 'HJH_StableAnimator')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('StableAnimatorNode', 'HJH_StableAnimator')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('StableAnimatorSkeletonNode', 'HJH_StableAnimator')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: ardent-nodes-comfyui (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('FormatFilenamePrefixByDate', 'ardent-nodes-comfyui')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: bilbox-comfyui (2 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('BilboXLut', 'bilbox-comfyui')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('BilboXVignette', 'bilbox-comfyui')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfy_felsirnodes (7 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Aspect from Image', 'comfy_felsirnodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Focal Rescale', 'comfy_felsirnodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Focal Rescale Rel', 'comfy_felsirnodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Focalpoint from SEGS', 'comfy_felsirnodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Latent Aspect', 'comfy_felsirnodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Mask to Crop', 'comfy_felsirnodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Rescale Maintain Aspect', 'comfy_felsirnodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-art-venture (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ColorCorrect', 'comfyui-art-venture')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-birefnet-super (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('BiRefNet_Lite', 'comfyui-birefnet-super')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-claude (3 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Combine Texts', 'comfyui-claude')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Describe Image', 'comfyui-claude')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Transform Text', 'comfyui-claude')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-clipslider (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('CLIPSlider', 'comfyui-clipslider')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-easyapi-nodes (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ListMerge', 'comfyui-easyapi-nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-fairlab (11 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('CLIPTranslatedClass', 'comfyui-fairlab')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('DownloadImageClass', 'comfyui-fairlab')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('FixUTF8StringClass', 'comfyui-fairlab')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ImageResizeClass', 'comfyui-fairlab')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('LoadImageFromFolderClass', 'comfyui-fairlab')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SaveImageToFolderClass', 'comfyui-fairlab')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SaveImagesToFolderClass', 'comfyui-fairlab')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SaveStringToFolderClass', 'comfyui-fairlab')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('StringCombineClass', 'comfyui-fairlab')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('StringFieldClass', 'comfyui-fairlab')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('TranslateStringClass', 'comfyui-fairlab')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-googletrans (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('googletrans', 'comfyui-googletrans')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-hunyan3dwrapper (26 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('CV2InpaintTexture', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('DownloadAndLoadHy3DDelightModel', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('DownloadAndLoadHy3DPaintModel', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DApplyTexture', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DBakeFromMultiview', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DCameraConfig', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DDelightImage', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DDiffusersSchedulerConfig', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DExportMesh', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DGenerateMesh', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DGetMeshPBRTextures', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DIMRemesh', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DLoadMesh', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DMeshInfo', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DMeshUVWrap', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DMeshVerticeInpaintTexture', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DModelLoader', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DPostprocessMesh', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DRenderMultiView', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DRenderMultiViewDepth', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DRenderSingleView', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DSampleMultiView', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DSetMeshPBRAttributes', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DSetMeshPBRTextures', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DTorchCompileSettings', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Hy3DVAEDecode', 'comfyui-hunyan3dwrapper')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-kjnodes (2 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('MergeImageChannels', 'comfyui-kjnodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Sleep', 'comfyui-kjnodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-levelpixel-advanced (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ImageRemoveBackground|LP', 'comfyui-levelpixel-advanced')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-logic (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('String', 'comfyui-logic')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-logicutils (2 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('RoundNode', 'comfyui-logicutils')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('WeightedRandomChoice', 'comfyui-logicutils')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-login (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('LoadImageIncognito', 'comfyui-login')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-mixlab-nodes (3 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Color', 'comfyui-mixlab-nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SenseVoiceNode', 'comfyui-mixlab-nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('TextSplitByDelimiter', 'comfyui-mixlab-nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-ollama (3 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('OllamaGenerate', 'comfyui-ollama')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('OllamaGenerateAdvance', 'comfyui-ollama')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('OllamaVision', 'comfyui-ollama')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-opttools (9 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('opt Get cell value by item from GoogleSheets', 'comfyui-opttools')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('opt Get cell value from GoogleSheets', 'comfyui-opttools')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('opt Image Save', 'comfyui-opttools')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('opt PipeFromAny', 'comfyui-opttools')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('opt PipeToAny', 'comfyui-opttools')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('opt Save image to GoogleDrive', 'comfyui-opttools')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('opt Save text to GoogleSheets', 'comfyui-opttools')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('opt translate argos', 'comfyui-opttools')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('opt translate google', 'comfyui-opttools')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-post-processing-nodes (3 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Blur', 'comfyui-post-processing-nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Glow', 'comfyui-post-processing-nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Pixelize', 'comfyui-post-processing-nodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-prompt-control (13 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('EditableCLIPEncode', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('FilterSchedule', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('LoRAScheduler', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('PCApplySettings', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('PCPromptFromSchedule', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('PCScheduleAddMasks', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('PCScheduleSettings', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('PCSplitSampling', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('PCWrapGuider', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('PromptControlSimple', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('PromptToSchedule', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ScheduleToCond', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ScheduleToModel', 'comfyui-prompt-control')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-reactor-node (13 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ImageRGBA2RGB', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorBuildFaceModel', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorFaceBoost', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorFaceSwap', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorFaceSwapOpt', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorImageDublicator', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorLoadFaceModel', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorMakeFaceModelBatch', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorMaskHelper', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorOptions', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorRestoreFace', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorSaveFaceModel', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ReActorUnload', 'comfyui-reactor-node')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-saveimages3 (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SaveImageS3', 'comfyui-saveimages3')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-saveimagewithmetadata (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SaveImageWithMetaData', 'comfyui-saveimagewithmetadata')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-styles_csv_loader (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Load Styles CSV', 'comfyui-styles_csv_loader')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-textnodes (2 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Prompt Truncate', 'comfyui-textnodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Tidy Tags', 'comfyui-textnodes')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-ultimate-openpose-editor (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('OpenposeEditorNode', 'comfyui-ultimate-openpose-editor')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui-ycyy-lorainfo (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('LoraInfo', 'comfyui-ycyy-lorainfo')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui_birefnet_ll (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('BlurFusionForegroundEstimation', 'comfyui_birefnet_ll')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui_caption_this (3 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('JanusProCaptionImageUnderDirectory|Mie', 'comfyui_caption_this')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('JanusProDescribeImage|Mie', 'comfyui_caption_this')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('JanusProModelLoader|Mie', 'comfyui_caption_this')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui_cryptocat (6 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('CryptoCatImage', 'comfyui_cryptocat')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('DecodeCryptoNode', 'comfyui_cryptocat')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ExcuteCryptoNode', 'comfyui_cryptocat')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('RandomSeedNode', 'comfyui_cryptocat')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SaveCryptoBridgeNode', 'comfyui_cryptocat')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SaveCryptoNode', 'comfyui_cryptocat')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui_facesimilarity (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('Face Similarity', 'comfyui_facesimilarity')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui_jags_audiotools (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('SaveAudioTensor', 'comfyui_jags_audiotools')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui_met_suite (3 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('BBOXPadding', 'comfyui_met_suite')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('BBOXResize', 'comfyui_met_suite')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ResizeKeepRatio', 'comfyui_met_suite')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui_ryanonyheinside (4 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('AudioCombine', 'comfyui_ryanonyheinside')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('AudioConcatenate', 'comfyui_ryanonyheinside')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('AudioInfo', 'comfyui_ryanonyheinside')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('ColorPicker', 'comfyui_ryanonyheinside')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: comfyui_ttp_toolset (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('TTPlanet_Tile_Preprocessor_Simple', 'comfyui_ttp_toolset')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- Claims for package: easyanimate (1 nodes)
INSERT INTO preempted_node_names (node_name, node_id)
VALUES ('TextBox', 'easyanimate')
ON CONFLICT (node_name) DO UPDATE SET node_id = EXCLUDED.node_id;

-- =============================================================================
-- ROLLBACK QUERIES (for reverting changes if needed)
-- =============================================================================

-- Rollback priority changes to default (5):
-- UPDATE nodes SET search_priority = 5 WHERE id = 'comfyui_ryanontheinside';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'node-registry-test';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'comfyui_essentials_mb';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'ComfyUI_KurtHokke-Nodes';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'ComfyUI_KurtHokke_Nodes';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'comfyui_ipadapter_plus_fork';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'pt-wrapper';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'comfyui-pixtralllamavision';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'havocscall_custom_nodes';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'comfyui-hakuimg';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'comfyui-rmbg';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'comfyui_if_ai_tools';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'bongsang';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'comfyui-glifnodes-fork';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'was-node-suite-comfyui';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'comfyui_billbum_api_nodes';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'comfuinoda-Navyblue';
-- UPDATE nodes SET search_priority = 5 WHERE id = 'comfyui-deforum';

-- Rollback node claims:
-- DELETE FROM preempted_node_names WHERE node_name = 'TextSplitByDelimiter';
-- DELETE FROM preempted_node_names WHERE node_name = 'Color';
-- DELETE FROM preempted_node_names WHERE node_name = 'OllamaGenerate';
-- DELETE FROM preempted_node_names WHERE node_name = 'OllamaGenerateAdvance';
-- DELETE FROM preempted_node_names WHERE node_name = 'OllamaVision';
-- DELETE FROM preempted_node_names WHERE node_name = 'ImageRGBA2RGB';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorBuildFaceModel';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorFaceSwap';
-- DELETE FROM preempted_node_names WHERE node_name = '(Down)Load Kokoro Model';
-- DELETE FROM preempted_node_names WHERE node_name = 'AIO_Tuner_Pipe';
-- DELETE FROM preempted_node_names WHERE node_name = 'ApplyCondsExtraOpts';
-- DELETE FROM preempted_node_names WHERE node_name = 'Aspect from Image';
-- DELETE FROM preempted_node_names WHERE node_name = 'BBOXPadding';
-- DELETE FROM preempted_node_names WHERE node_name = 'BBOXResize';
-- DELETE FROM preempted_node_names WHERE node_name = 'BiRefNet_Lite';
-- DELETE FROM preempted_node_names WHERE node_name = 'BilboXLut';
-- DELETE FROM preempted_node_names WHERE node_name = 'BilboXVignette';
-- DELETE FROM preempted_node_names WHERE node_name = 'BooleanFromPipe';
-- DELETE FROM preempted_node_names WHERE node_name = 'BooleanToPipe';
-- DELETE FROM preempted_node_names WHERE node_name = 'CLIPLoaderGGUF';
-- DELETE FROM preempted_node_names WHERE node_name = 'CLIPSlider';
-- DELETE FROM preempted_node_names WHERE node_name = 'CLIPTranslatedClass';
-- DELETE FROM preempted_node_names WHERE node_name = 'COND_ExtraOpts';
-- DELETE FROM preempted_node_names WHERE node_name = 'COND_ExtraOpts_2';
-- DELETE FROM preempted_node_names WHERE node_name = 'COND_SET_STRENGTH_ExtraOpts';
-- DELETE FROM preempted_node_names WHERE node_name = 'ChainTextEncode';
-- DELETE FROM preempted_node_names WHERE node_name = 'CkptPipe';
-- DELETE FROM preempted_node_names WHERE node_name = 'Combine Texts';
-- DELETE FROM preempted_node_names WHERE node_name = 'CryptoCatImage';
-- DELETE FROM preempted_node_names WHERE node_name = 'DecodeCryptoNode';
-- DELETE FROM preempted_node_names WHERE node_name = 'Describe Image';
-- DELETE FROM preempted_node_names WHERE node_name = 'DownloadImageClass';
-- DELETE FROM preempted_node_names WHERE node_name = 'DualCLIPLoaderGGUF';
-- DELETE FROM preempted_node_names WHERE node_name = 'EditableCLIPEncode';
-- DELETE FROM preempted_node_names WHERE node_name = 'EmptyLatentSize';
-- DELETE FROM preempted_node_names WHERE node_name = 'EmptyLatentSize64';
-- DELETE FROM preempted_node_names WHERE node_name = 'ExcuteCryptoNode';
-- DELETE FROM preempted_node_names WHERE node_name = 'ExpMath';
-- DELETE FROM preempted_node_names WHERE node_name = 'ExpMathDual';
-- DELETE FROM preempted_node_names WHERE node_name = 'ExpMathQuad';
-- DELETE FROM preempted_node_names WHERE node_name = 'FilterSchedule';
-- DELETE FROM preempted_node_names WHERE node_name = 'FixUTF8StringClass';
-- DELETE FROM preempted_node_names WHERE node_name = 'Focal Rescale';
-- DELETE FROM preempted_node_names WHERE node_name = 'Focal Rescale Rel';
-- DELETE FROM preempted_node_names WHERE node_name = 'Focalpoint from SEGS';
-- DELETE FROM preempted_node_names WHERE node_name = 'FooocusV2Expansion';
-- DELETE FROM preempted_node_names WHERE node_name = 'FormatFilenamePrefixByDate';
-- DELETE FROM preempted_node_names WHERE node_name = 'ImageRemoveBackground|LP';
-- DELETE FROM preempted_node_names WHERE node_name = 'ImageResizeClass';
-- DELETE FROM preempted_node_names WHERE node_name = 'Kokoro Audio Generator';
-- DELETE FROM preempted_node_names WHERE node_name = 'LamaRemover';
-- DELETE FROM preempted_node_names WHERE node_name = 'LamaRemoverIMG';
-- DELETE FROM preempted_node_names WHERE node_name = 'Latent Aspect';
-- DELETE FROM preempted_node_names WHERE node_name = 'LoRAScheduler';
-- DELETE FROM preempted_node_names WHERE node_name = 'Load Styles CSV';
-- DELETE FROM preempted_node_names WHERE node_name = 'LoadImageFromFolderClass';
-- DELETE FROM preempted_node_names WHERE node_name = 'LoadImageIncognito';
-- DELETE FROM preempted_node_names WHERE node_name = 'LoadUnetAndClip';
-- DELETE FROM preempted_node_names WHERE node_name = 'LoraInfo';
-- DELETE FROM preempted_node_names WHERE node_name = 'Mask to Crop';
-- DELETE FROM preempted_node_names WHERE node_name = 'MergeExtraOpts';
-- DELETE FROM preempted_node_names WHERE node_name = 'ModelPipe1';
-- DELETE FROM preempted_node_names WHERE node_name = 'ModelPipe2';
-- DELETE FROM preempted_node_names WHERE node_name = 'NoModel_CkptLoader';
-- DELETE FROM preempted_node_names WHERE node_name = 'NoNegExtraOpts';
-- DELETE FROM preempted_node_names WHERE node_name = 'Node_BOOL';
-- DELETE FROM preempted_node_names WHERE node_name = 'Node_Float';
-- DELETE FROM preempted_node_names WHERE node_name = 'Node_INT';
-- DELETE FROM preempted_node_names WHERE node_name = 'Node_RandomRange';
-- DELETE FROM preempted_node_names WHERE node_name = 'Node_String';
-- DELETE FROM preempted_node_names WHERE node_name = 'Node_StringMultiline';
-- DELETE FROM preempted_node_names WHERE node_name = 'OpenposeEditorNode';
-- DELETE FROM preempted_node_names WHERE node_name = 'PCApplySettings';
-- DELETE FROM preempted_node_names WHERE node_name = 'PCPromptFromSchedule';
-- DELETE FROM preempted_node_names WHERE node_name = 'PCScheduleAddMasks';
-- DELETE FROM preempted_node_names WHERE node_name = 'PCScheduleSettings';
-- DELETE FROM preempted_node_names WHERE node_name = 'PCSplitSampling';
-- DELETE FROM preempted_node_names WHERE node_name = 'PCWrapGuider';
-- DELETE FROM preempted_node_names WHERE node_name = 'PromptControlSimple';
-- DELETE FROM preempted_node_names WHERE node_name = 'PromptToSchedule';
-- DELETE FROM preempted_node_names WHERE node_name = 'RandomSeedNode';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorFaceBoost';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorFaceSwapOpt';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorImageDublicator';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorLoadFaceModel';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorMakeFaceModelBatch';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorMaskHelper';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorOptions';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorRestoreFace';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorSaveFaceModel';
-- DELETE FROM preempted_node_names WHERE node_name = 'ReActorUnload';
-- DELETE FROM preempted_node_names WHERE node_name = 'Rescale Maintain Aspect';
-- DELETE FROM preempted_node_names WHERE node_name = 'ResizeKeepRatio';
-- DELETE FROM preempted_node_names WHERE node_name = 'SEED_ExtraOpts';
-- DELETE FROM preempted_node_names WHERE node_name = 'SSL_GeminiAPIKeyConfig';
-- DELETE FROM preempted_node_names WHERE node_name = 'SSL_GeminiTextPrompt';
-- DELETE FROM preempted_node_names WHERE node_name = 'SamplerCustomAdvanced_Pipe';
-- DELETE FROM preempted_node_names WHERE node_name = 'SamplerSel';
-- DELETE FROM preempted_node_names WHERE node_name = 'SaveCryptoBridgeNode';
-- DELETE FROM preempted_node_names WHERE node_name = 'SaveCryptoNode';
-- DELETE FROM preempted_node_names WHERE node_name = 'SaveImageS3';
-- DELETE FROM preempted_node_names WHERE node_name = 'SaveImageToFolderClass';
-- DELETE FROM preempted_node_names WHERE node_name = 'SaveImagesToFolderClass';
-- DELETE FROM preempted_node_names WHERE node_name = 'SaveStringToFolderClass';
-- DELETE FROM preempted_node_names WHERE node_name = 'ScheduleToCond';
-- DELETE FROM preempted_node_names WHERE node_name = 'ScheduleToModel';
-- DELETE FROM preempted_node_names WHERE node_name = 'SchedulerSel';
-- DELETE FROM preempted_node_names WHERE node_name = 'SedOnString';
-- DELETE FROM preempted_node_names WHERE node_name = 'StableAnimatorDWPoseDetectorAlignedModels';
-- DELETE FROM preempted_node_names WHERE node_name = 'StableAnimatorLoadFramesFromFolderNode';
-- DELETE FROM preempted_node_names WHERE node_name = 'StableAnimatorModels';
-- DELETE FROM preempted_node_names WHERE node_name = 'StableAnimatorNode';
-- DELETE FROM preempted_node_names WHERE node_name = 'StableAnimatorSkeletonNode';
-- DELETE FROM preempted_node_names WHERE node_name = 'StringCombineClass';
-- DELETE FROM preempted_node_names WHERE node_name = 'StringFieldClass';
-- DELETE FROM preempted_node_names WHERE node_name = 'Transform Text';
-- DELETE FROM preempted_node_names WHERE node_name = 'TranslateStringClass';
-- DELETE FROM preempted_node_names WHERE node_name = 'TripleCLIPLoaderGGUF';
-- DELETE FROM preempted_node_names WHERE node_name = 'UnetClipLoraLoader';
-- DELETE FROM preempted_node_names WHERE node_name = 'UnetClipLoraLoaderBasic';
-- DELETE FROM preempted_node_names WHERE node_name = 'UnetLoaderGGUF';
-- DELETE FROM preempted_node_names WHERE node_name = 'UnetLoaderGGUFAdvanced';
-- DELETE FROM preempted_node_names WHERE node_name = 'VAE_ExtraOpts';
-- DELETE FROM preempted_node_names WHERE node_name = 'ViewExtraOpts';
-- DELETE FROM preempted_node_names WHERE node_name = 'batchsize_ExtraOpts';
-- DELETE FROM preempted_node_names WHERE node_name = 'get_lora_metadata';
-- DELETE FROM preempted_node_names WHERE node_name = 'opt Get cell value by item from GoogleSheets';
-- DELETE FROM preempted_node_names WHERE node_name = 'opt Get cell value from GoogleSheets';
-- DELETE FROM preempted_node_names WHERE node_name = 'opt Image Save';
-- DELETE FROM preempted_node_names WHERE node_name = 'opt PipeFromAny';
-- DELETE FROM preempted_node_names WHERE node_name = 'opt PipeToAny';
-- DELETE FROM preempted_node_names WHERE node_name = 'opt Save image to GoogleDrive';
-- DELETE FROM preempted_node_names WHERE node_name = 'opt Save text to GoogleSheets';
-- DELETE FROM preempted_node_names WHERE node_name = 'opt translate argos';
-- DELETE FROM preempted_node_names WHERE node_name = 'opt translate google';
-- DELETE FROM preempted_node_names WHERE node_name = 're_sub_str';
-- DELETE FROM preempted_node_names WHERE node_name = 'str_str';
-- DELETE FROM preempted_node_names WHERE node_name = 'str_str_str_str';
-- DELETE FROM preempted_node_names WHERE node_name = 'AudioConcatenate';
-- DELETE FROM preempted_node_names WHERE node_name = 'AudioInfo';
-- DELETE FROM preempted_node_names WHERE node_name = 'ColorPicker';
-- DELETE FROM preempted_node_names WHERE node_name = 'AudioCombine';
-- DELETE FROM preempted_node_names WHERE node_name = 'CV2InpaintTexture';
-- DELETE FROM preempted_node_names WHERE node_name = 'DownloadAndLoadHy3DDelightModel';
-- DELETE FROM preempted_node_names WHERE node_name = 'DownloadAndLoadHy3DPaintModel';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DApplyTexture';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DBakeFromMultiview';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DCameraConfig';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DDelightImage';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DDiffusersSchedulerConfig';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DExportMesh';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DGenerateMesh';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DGetMeshPBRTextures';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DIMRemesh';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DLoadMesh';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DMeshInfo';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DMeshUVWrap';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DMeshVerticeInpaintTexture';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DModelLoader';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DPostprocessMesh';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DRenderMultiView';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DRenderMultiViewDepth';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DRenderSingleView';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DSampleMultiView';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DSetMeshPBRAttributes';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DSetMeshPBRTextures';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DTorchCompileSettings';
-- DELETE FROM preempted_node_names WHERE node_name = 'Hy3DVAEDecode';
-- DELETE FROM preempted_node_names WHERE node_name = 'Blur';
-- DELETE FROM preempted_node_names WHERE node_name = 'Glow';
-- DELETE FROM preempted_node_names WHERE node_name = 'Pixelize';
-- DELETE FROM preempted_node_names WHERE node_name = 'Prompt Truncate';
-- DELETE FROM preempted_node_names WHERE node_name = 'Tidy Tags';
-- DELETE FROM preempted_node_names WHERE node_name = 'JanusProCaptionImageUnderDirectory|Mie';
-- DELETE FROM preempted_node_names WHERE node_name = 'JanusProDescribeImage|Mie';
-- DELETE FROM preempted_node_names WHERE node_name = 'JanusProModelLoader|Mie';
-- DELETE FROM preempted_node_names WHERE node_name = 'BlurFusionForegroundEstimation';
-- DELETE FROM preempted_node_names WHERE node_name = 'ColorCorrect';
-- DELETE FROM preempted_node_names WHERE node_name = 'Face Similarity';
-- DELETE FROM preempted_node_names WHERE node_name = 'ListMerge';
-- DELETE FROM preempted_node_names WHERE node_name = 'MergeImageChannels';
-- DELETE FROM preempted_node_names WHERE node_name = 'RoundNode';
-- DELETE FROM preempted_node_names WHERE node_name = 'SaveAudioTensor';
-- DELETE FROM preempted_node_names WHERE node_name = 'SaveImageWithMetaData';
-- DELETE FROM preempted_node_names WHERE node_name = 'SenseVoiceNode';
-- DELETE FROM preempted_node_names WHERE node_name = 'Sleep';
-- DELETE FROM preempted_node_names WHERE node_name = 'String';
-- DELETE FROM preempted_node_names WHERE node_name = 'TTPlanet_Tile_Preprocessor_Simple';
-- DELETE FROM preempted_node_names WHERE node_name = 'TextBox';
-- DELETE FROM preempted_node_names WHERE node_name = 'WeightedRandomChoice';
-- DELETE FROM preempted_node_names WHERE node_name = 'googletrans';

-- =============================================================================
-- SUMMARY
-- =============================================================================
-- Priority updates: 18 packages
-- Node claims: 191 nodes
-- Total operations: 209