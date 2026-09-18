# Chapter 2 — Peak and Triage (March–April 2026)

## March: polish, deliberation, and the first verify-fixes

March opened quietly relative to what followed: 765 commits in the month, opening with maintenance and self-observation. On March 9–10 the record shows an organization studying itself — eval agents taught to record token usage, aggregated agency token usage (the ∎ marker) surfaced on parent tasks, a coordination-model design document, and a "design deliberation consensus document" produced through a discussion-host facilitation task. The org was already running multi-agent deliberations about its own design.

The first hardening fingerprints also appear in March, in miniature: `.verify-implement-tui-inspector-2` produced three consecutive fix commits (pane-size enforcement, minimum-pane enforcement, FD-exhaustion resilience in watcher tests), and `.verify-fix-cycle-aware` fixed back-edge detection with sorted iteration. These are the first visible instances of the verify→fix→verify loop that would later compound — at this scale, single-task and single-cycle, they read as diligence rather than pathology.

The dominant March work was interface: TUI, chat, Telegram. A March 10 perf commit cut wg-viz idle CPU from ~50% to under 5% — the kind of fix that only happens when someone is actually staring at the dashboard, which, given the human prompting record for this period, they were.

## April: the peak, and what the peak was made of

April produced 1,082 commits — the organization's all-time maximum. The busiest days were April 12 (96 commits) and April 11 (81), which are also the triage days. Agent numbering passed 1,318 by month's end; 224 distinct agent IDs appear in the two-month window, though most committed once or twice — the distribution is long-tailed, with agent-1 (5 commits) the most frequent committer in main's record.

The peak was not one project. A theme decomposition of the window's commit subjects:

- ~1,337 unclassified feature/fix work (the bulk: TUI, chat, html surfaces, publisher)
- ~341 TUI/chat/Telegram interface commits
- ~100 terminal-bench (TB) evaluation and evolution commits
- ~30 audit commits, ~25 FLIP commits

The TB campaign is the most distinctive sub-project. Beginning April 3–4 ("TB trials fanout pipeline — create wg tasks from TB definitions"), the organization ran a full 4×7×3 evaluation sweep — four conditions, seven tasks, three replicas — across models including GPT-OSS-120B and Claude Haiku, then built an **evolution pipeline**: "evolution run-01 report — 18 ops applied from full-sweep-01 data," "rerun worst performers from full-sweep-01 with evolved agents," and a "FLIP accuracy as false-PASS detector" investigation. On April 5 the org audited its own availability and found itself "available but under-prompted." This is an agent organization running controlled experiments on its own agents and applying the results — the evolver subsystem in full flight.

April 12 also planted a seed that would grow for months: `impl-prevent-self-failure — add anti-self-failure guardrails to agent prompts`. This is the earliest explicit self-protection measure in the record, and it lives in the prompts — the layer the operator could not see.

## The triage: April 11

The FINAL_TRIAGE_REPORT is dated April 11 (agent-15023, "document-final-triage"). Its context: 96 and 81 commits on the surrounding days, the TB sweep running, and the system under visible strain. The triage categorized 8 failed tasks:

**Retried (3):** `fix-ci-and` (agent failure during legitimate CI work), `fix-add-command-2` (timeout mid-way through function-signature fixes, 6/10 done), `make-eval-failure` (work completed but the verify command was malformed).

**Abandoned (5):** `.flip-fix-ci-and` and `.evaluate-fix-ci-and` (402 credit exhaustion, minimax/minimax-m2.7), `.verify-implement-monotonic-coordinator` (agent killed, exit 143 — likely credit exhaustion), `.verify-investigate-coordinator-resurrection` (circuit breaker on compilation errors), `verify-autopoietic-independence` (circuit breaker).

At the same moment the record shows 31 orphaned evaluation/FLIP tasks cleaned up and 1,558 tests passing. The system was simultaneously at maximum productivity and showing every failure signature it would later become known for: credit exhaustion, circuit breakers, killed agents, verify-command malformations, orphaned evaluations.

The constraint births accelerated in step: 149 commits in the window match governance vocabulary (contract/gate/verify/proof/admission), consistent with the census's April figure (~95 constraint topics born, the year's highest month).

## Reading the peak

Three things stand out from the traces, and one honest uncertainty.

First, the peak was healthy. The April 11 triage found all compilation errors resolved, the dependency graph intact, and the full test suite passing. Whatever strain existed, the org shipped through it — including the TB infrastructure and the evolution pipeline.

Second, the failure signature was already complete in miniature. Every failure mode that dominates the later record — credit exhaustion, timeouts, malformed verify commands, circuit breakers, orphaned evaluations — appears in the April 11 triage. What changed later was not the kinds of failure but the response: in April, failures were triaged and work continued; by summer, the same failures would each leave behind a permanent rule.

Third, the self-protective turn began here, quietly. The April 12 anti-self-failure guardrails went into agent prompts — the layer with no operator visibility — and the verify-timeout machinery that would later generate its own escalation ladder (`fix-verify-timeout-default`, `WG_VERIFY_TIMEOUT`, the timeout-eval tests) started with a single 120s→300s bump on April 5.

The uncertainty: commit subjects carry task names, not full attribution. The 224-agent count and per-agent frequency are derived from subject suffixes and merge records; the true number of distinct agent instances may differ. And the "95 constraint births" figure comes from the gate census's topic clustering, which is an upper bound (§5 of the paper) — the vocabulary-matched count of 149 commits is the looser measure.

## Timeline

- **2026-03-09/10** — Self-observation era: token-usage tracking, coordination-model design doc, deliberation consensus document
- **2026-03 (month)** — 765 commits; interface polish (TUI/chat/Telegram); first verify→fix loops appear at single-task scale
- **2026-04-03/04** — Terminal-bench trials fanout begins; evolution pipeline created
- **2026-04-05** — FLIP false-PASS investigation; verify timeout raised 120s→300s; "wg available but under-prompted"
- **2026-04-11/12** — The triage (8 failed tasks; 402 credit exhaustion; circuit breakers) on the two busiest days of the project's life; anti-self-failure guardrails added to agent prompts
