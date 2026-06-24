# PRD — msg-foundation

## Problem
The team manages recurring operational work across spreadsheets and chat. Records get lost, statuses go stale, and no one has a single up-to-date view of what's open, who owns it, or what changed.

## Target User
Internal department team members (3–15 people) doing daily operational work: logging tasks, updating statuses, checking what their teammates are working on.

## Core Objects
- **Work Item** — the unit of work: title, description, status, owner, due date, priority, category, notes
- **Team Member** — person in the department: name, email, role (admin / member)
- **Activity** — timestamped log of every status change, reassignment, or note added
- **Audit Log** — immutable record of every create/edit/delete action

## MVP Must-Haves
- [ ] Dashboard lists all work items with status, owner, and due date
- [ ] Any team member can create a new work item
- [ ] Any team member can edit a work item (status, owner, notes)
- [ ] Delete a work item with confirmation
- [ ] Status moves through: Open → In Progress → Done
- [ ] Activity row written on every change
- [ ] Page loads with demo data for anonymous visitors (no login wall)

## Non-Goals (v1)
- User authentication and login
- Per-user data isolation
- Notifications or integrations
- Reporting or analytics
- AI features

## Success Criteria
Sam opens the app, sees Jordan's in-progress budget reconciliation, creates a new work item "Update donor list" assigned to herself with due date Aug 22, sets it to In Progress, and the dashboard immediately reflects the new record — without touching a spreadsheet.
