# Agentic Layer — msg-foundation

## Risk Levels & Actions

### Low — Auto (no approval needed)
- Summarise work item notes into a one-line description
- Auto-tag category from title/notes
- Score and rank items by urgency

### Medium — Light approval (member confirms)
- Suggest status change based on notes content
- Draft a weekly team summary email from open items
- Auto-assign owner based on category history

### High — Always approval (explicit click required)
- Send notification to a team member about an overdue item
- Bulk-reassign items when a member leaves

### Critical — Human-only (no agent execution)
- Delete a work item or batch of items
- Export or purge audit logs

## Named Tools (approved only)
- `summarise_work_item(item_id)` → returns summary string, stored as note draft
- `suggest_status(item_id)` → returns suggested status + confidence, stored in AI fields
- `draft_weekly_summary(team_id)` → returns markdown email draft for admin review

## Audit Log Fields
Every agent action writes: `actor_id`, `tool_name`, `target_id`, `input_payload`, `output_payload`, `approved_by`, `created_at`

## v1 vs Later
- **v1:** No agentic actions; all fields nullable; core runs without them
- **Next:** `suggest_status` + `summarise_work_item` with member review UI
- **Later:** `draft_weekly_summary` with admin approval flow
