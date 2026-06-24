# Tasks & Sprints — msg-foundation

## Sprint 1 — DB Schema & Seed Data
**Goal:** Live database ready with realistic demo data.
- [ ] Write and apply `migration_sql` to Supabase project
- [ ] Verify all tables exist: `team_members`, `work_items`, `activities`, `audit_logs`
- [ ] Confirm 3 demo members and 5 demo work items are visible via Supabase table editor
- [ ] Confirm all RLS v1 open policies are active

**Definition of Done:** Supabase table editor shows seeded rows; no migration errors.

---

## Sprint 2 — Core Work-Item Engine ✅ v1 functional
**Goal:** Dashboard live; full CRUD works end-to-end; no login required.
- [ ] `/` page: table/card list of all work items (title, status badge, owner, due date, priority)
- [ ] Empty state: "No work items yet — create the first one"
- [ ] Loading and error states on data fetch
- [ ] Create Work Item modal/form → server action → insert to DB → list refreshes
- [ ] Edit Work Item form → server action → update in DB → list refreshes
- [ ] Delete with confirmation dialog → server action → row removed → list refreshes
- [ ] Status badge colour: Open=grey, In Progress=blue, Done=green
- [ ] Overdue items (due_date < today, status ≠ done) shown with red badge
- [ ] Activity row written on create, edit, delete
- [ ] Anonymous visitor sees real data (no redirect to /login)

**Definition of Done:** Create → Edit → Delete cycle works live against Supabase; seed rows also editable; no dead buttons.

---

## Sprint 3 — Team Members & Activity Feed
**Goal:** Team visibility and change history.
- [ ] `/team` page: list all team members with name, role, open item count
- [ ] Owner dropdown in work item form pulls from `team_members` table
- [ ] Filter bar on dashboard: by status, by owner
- [ ] Activity feed panel on work item detail: shows timestamped history of changes
- [ ] Audit log row written on every mutation

**Definition of Done:** Filter works live; activity feed shows real DB rows; owner assignment persists.

---

## Sprint 4 — Lock It Down (Auth & Per-User RLS)
**Goal:** Real users, real security.
- [ ] Supabase Auth: email/password signup and login pages
- [ ] Replace v1 open RLS policies with `auth.uid() = user_id` owner-scoped policies
- [ ] Admin role: can read/write all team items; member: own items only
- [ ] Invite flow: admin invites new member by email
- [ ] Redirect unauthenticated visitors to /login after lock-down

**Definition of Done:** Two test accounts with different roles see correct data; no cross-user data leakage.

---

## Sprint 5 — Intelligence & Polish
**Goal:** Smart suggestions and summary reporting.
- [ ] `suggest_status` tool: reads title+notes, writes `status_suggestion` + confidence + review_status
- [ ] Work item form shows AI suggestion with Accept / Reject buttons
- [ ] Dashboard summary cards: total open, overdue count, done this week
- [ ] Auto-tag `category` from title on create (rule-based keyword match first)
- [ ] Audit log viewer page for admins

**Definition of Done:** AI suggestion stored with all four AI fields; accept/reject updates review_status in DB; summary cards pull live counts.

---

## Gantt (sprint → feature)
```
Sprint 1  |--DB + Seed--|
Sprint 2              |--CRUD Engine + Dashboard--| ← v1 functional
Sprint 3                                    |--Team + Filters + Activity--|
Sprint 4                                                    |--Auth + RLS Lock-down--|
Sprint 5                                                                    |--AI + Reporting--|
```
