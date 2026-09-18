# Dataset Manifest—The Bureaucratization Cascade

**Release version:** 1.0 · September 16, 2026
**License:** CC-BY-4.0 (data and reports); the paper itself is separate.
**Citation:** *Bureaucratization Cascades in Hybrid Human–AI Organizations: A computational ethnography of recursive constraint accretion* (Poietic PBC working paper).

## What this dataset is

Structured, **content-free** lifecycle traces of tasks executed by AI agents across seven wg deployments, February–September 2026, plus the governance-layer evidence and security-audit reports backing the paper's claims. It exists so that every quantitative claim in the paper can be recomputed from released data.

## What is deliberately NOT here

- **Prompts and transcripts.** No agent prompts, no session transcripts, no chat logs.
- **Task titles and descriptions.** Dropped from all lifecycle CSVs; task IDs are hashed (SHA-1 prefix, `t_…`), except the handful cited verbatim in the published paper, which retain their IDs for cross-reference.
- **The `jobs` deployment.** Excluded entirely (all data), as it is a personal document project.
- **Grant content.** The grant-A/grant-B deployments concern unpublished grant applications; they are anonymized throughout (filenames and prose). Their science is present only as aggregate counts. The code-to-name concordance is held privately by the operator.

Excluding prompt and transcript content costs the paper nothing: every claim is derived from counts, timestamps, statuses, and dispatch data.

## Contents

### `lifecycles/`—sanitized per-task traces (7 deployments)

| File | Org | Rows | Columns |
|---|---|---|---|
| `current-tasks.csv` | wg primary (post-reset, Aug 8–Sep 16) | 115 | task_id, classification, created_month, final_status, completion_month, event_count, admission_deferred_count |
| `pre-aug9-tasks.csv` | wg primary (Aug 8–9 snapshot) | 28 | task_id, classification, status, created_at, completed_at, n_events, gate_eval_mentions |
| `primary-july-tasks.csv` | wg primary (July quarantine archive) | 253 | task_id, classification, status, family, created_at, completed_at, latency_days, dispatch_count |
| `grant-a-tasks.csv` | Grant campaign A (May 19–Jun 5) | 848 | task_id, classification, status, created_month, completed_month |
| `grant-b-tasks.csv` | Grant campaign B (Feb/May eras) | 385 | era, task_id, classification, status, created_at, completed_at, latency_min, dispatch_or_retry |
| `*-monthly.csv` | monthly aggregates |—| content-free |

**Classification rule** (derived `classification` column): `experiment` = verify-timeout/CLI-test/probe/smoke/repro family; `governance` = title (not included) began with `evaluate/flip/assign agent/quality-pass/verify/admin/checkpoint/admission` or carried an `agency` tag; all else `work`. **Known deviation:** this conservative prefix rule reproduces the paper's grant campaign A governance share within ~2 points (76% vs 78%) but yields ~half the paper's per-era grant campaign B shares (0%, 6%, 13% vs 0%, 12%, 24%), which additionally counted verification-type work tasks as governance. Both classifications show the same linear (non-accelerating) pattern. The rule is stated so results are recomputable either way.

### `governance/`—evidence for the paper's claims

- `gate-census.csv`, `accretion-curve.csv`—the constraint census (312 topics) and monthly add/remove curve
- `model-mix-by-month.csv`, `cost-estimate.csv`—metered model attribution (Aug 8–Sep 16 window)
- `fact-check.md`—verification of every commit hash, quote, and number in the paper (24 PASS / 0 FAIL)
- `redaction-audit.md`, `git-history-secrets.md`, `base64-rescan.md`—the three security audit legs: working tree, full git history (gitleaks, all branches), and decode-and-rescan of 14,818 base64 payloads with positive controls. **All clean: zero live credentials.**

## Provenance

Extracted from the coordination state directories of the deployments (task archives, lifecycle ledgers, completion transactions) by scripted analysis; timestamps decoded from UUIDv7 event-ID prefixes where explicit fields were absent (validated 116/116 against explicit timestamps). Task-level records for the primary org's January–July period were destroyed by an August 8 state reset that predates all surviving backups—see the paper §4.5.

## Privacy posture

No credentials (audited on three surfaces). No prompts or transcripts. No task text. Hashed task IDs. Personal-identifier exclusions per the redaction audit. This manifest is the release's authoritative scope document.
