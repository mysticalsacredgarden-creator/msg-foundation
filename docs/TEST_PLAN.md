# Test Plan — msg-foundation

## v1 Success Scenario (manual)
1. Open `/` in an incognito browser (no login)
2. **Verify:** Dashboard loads with 5 seeded work items; statuses and owner names visible
3. Click **Create Work Item**
4. Fill: Title="Update donor list", Owner=Sam Rivera, Due=Aug 22, Priority=High, Status=Open
5. Submit → **Verify:** new row appears at top of dashboard; no page reload required
6. Click edit on the new item → change Status to "In Progress" → save
7. **Verify:** status badge updates to blue "In Progress" in the list
8. Open item detail → **Verify:** activity feed shows "status changed: open → in_progress"
9. Click delete on the item → confirm dialog appears → confirm
10. **Verify:** item removed from dashboard; activity log row exists in Supabase

## Empty State
- Delete all work items → **Verify:** "No work items yet — create the first one" message shown

## Error Cases
- Submit Create form with blank title → **Verify:** inline validation error, no DB write
- Simulate network failure (DevTools offline) → **Verify:** error message shown, no crash
- Open item with invalid UUID in URL → **Verify:** 404 or "Item not found" message

## Filter Tests
- Filter by status=Done → **Verify:** only done items visible
- Filter by Owner=Jordan Lee → **Verify:** only Jordan's items visible
- Combined filter (Status=Open + Owner=Sam) → **Verify:** correct subset shown

## Overdue Flag
- Set due_date to yesterday, status=Open → **Verify:** red "Overdue" badge appears

## Data Persistence
- Create item, hard-refresh page → **Verify:** item still present (not seed-only)
