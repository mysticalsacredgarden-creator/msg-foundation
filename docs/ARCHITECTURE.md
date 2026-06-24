# Architecture — msg-foundation

## Stack
- **Frontend:** Next.js (App Router) on Vercel
- **Database & Auth:** Supabase (Postgres + RLS + Auth)
- **Styling:** Tailwind CSS

## Build Sequence
**Now:** DB schema → work item CRUD → shared dashboard → demo seed data viewable without login
**Next:** Auth + per-user RLS, activity feed, filters, assignment
**Later:** AI status suggestions, reporting cards, Slack integration

## Key User Action — Flow
1. **Capture:** Team member fills Create Work Item form (title, owner, due date, priority)
2. **Store:** Form submits to Supabase `work_items` table via server action
3. **Log:** Activity row inserted (`action: created`, actor, timestamp)
4. **Show:** Dashboard re-fetches and renders updated list in real time
5. **Edit:** Member updates status → DB write → activity row → UI re-renders badge

## Layer Plan
1. **Data first:** All tables, fields, and RLS policies defined and migrated before any UI
2. **App logic second:** CRUD server actions, status transitions enforced in code, activity logging on every mutation
3. **Smart features on top:** AI status suggestions and auto-tagging added after core is stable — core runs fully without them

## Why Core Runs Without AI
All status transitions, assignments, and logging are plain Postgres writes. AI fields (`status_suggestion`) are nullable; removing them doesn't break any form or view.
