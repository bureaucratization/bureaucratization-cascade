# Base64 decode-and-rescan—wg forensic record

**Date: 2026-09-16 · Status: COMPLETE · Verdict: CLEAN**

Closes the encoded-payload gap of the prior pattern scans (working-tree scan and full git-history sweep both found zero live credentials, but neither can see base64-ENCODED secrets). This pass found, decoded, and pattern-scanned every long base64 run in the coordination record.

## Verdict

**Decoding does NOT change the prior "no live credentials" conclusion.** Zero secret-pattern hits in any decoded payload, at either scan threshold.

## Counts

| Pass | Threshold | Files | Candidates | Unique (deduped) | Readable decodes | Hits |
|---|---|---|---|---|---|---|
| 1 | ≥200 chars | 262 (1.33 GB) | 9,960 |—| 0 | 0 |
| 2 | ≥80 chars | 262 (1.33 GB) | 14,818 |—| 0 | 0 |

Errors: 0. Skipped files: 0 (no file exceeded the 1.5 GB guard).

## What the base64 runs actually are

Diagnostics on sampled candidates (both ranges) show every long base64 run decodes to **binary stream frames**—payloads beginning with binary headers (`\x80\x00\x00…`) at 20–43% printable content—consistent with streaming event/audio frames, not encoded text. The decode-ratio histogram for the 80–200 range: 145 samples at ratios 0.0–0.43, none readable. **No candidate in the entire record decodes to human-readable text**, which is why there are zero hits: there is no encoded-text layer in this record at all.

## Detector self-test (why this clean is trustworthy)

A zero can mean "nothing to find" or "broken tool." The pipeline was validated both ways:

- Synthetic secret (`sk-ant-api03-…`, 113-char JSON payload) in **standard base64**: found by the regex, decoded at 1.0 readability, pattern-matched ✓
- Same secret in **base64url**: found, decoded, matched ✓
- Real-file candidates: decode to binary at 0.39–0.43 readability—correctly filtered ✓
- Threshold gap caught and closed: pass 1 used a 200-char floor that would miss a realistic ~100-char encoded API key; pass 2 re-ran at an 80-char floor (+4,858 candidates examined, still zero readable, zero hits)

## Coverage

- Scanned: `chat/` (25 session files, 19 MB), `chat-history-*.jsonl` (3), `agents/**/*.jsonl` (91 pi-session + 27 raw_stream files, 40 MB + frames), `attempts/**/*.jsonl` (143 files, 912 MB)—**1.33 GB total, 262 files**
- Pattern classes searched in decoded text: OpenRouter/Anthropic/generic `sk-` keys, GitHub tokens (ghp_/gho_/PAT), Slack, AWS AKIA, Google AIza, long Bearer tokens, api_key/secret/password-adjacent values, emails, JWTs
- Excluded: `.git`, `build-tmp`; no size-based skips were triggered

## Findings table

None. No secret-pattern content exists in any decoded payload. (Previews section intentionally empty—there is nothing to preview, and nothing was written in full.)

## Implication for dataset release (paper §6)

All three audit legs are now complete and clean: working tree ✓, git history ✓, encoded payloads ✓. The remaining publication constraints from the redaction audit (personal-contact identifiers; private retention of config snapshots, raw stream dumps, and `.wg-worktrees/`) still apply, but no credential blocker exists.
