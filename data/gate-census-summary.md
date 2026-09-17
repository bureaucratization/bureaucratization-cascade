# Gate Census Summary (Figure 2)

Generated 2026-09-16 from /home/bot/wg git history + .wg config snapshots. READ-ONLY analysis.

## Headline numbers
- Total distinct constraint topics identified: **312** (high-confidence suffix clustering: 164; medium key-phrase: 148)
- Surviving at census date: **311**; removed/retired: **1** (incl. 1 config-layer constraint-set removal, 2026-09-13)
- Ratchet ratio (added:removed over Jan-Sep): **312:1**
- Scope of governance commits: src-touching clusters 95, docs-only clusters 59, unchecked 158
- Governance commits: 344 of 3200 total (10.8%)
- Removal-verb governance commits: 14

## Accretion curve
| month | added | removed | cumulative |
|---|---|---|---|
| 2026-01 | 0 | 0 | 0 |
| 2026-02 | 7 | 1 | 6 |
| 2026-03 | 66 | 2 | 70 |
| 2026-04 | 95 | 5 | 160 |
| 2026-05 | 5 | 0 | 165 |
| 2026-06 | 4 | 0 | 169 |
| 2026-07 | 43 | 1 | 211 |
| 2026-08 | 46 | 4 | 253 |
| 2026-09 | 45 | 2 | 296 |

## Top 5 longest-lived constraints
- merge-branch-main-agent: 2026-07-31 -> 2026-09-09 (2 commits, src)
- config:agency-auto-evaluation: 2026-08-08 -> 2026-09-13 (0 commits, config)
- provider-backoff-contract: 2026-08-16 -> 2026-09-09 (5 commits, docs)
- integrate-and-verify: 2026-03-11 -> 2026-03-27 (2 commits, unchecked)
- investigate-and-fix-2: 2026-03-19 -> 2026-03-30 (2 commits, unchecked)

## Top 5 most-hardened constraints (by commit count)
- audit-cycle-cleanup-round: 5 commits (2026-02-15 -> 2026-02-15, unchecked)
- merge-candidate-wgcid-blake3: 5 commits (2026-07-28 -> 2026-07-31, unchecked)
- provider-backoff-contract: 5 commits (2026-08-16 -> 2026-09-09, docs)
- make-verify-a: 3 commits (2026-03-04 -> 2026-03-04, unchecked)
- push-and-verify-ci: 3 commits (2026-03-13 -> 2026-03-13, unchecked)

## Notable removal events
- **2026-09-13 configuration disable**: `.wg/config.toml.bak-2026-09-13T02-32-08Z` vs live config—`auto_evaluate` true->false; `verify_autospawn_enabled = false` (verify gates no longer spawn agents autonomously); [agency] block retuned. Gates were not deleted; they were switched from autonomous to manual—consistent with the paper's 'subtraction at the configuration layer' (draft §3.5), refined: **the recovery disabled gate *enforcement autonomy*, not gate existence.**
- Removal-verb governance commits cluster in June (autopoietic-loop recovery) and September.

## Trigger-incident linkage (birth within ±5 days, inferred)
- remove-hard-evasion (2026-04-06) near 2026-04-11 April triage
- .verify-fix-hardcoded-models-service (2026-04-06) near 2026-04-11 April triage
- .verify-write-introduction-and-background-for-after-depend (2026-04-09) near 2026-04-11 April triage
- .verify-create-actual-after-dependency-enforcement-design--3 (2026-04-09) near 2026-04-11 April triage
- .verify-create-after-dependency-enforcement-design-md-file-3 (2026-04-09) near 2026-04-11 April triage
- .verify-write-bare-coordinator-design-doc-4 (2026-04-09) near 2026-04-11 April triage
- investigate-coordinator-daemon (2026-04-09) near 2026-04-11 April triage
- coordinator-uses-bounded-context (2026-04-09) near 2026-04-11 April triage
- smoke-verify-gate (2026-04-09) near 2026-04-11 April triage
- isolate-state-injection-tests (2026-04-09) near 2026-04-11 April triage
- inject-verify-gate-task (2026-04-09) near 2026-04-11 April triage
- investigate-coordinator-spawning (2026-04-10) near 2026-04-11 April triage
- bounds-check-offset-file (2026-04-10) near 2026-04-11 April triage
- remove-unused-imports-blocking (2026-04-11) near 2026-04-11 April triage
- implement-verify-lint (2026-04-11) near 2026-04-11 April triage
- .verify-bypass-verification-for (2026-04-11) near 2026-04-11 April triage
- implement-openrouter-cost (2026-04-11) near 2026-04-11 April triage
- research-investigate-existing (2026-04-11) near 2026-04-11 April triage
- integration-verify-all (2026-04-11) near 2026-04-11 April triage
- implement-retry-logic-cargo (2026-04-11) near 2026-04-11 April triage
- comprehensive-verify-timeout-functionality (2026-04-11) near 2026-04-11 April triage
- .verify-research-output-management (2026-04-11) near 2026-04-11 April triage
- implement-verify-timeout (2026-04-11) near 2026-04-11 April triage
- resolve-remaining-test-compilation (2026-04-11) near 2026-04-11 April triage
- missing-scoped-verify-enabled (2026-04-11) near 2026-04-11 April triage
- .verify-fix-coordinator-lifecycle (2026-04-11) near 2026-04-11 April triage
- compilation-during-verify-impl (2026-04-11) near 2026-04-11 April triage
- harness-completion-polling-verify (2026-04-12) near 2026-04-11 April triage
- impl-prevent-self-failure (2026-04-12) near 2026-04-11 April triage
- impl-verify-decomposition (2026-04-12) near 2026-04-11 April triage
- implement-cycle-detection-guard (2026-04-12) near 2026-04-11 April triage
- disable-auto-verify (2026-04-12) near 2026-04-11 April triage
- .verify-fix-remove-unused-9 (2026-04-12) near 2026-04-11 April triage
- smart-verify-detect (2026-04-12) near 2026-04-11 April triage
- .verify-integrate-and-validate (2026-04-12) near 2026-04-11 April triage
- .verify-implement-robustness-improvements (2026-04-12) near 2026-04-11 April triage
- integrate-robustness-improvements (2026-04-12) near 2026-04-11 April triage
- .verify-implement-recovery-branch (2026-04-12) near 2026-04-11 April triage
- comprehensive-concurrent-head-reference (2026-04-12) near 2026-04-11 April triage
- nex-delegate (2026-04-13) near 2026-04-11 April triage
- investigate-sglang-400-bad (2026-04-13) near 2026-04-11 April triage
- .verify-deferred-nex-cron-coordinator (2026-04-14) near 2026-04-11 April triage
- unified-path-forward-tool (2026-04-16) near 2026-04-11 April triage
- gated on config/env (2026-04-16) near 2026-04-11 April triage
- remove autonomous gate (2026-04-16) near 2026-04-11 April triage
- agent-76 (2026-06-03) near 2026-06-03 Autopoietic C4 loop failure
- provider-backoff-contract (2026-08-16) near 2026-08-16 Provider backoff failures (route instability burst)
- scope-model-review-rejection (2026-08-20) near 2026-08-16 Provider backoff failures (route instability burst)
- reconcile-landing-target-project (2026-09-04) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- reconcile-landing-target-service (2026-09-04) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- reconcile-landing-target-harden (2026-09-04) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- fence-late-landing-races (2026-09-04) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- project-config-sole-execution (2026-09-04) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- completion-landing-reconciliation (2026-09-04) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- genuine-flip-v2-seed (2026-09-05) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- completion-rejections-landing-leases (2026-09-05) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- bound-reviewer-context-surface (2026-09-05) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- reject-global-routing-aliases (2026-09-06) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- finish-project-local-authority (2026-09-06) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- review-causal-evidence-boundary (2026-09-06) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- distinguish-implementation-candidate-evidence (2026-09-09) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- record-config-acceptance-evidence (2026-09-09) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- restore-main-ci-canary (2026-09-09) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- bounded-worker-completion-repair (2026-09-10) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- fail-closed-incomplete-cleanup (2026-09-10) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- bind-validation-receipt-source (2026-09-10) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- preserve-smoke-repair-validation (2026-09-10) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- ownership-scenario-broad-smoke (2026-09-10) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- bounded-source-provider-recovery (2026-09-10) near 2026-09-09 Provider backoff second burst; wire reconfiguration
- allow-completion-help-semantic (2026-09-13) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- record-baseline-admission-reproduction (2026-09-13) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- scope-cold-baseline-fences (2026-09-13) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- refresh-exact-cargo-baseline (2026-09-13) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- unify-project-route-authority (2026-09-13) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- refuse-conflicting-opaque-model (2026-09-14) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- capture-exact-candidate-real (2026-09-14) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- reconcile-wake-proof-validation (2026-09-14) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- separate-optional-completion-evidence (2026-09-14) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- remove-incidental-message-proof (2026-09-14) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- prove-service-route-authority (2026-09-14) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- preserve-route-less-service (2026-09-14) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- managed-process-wake-proof (2026-09-14) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- stabilize-explicit-selection-release-gate (2026-09-15) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- reject-invalid-opaque-capability (2026-09-15) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- reverify-corrected-opaque-execution (2026-09-15) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- complete-opaque-launch-contract (2026-09-15) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- retain-semantic-evidence-gaps (2026-09-15) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- capture-opaque-boundary-scenario (2026-09-15) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- verify-opaque-execution-boundary (2026-09-15) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- renew-legacy-environment-drifted (2026-09-16) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- reconcile-landing-target-route (2026-09-16) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- stable-environment-identity-deterministic (2026-09-16) near 2026-09-13 Config-layer governance disable (auto_evaluate, verify_autospawn)
- config:agency-auto-evaluation (2026-08-08) near 2026-09-13 Config-layer governance disable

## Confidence caveats
- Suffix-based clustering (topic in parens) is high confidence; key-phrase clustering merges/splits imperfectly—treat medium-confidence rows as indicative.
- Commit-subject vocabulary is a proxy; silent constraint changes inside src/ without governance vocabulary are invisible to this census (motivates §6 'gate ledger' feature).
- Config snapshots exist only for Aug 8 and Sep 13; earlier config-layer ratcheting is unrecorded.

## The singleton finding (added 2026-09-16, post-analysis)

- **290 of 311 constraint topics (93%) have exactly one commit**—born once, never revisited, never retired. Only 21 topics were ever hardened (2+ commits), and only 14 removal-verb governance commits exist in the entire history.
- Interpretation: the ratchet is not a story of constraints being *maintained*—it is a story of constraints being **emitted**. Governance in this system behaved like an append-only log written by each incident's responding agent. Fire-and-forget rule-making at machine speed, with retirement ~40x rarer than birth (14 removal commits + 1 config event vs ~344 additions).
- This sharpens the paper's §4.1: the missing mechanism is not gate review (nothing was reviewed) but **gate amortization of any kind**—there was no path by which a constraint could naturally die.
