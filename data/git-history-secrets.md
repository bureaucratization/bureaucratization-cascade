# Git History Secrets Sweep — /home/bot/wg

*Auditor: security-audit worker (pi subagent), 2026-09-16. Complements `redaction-audit.md` (working tree + .wg state); this report covers the git object database itself.*

## (a) Tool and coverage

- **Tool:** gitleaks 8.24.3 (downloaded to /tmp; not installed system-wide), run with `--redact` (no full secret values persisted outside the tool's internal scan).
- **Command:** `gitleaks detect --source . --report-path ~/wg-forensics/gitleaks-report.json --report-format json --no-banner --redact`
- **Coverage:** **3,378 commits, ~113 MB scanned, all refs** — the 3,194 commits on `main` plus the agent working branches (`wg/agent-N/...`, `rescue/simple-local-wg`; ~30+ branches present). Raw report: `/home/bot/wg-forensics/gitleaks-report.json`.
- Note: gitleaks does **not** read the repo's `.gitguardian.yml` (that is GitGuardian's format), so this scan is *stricter* than the project's own declared policy — see (d).

## (b) Findings — 7 hits, 0 real credentials

| # | Rule | Date | File @ commit | Matched value (redacted) | Verdict |
|---|---|---|---|---|---|
| 0 | generic-api-key | 2026-04-03 | `tests/smoke_openrouter_routing.rs` @ `9cf8cb7` | `sk-tes…ting`, `sk-or-…2345` | **PLACEHOLDER** — self-described test fixtures (`sk-test-key-for-routing`, `sk-or-test-env-key-12345`) in smoke tests explicitly gated on `OPENROUTER_API_KEY` env var for live use |
| 1 | generic-api-key | 2026-03-18 | `docs/design/model-endpoint-key-ux.md` @ `1ba549a` | (doc table text) | **PLACEHOLDER** — design-document CLI flag documentation, no values |
| 2,3 | slack-app-token | 2026-03-04 | `src/notify/slack.rs` @ `12e18f7` | `xoxb-…`(doc), `xoxb-…456-abc` | **PLACEHOLDER** — doc-comment example (`xoxb-...`) and unit-test fixtures (`xoxb-test-token`, `xoxb-123-456-abc`, `xoxb-test`); obviously synthetic sequences |
| 4 | discord-client-id | 2026-03-04 | `src/notify/discord.rs` @ `bfa8f17` | `123456…5678` | **NOT-A-SECRET** — Discord *client/channel IDs are public identifiers* by design (snowflakes); doc-comment examples `123456789012345678` / `987654321098765432`. Not credentials; no auth material. |
| 5,6 | generic-api-key | 2026-03-04 | `src/notify/push.rs` @ `24e5167` | `test-k…b64url` | **PLACEHOLDER** — VAPID key doc-comment example and fixture `vapid_private_key = "test-key-base64url"` |

Severity rollup: **CRITICAL 0 · HIGH 0 · placeholder/not-secret 7.**

## (c) Publish-safety verdict

**Full git history is safe to publish as-is.** No history rewrite, no commit exclusion, no branch pruning required for secret-safety reasons. Every hit is a documentation example, a test fixture with a self-evidently synthetic value, or a public identifier. The working-tree/.wg redaction audit's conclusions stand unchanged for the git layer.

Two non-secret observations for the release decision (not blockers):
1. **History is 113 MB / 3,378 commits** including agent working branches with merge noise; if the public dataset ships history, consider shipping `main` plus tagged release points rather than all ~30 agent branches (for hygiene/readability, not secrets).
2. The `.wg/` directory is *inside* the repo tree but its bulk is untracked/ignored — this sweep covered only git-tracked content, which is the correct boundary; `.wg/` release decisions remain governed by `redaction-audit.md`.

## (d) Comparison with `.gitguardian.yml`

The project's own policy (present at repo root) declares:

- **Ignored paths:** `.workgraph/`, `target/`, `*.pdf`, `test-workgraph/`, `.git/`, `screencast/`, `scripts/`, and `security-remediation-design.md`
- **Ignored matches:** `test_api_key_[a-zA-Z0-9]+`, `test@example\.com`

Gaps and notes:

1. **`security-remediation-design.md` is excluded from the project's own secret scanning.** An organization-wide convention of excluding a *security remediation* document from secret detection is an anti-pattern worth flagging to Poietic: exclusions should be justified per-file with a reason field. Our scan covered it anyway (gitleaks ignores `.gitguardian.yml`) and found nothing there — but the exclusion itself should be revisited or documented.
2. **`scripts/` excluded wholesale** — script directories are a common real-secret location (deployment helpers, curl one-liners). Our scan covered `scripts/` (no hits), but the standing policy should prefer narrow, justified exclusions.
3. **`test-workgraph/` and `screencast/` exclusions** are reasonable for noise reduction and were low-risk here; `.workgraph/` and `target/` are build/scratch dirs, standard.
4. The two `ignored_matches` patterns are correctly scoped to obvious test fixtures and would not have suppressed any of today's seven findings.

**Bottom line:** 0 real credentials in 3,378 commits across all branches. Git history: publishable. The only redaction work remaining for dataset release remains what `redaction-audit.md` identified (personal-contact identifiers in session transcripts).
