# Intelligence Layer — msg-foundation

## Messy Inputs
- Free-text work item titles and notes entered by team members
- Inconsistent category labelling across records
- Status fields that go stale because members forget to update them

## Auto-Structure Schema (example)
```json
{
  "work_item_id": "b100...",
  "inferred_category": "Finance",
  "inferred_category_confidence": 0.91,
  "suggested_status": "in_progress",
  "suggested_status_confidence": 0.78,
  "suggested_status_source": "gpt-4o",
  "suggested_status_review_status": "unreviewed"
}
```

## Events to Track
- Work item created (title, category, initial status)
- Status changed (from → to, time in each stage)
- Item overdue (due_date < today AND status != done)
- Owner reassigned

## Scoring Rules (rule-based first)
- **Overdue score:** days past due_date × priority weight (high=3, medium=2, low=1)
- **Stale score:** days since last activity with status = in_progress
- Dashboard sorts by overdue + stale score descending — no AI needed

## What Gets Ranked
- Work items sorted by urgency score on dashboard
- Overdue items surface at top with red badge

## v1 vs Later
- **v1:** Rule-based sorting and overdue flagging only
- **Later:** GPT-4o reads title+notes → suggests status + category; stored with confidence + review_status; member accepts or rejects in UI
