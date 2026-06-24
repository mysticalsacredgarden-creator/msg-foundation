# Data Model — msg-foundation

## team_members
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | links to auth.users at lock-down |
| name | text | |
| email | text | |
| role | text | 'admin' or 'member' |
| created_at | timestamptz | |

## work_items
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | creator; owner-scoped at lock-down |
| title | text | |
| description | text | |
| status | text | open / in_progress / done |
| owner_id | uuid FK → team_members | |
| due_date | date | |
| priority | text | low / medium / high |
| category | text | |
| notes | text | |
| status_suggestion | text | **AI field** |
| status_suggestion_source | text | e.g. 'gpt-4o' |
| status_suggestion_confidence | numeric | 0.0–1.0 |
| status_suggestion_review_status | text | unreviewed / accepted / rejected |
| created_at | timestamptz | |

## activities
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| work_item_id | uuid FK → work_items | |
| actor_id | uuid FK → team_members | |
| action | text | created / status_change / reassigned / note_added / deleted |
| field_changed | text | nullable |
| old_value | text | nullable |
| new_value | text | nullable |
| created_at | timestamptz | |

## audit_logs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| actor_id | uuid FK → team_members | |
| target_table | text | |
| target_id | uuid | |
| action | text | |
| payload | jsonb | full before/after snapshot |
| created_at | timestamptz | |

## RLS Notes
- v1: all tables open (select + all) for demo
- Lock-down sprint: replace with `auth.uid() = user_id` owner policies; admin role can read all rows in their team
