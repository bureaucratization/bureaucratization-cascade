# Redaction Audit—wg Forensic Record

**Auditor:** delegated security-audit worker
**Date:** 2026-09-16 (session)
**Scope:** `/home/bot/wg` (READ-ONLY—nothing modified)
**Purpose:** pre-release inventory of secrets and personal data ahead of publishing the "Bureaucratization Cascade" forensics paper and any accompanying `.wg/` dataset.

---

## Executive summary

| Severity | Findings | Detail |
|---|---|---|
| **CRITICAL** | **0** | No live credentials found on any scanned surface. |
| **HIGH** | 1 class (3 sites) | Founder personal email in agent/chat transcripts (25 occurrences, 4 files). Collaborator identifiers in 4 files. |
| **MEDIUM** | 1 item | Telegram chat ID in notification config (account identifier, not a secret). |
| **LOW** | 3 classes | Placeholder emails (`test.invalid` etc., dominant), service noreply addresses, "sk-" false positives inside base64 blobs. |

**Headline result: the transcript corpus is remarkably clean.** 242 pattern-matches for `sk-…`-style keys across chat and agent sessions reduced to **zero** standalone tokens under strict boundary analysis—all were substrings of base64 session blobs or word-slugs (`sk-orchestration-…` task names). This appears to be a direct dividend of the project's own `[secrets] allow_plaintext = false / default_backend = "keyring"` configuration: agents were never given plaintext keys to leak.

---

## Category tables

### A. Config and env files (fully scanned)

| File | Finding | Severity | Redacted preview |
|---|---|---|---|
| `.wg/config.toml` | `[secrets]` section is *settings only* (`allow_plaintext = false`, `default_backend = "keyring"`)—no secret material |—| n/a |
| `.wg/config.toml` + 2 `.bak` files | Operational config (executor thresholds, compaction, notification channels); no credentials | LOW | n/a |
| `env.sh` | Guix build environment bootstrap; no credentials |—| n/a |
| `env.frontier.sh` | OLCF Frontier HPC build script (module paths, libclang); no credentials |—| n/a |
| `backup_notify_config.toml` | `bot_token = "NEW_TO…LDER"`—**placeholder, not a live token** |—| n/a |
| `backup_notify_config.toml:15` | `chat_id = "107103998"`—Telegram account identifier | **MEDIUM** | `chat_id = "107…998"` |

### B. API keys / tokens—transcripts (`.wg/chat/`, `.wg/chat-history-*.jsonl`, `.wg/agents/`)

| Pattern class | Raw matches | After strict boundary re-scan | Verdict |
|---|---|---|---|
| `sk-…` generic | 242 occurrences, 39 distinct | **0** | All substrings of base64 blobs (`…TJfMsk-0Uj…` = fragment) or slug identifiers (`sk-activity-…`, `sk-policy-se…ning`) |
| `sk-ant-`, `sk-or-v1-` | 0 | 0 |—|
| `ghp_` / `gho_` / `github_pat_` | 1 (`gho_`) | **0** | Base64 fragment |
| `xox[bp]-` (Slack), `AKIA…` (AWS) | 0 | 0 |—|
| JWT (`eyJ….`) | 0 standalone | 0 |—|
| `api_key =` / `OPENROUTER_API_KEY=` assignments | ~15 (docs/, tests/) | all placeholders (`sk-or-v1-…`, `sk-plaintext`, `app-password`, smoke-test dummies) | Documentation examples only |

### C. Personal data

| Item | Location | Count | Severity | Note |
|---|---|---|---|---|
| `erik.garrison@gmail.com` | `.wg/chat/…chat-0.jsonl`, `.wg/chat/…chat-2.jsonl`, `.wg/agents/agent-22/*` (4 files) | 25 | **HIGH** | Founder's own address; appears in chat/session transcripts. Redact before any dataset release. |
| `github.com/lucapinello/...` URLs | chat-2 session, agent-22 raw_stream | few | LOW | Public GitHub handle of co-founder; already public. |
| Collaborator name mentions ("Pinello"/"Vaughn") | 4 files |—| LOW | Context reviewed: GitHub URLs and org references. Recommend manual eyeball of `agents/agent-22/raw_stream.jsonl` before release. |
| Phone numbers |—| 0 |—| None found. |

### D. Email census (distinct addresses: 24)

| Class | Examples | Notes |
|---|---|---|
| Synthetic test addresses (dominant) | `trust-worker@test.invalid`, `worker-cap@test.invalid`, `canary@test.invalid`, `smoke@example.invalid` … | ~85% of occurrences; safe |
| Service noreply | `git@github.com`, `tgit@github.com`, `user_feedback@z.ai` | z.ai entry is a vendor service address; harmless |
| **Real personal** | `erik.garrison@gmail.com` | 25 occurrences; see §C |

### E. IP addresses (distinct: 3)

| IP | Count | Class |
|---|---|---|
| `127.0.0.1` | 87 | localhost—safe |
| `0.0.0.0` | 2 | bind-any—safe |
| `200.400.600.80` | 1 | syntactically invalid—safe |

No private-range (10/172.16–31/192.168) or routable third-party IPs found. No Azure/OpenAI-range analytical IPs in transcripts.

---

## Recommended release policy

**Publishable as-is (after standard per-file spot-check):**
- `docs/`, `src/`, root `*.md` reports and design docs—contain only placeholder credentials.
- `.wg/agency/` assignment receipts, `graph.jsonl`, `stats.json`, `model_benchmarks.json`—schema data, no PII observed (receipt digests are hashes).

**Redact before release (mechanical, low-effort):**
- `.wg/chat/*` and `.wg/agents/*/pi-sessions/*`—strip/replace `erik.garrison@gmail.com` (25 sites). This is the single mandatory redaction.
- `backup_notify_config.toml`—drop `chat_id` line.

**Keep private (do not publish):**
- `.wg/config.toml` and both `.bak` files—operational config with notification topology; no public value.
- `.wg/agents/*/raw_stream.jsonl` and `attempts/` bulk dumps—**sample-scanned only** (276M agents / 1.1G attempts; greps covered patterns but not full-content review). Hold back until a full-content pass, or publish only the structured artifacts.

**Additional recommendation:** the repo ships `.gitguardian.yml`—run a full `gitleaks`/trufflehog sweep over **`git` history** (out of this audit's scope; `.git` excluded) before publishing the repo or any bundled history. All patterns above were filesystem scans; git history can retain secrets that were later deleted from working trees.

## Caveats

- 14G tree prioritized per brief: configs/env fully read; chat and `agents/` pattern-scanned (not full-content human review); `attempts/`, `completion/`, `build-tmp/` sampled. A CRITICAL=0 verdict applies to the scanned surface and patterns listed; it is not an exhaustive guarantee over all 14G.
- High-entropy base64 blobs in session logs will defeat naive keyword scanners in both directions (false positives for keys, possible false negatives for non-`sk-` prefixed secrets encoded in blobs). The boundary-scan method used here is the right baseline; a decode-and-rescan pass over base64 payloads would raise confidence to near-certain for the publish set.
