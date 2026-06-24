create table if not exists team_members (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  email text not null,
  role text not null default 'member',
  created_at timestamptz not null default now()
);

alter table team_members enable row level security;
drop policy if exists "team_members_v1_read" on team_members;
create policy "team_members_v1_read" on team_members for select using (true);
drop policy if exists "team_members_v1_write" on team_members;
create policy "team_members_v1_write" on team_members for all using (true) with check (true);

create table if not exists work_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  title text not null,
  description text,
  status text not null default 'open',
  owner_id uuid references team_members(id),
  due_date date,
  priority text not null default 'medium',
  category text,
  notes text,
  status_suggestion text,
  status_suggestion_source text,
  status_suggestion_confidence numeric,
  status_suggestion_review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);

alter table work_items enable row level security;
drop policy if exists "work_items_v1_read" on work_items;
create policy "work_items_v1_read" on work_items for select using (true);
drop policy if exists "work_items_v1_write" on work_items;
create policy "work_items_v1_write" on work_items for all using (true) with check (true);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  work_item_id uuid references work_items(id),
  actor_id uuid references team_members(id),
  action text not null,
  field_changed text,
  old_value text,
  new_value text,
  created_at timestamptz not null default now()
);

alter table activities enable row level security;
drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);
drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  actor_id uuid references team_members(id),
  target_table text not null,
  target_id uuid,
  action text not null,
  payload jsonb,
  created_at timestamptz not null default now()
);

alter table audit_logs enable row level security;
drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into team_members (id, name, email, role) values
  ('a1000000-0000-0000-0000-000000000001', 'Jordan Lee', 'jordan@msg-foundation.internal', 'admin'),
  ('a1000000-0000-0000-0000-000000000002', 'Sam Rivera', 'sam@msg-foundation.internal', 'member'),
  ('a1000000-0000-0000-0000-000000000003', 'Alex Chen', 'alex@msg-foundation.internal', 'member')
on conflict (id) do nothing;

insert into work_items (id, title, description, status, owner_id, due_date, priority, category, notes) values
  ('b1000000-0000-0000-0000-000000000001', 'Q3 Budget Reconciliation', 'Reconcile all departmental spend against Q3 budget lines.', 'in_progress', 'a1000000-0000-0000-0000-000000000001', '2025-08-15', 'high', 'Finance', 'Awaiting final figures from procurement.'),
  ('b1000000-0000-0000-0000-000000000002', 'Onboard New Volunteer Cohort', 'Complete intake forms and orientation for 12 new volunteers.', 'open', 'a1000000-0000-0000-0000-000000000002', '2025-08-20', 'high', 'HR', 'Orientation scheduled for Aug 18.'),
  ('b1000000-0000-0000-0000-000000000003', 'Update Grant Reporting Template', 'Revise the standard grant report template per new funder requirements.', 'open', 'a1000000-0000-0000-0000-000000000003', '2025-08-10', 'medium', 'Compliance', null),
  ('b1000000-0000-0000-0000-000000000004', 'Community Outreach Event Logistics', 'Coordinate venue, catering, and communications for September event.', 'in_progress', 'a1000000-0000-0000-0000-000000000002', '2025-09-05', 'medium', 'Programs', 'Venue confirmed. Catering TBD.'),
  ('b1000000-0000-0000-0000-000000000005', 'IT Asset Inventory Audit', 'Complete annual audit of all department hardware and software licenses.', 'done', 'a1000000-0000-0000-0000-000000000001', '2025-07-31', 'low', 'Operations', 'Completed and filed.')
on conflict (id) do nothing;

insert into activities (work_item_id, actor_id, action, field_changed, old_value, new_value) values
  ('b1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'status_change', 'status', 'open', 'in_progress'),
  ('b1000000-0000-0000-0000-000000000005', 'a1000000-0000-0000-0000-000000000001', 'status_change', 'status', 'in_progress', 'done'),
  ('b1000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000002', 'note_added', 'notes', null, 'Venue confirmed. Catering TBD.')
on conflict do nothing;