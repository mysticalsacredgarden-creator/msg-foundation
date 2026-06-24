# Security — msg-foundation

## Secret Handling
- Supabase service role key: server-side only (Next.js server actions / API routes), never in client bundle
- Supabase anon key: client-safe, used only for select queries under RLS
- All env vars in Vercel environment settings; never committed to repo

## Permission Model
- **v1 (demo):** Open RLS policies — all tables readable and writable without login; safe because no real data yet
- **Lock-down sprint:** Replace with `auth.uid() = user_id`; admins can read/write all items in their team; members can write only their own records
- Role hierarchy: `admin` > `member`; role stored in `team_members.role`

## Approved-Tools Rule
- Agent may only call explicitly named tools (`summarise_work_item`, `suggest_status`, `draft_weekly_summary`)
- No `run_any`, `eval`, or raw SQL execution via agent
- Every tool call inherits the calling user's RLS context — agent cannot exceed user's own permissions

## Audit Principle
- Every create, update, delete, and agent action writes a row to `audit_logs` with actor, target, payload, and timestamp
- Audit logs are append-only; no update or delete policy on `audit_logs` even for admins
- Admin UI can read audit logs; no UI to delete them
