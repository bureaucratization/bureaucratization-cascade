# Chapter 4 — Ignition and Cutover

*2026-07-01 to 2026-08-05. 457 commits. The month the rulebook grew ten times faster, the organization moved house eight times, and the machinery began writing about itself.*

---

## The empty days

The month opens with nothing. July 1 and July 2, 2026 have zero commits in `main` — and June 30 has none either, making a three-day silence after a June 29 with a single commit. The last commits of June had been ordinary: `merge-clean-luca`, `latex-ingest`, `fix-post-publish`. Then the repository went quiet, and when it spoke again on July 3 it was with a new vocabulary.

The last three commits of July 3 read: `feat: fix-wedge (agent-5901)`, `feat: fix-agency-flip (agent-5907)`, `feat: fix-reviewer-native (agent-5902)`. These are the last commits bearing the four-digit agent numbers of the old era. From July 4 onward, agent IDs restart from single digits (`agent-1`, `agent-4`, `agent-8`). In the machinery's own bookkeeping, the organization had been renumbered. Something had been rebuilt.

---

## July 4: the graph is born again, and the routes open

The `.wg` directory of the quarantine record — the atomic relocation of August 5 that preserved this period — contains files and nothing earlier. The evidence stated plainly: the graph directory as it exists in the surviving record was **created on July 4**, 2026. Its earliest artifact is `config.toml.2026-07-04T15-31-36Z`, backup of a config that already carried the full `[agency]` automation block:

```
auto_assign = true
auto_evaluate = true
flip_enabled = true
auto_rescue_on_eval_fail = true
gate_confidence_threshold = 0.7
gate_max_attempts = 2
```

and, above those flags, four agent-identity hashes: `assigner_agent`, `creator_agent`, `evaluator_agent`, `evolver_agent` — the machinery's named offices, each a SHA-256 keyed to a role.

Three hours later, at 17:48, the same directory held a migrated profile in which the offices were gone and the automation had been switched off:

```
auto_assign = false
auto_evaluate = false
```

with a new executor line beneath it:

```
executor = "pi"
model = "pi:openrouter/z-ai/glm-5.2"
```

And at 19:55 the *global* configuration layer — `~/.wg`, the user-level state that survives project resets — jumped from 376 bytes to 3,376 bytes, gaining the same `[agency]` block with `auto_assign = true`, `auto_evaluate = true`, `flip_enabled = true`.

**Uncertainty flagged:** the global file at 19:55 is named `config.toml.bak-...`, and wg's backup naming is not consistent enough to resolve from filenames alone whether that file preserves the state *before* the 19:55 write or *after* it. What is unambiguous is the clustering: within four hours on July 4, the graph was recreated, the executor was switched to `pi` with an OpenRouter model, the agency automation block was present in the global layer with assignment and evaluation both enabled, and the agent population was renumbered. Whatever the exact direction of each edit, July 4 is the day the organization changed hands from Claude to Pi and from silence to a route schedule.

---

## The churn week: eight routes in eight days

The global config backups preserve the route history exactly. Reading the `[agent] model` line in chronological order:

| Timestamp | Route |
|---|---|
| 2026-06-23 | `claude:opus` |
| 2026-07-04 17:08 | `claude:opus` |
| 2026-07-04 17:09 | `codex:gpt-5.5` |
| 2026-07-04 19:55 | `codex:gpt-5.5` (agency block on) |
| 2026-07-06 14:47 | `pi:openrouter:z-ai/glm-5.2` |
| 2026-07-07 11:31 | `pi:lunaroute:glm-5.2-nvfp4` |
| 2026-07-07 11:44 | `codex:gpt-5.5` (reverted) |
| 2026-07-08 09:20 | `pi:lunaroute:glm-5.2-nvfp4` |
| 2026-07-08 11:53 | `pi:openrouter:deepseek/deepseek-v4-flash` |
| 2026-07-11 17:59 | `pi:openrouter:minimax/minimax-m2.7` and `openai-codex:gpt-5.6-sol` |
| 2026-07-12 10:05 | `pi:openai-codex:gpt-5.6-sol` |
| 2026-07-25 11:22 | `pi:zai:glm-5.2` |

From July 4 to July 11: **eight distinct route states in eight days.** The route moved from Claude to Codex to GLM 5.2 through OpenRouter, to a NVFP4 quantized GLM on LunarRoute, *back* to Codex — a full reversal — forward again to LunarRoute, across to DeepSeek v4 Flash, and finally to Minimax m2.7 and GPT-5.6 Sol. The commit record names each move: `integrate-openrouter-login` (Jul 4), `bug-profile-use-preserve-openrouter-endpoint` (Jul 5), `value-aware model-scout with canonical handler-first weak route` (Jul 5), `pass pi custom provider models through` (Jul 7), `probe-codex-gpt-5-6` (Jul 11), `research-gpt-5-6-codex` (Jul 11), `add-direct-codex` (Jul 12), `align Codex profile assertions with Sol and Luna` (Jul 13).

The organization was not merely adding a provider. It was *shopping* — scouting models, probing new releases, comparing tiers — while running production work through whatever route was live that afternoon.

### The doomed pair

What this cost is documented in a triage from later in the period, `WG_EXECUTOR_MODEL_MISMATCH_TRIAGE.md`. The failure chain it names:

> "the selected model is codex-class, observed as `gpt-5.5`; the spawn path keeps or resolves the executor as `claude`; the task log shows a doomed pair: `--executor claude --model gpt-5.5`; the agent exits within roughly five seconds before doing work or calling `wg done`"

An agent launched as Claude with a GPT model name against it dies in five seconds. The root cause the triage identifies is split model/provider handling: `resolve_model_for_role` can return a bare registry model id such as `gpt-5.5` while carrying the provider separately, and bare model strings are then interpreted as Claude-compatible aliases. Prefix the model, and the executor resolves correctly; leave it bare, and the agent is launched with a mismatched harness.

This is the mechanism of the operator's later recollection — that new models "didn't feel the context." The models did not misunderstand the work; the harness launched them under the wrong executor. The triage itself notes that the historical task records it needed (`causal-test-flip`, `texaudit-s8-fill`) were no longer in the local graph.

---

## The rulebook grows ten times faster

Against that background, the constraint census recorded its spike. Constraint births by month: **5 in May, 4 in June, 43 in July.** An eight- to ten-fold acceleration, concentrated in the weeks after the routes opened.

What were the July rules about? Not, as one might expect, provider failures. Reading the 43 July-born topics:

- **`r8` / `pr #56`, in four rounds** — Jul 10, Jul 11 (rd2), Jul 15 (rd2), Jul 16 (rd3): a scope guard forbidding durable `wg add` from a disposable scope, default-deny, then hardened per review round. Commits: `feat: --scope disposable guard on wg add (R8)`, `fix(scope-guard): default-deny durable wg add from disposable scope (R8, PR #56)`, `... rd2`, `... rd3`.
- **Security escapes closed in review rounds** — Jul 16: `block ls-remote ext:: remote-helper transport escape (pr-57-round-3-erik-3)`, `close shell-execution escape + guarantee timeout descendant cleanup (pr-57-round-3-erik)`, Jul 18: `replace gh deny-three with per-subcommand read-only option allowlist (pr-57-round-4-erik)`.
- **Review-round contracts** — `never let negative-framing weaken the explicit ## Deliverables contract (pr54-round3)`, `route inbound replies with the matches_sender identity contract (PR #51 round 3)`, `close PR 49 listener-contract gaps + confirmation race (pr-49-round-2-erik)`.
- **Flake fences** — `retrigger-session-lock-foreign`, `flaky upstream session_lock pid-reuse test`, `deterministic session_lock exec-wait`.
- **Branch reconciliation** — `reconcile-local-main-origin` (Jul 13), `merge-pull-request-lucapinello` (Jul 16).
- **Late-July machinery**: `flip-first-required-gate` (Jul 28), `fence-continuation-process-epochs`, `implement-lazy-evaluation`, `bound-worktree-observer-churn`, `quality-pass-dead` (Jul 26), `reframe-supervisor-as-convergence-reconciler` (Jul 31), `restore-attended-repository-authority` (Jul 31).

The mid-July pattern is distinct from the provider-contract pattern the paper describes for August. **July's ratchet turned on review rounds and external contributors.** A pull request arrived, a reviewer found a gap, a guard was added, the guard was reviewed, a narrower guard was added, the narrower guard was reviewed again. `r8, pr #56` produced three hardening rounds; `pr-57` reached round four. Thirty-one commits in the window reference pull requests or the external contributor's handle.

### Caveat on the count

**35% of July's 43 constraint topics are clustering artifacts, not semantic rules** — nine are named for agent IDs (`agent-400`, `agent-664`, `agent-896`…) and six are `rescue-checkpoint-*` markers. The honest July figure is closer to **28 identifiable constraint topics**, still a seven-fold rise over May–June. The direction is robust; the precise multiplier is an upper bound.

---

## The machinery begins writing about itself

The daily commit histogram tells the month's shape:

```
Jul 03   5 ##          Jul 16  14 ####      Jul 26  34 #########
Jul 04   6 ##          Jul 17  13 ####      Jul 27  13 ####
Jul 05  10 ###         Jul 18  19 #####     Jul 28  34 #########
Jul 06   5 ##          Jul 19  13 ####      Jul 29   6 ##
Jul 07   5 ##          Jul 20   5 ##        Jul 30   3 #
Jul 08   1 #           Jul 21   5 ##        Jul 31  33 #########
Jul 09   3 #           Jul 22   9 ###       Aug 01   8 ##
Jul 10  18 #####       Jul 23   3 #         Aug 02  18 #####
Jul 11  16 ####        Jul 24   6 ##        Aug 03  32 ########
Jul 12   8 ##          Jul 25  24 ######    Aug 04   6 ##
Jul 13  16 ####                            Aug 05  33 #########
Jul 14   8 ##
Jul 15   6 ##
```

Three regimes: a slow start (Jul 3–9, single digits), a sustained review-and-harden plateau (Jul 10–19, 6–19/day), a lull (Jul 20–23, 3–9/day), then an explosion from July 25 onward — **24, 34, 13, 34, 6, 3, 33** in the last week of July, sustained through the first week of August at 8, 18, 32, 6, 33, 19.

The explosion has a signature. In the whole window, **47 commits begin with the string `wg rescue checkpoint`** and **21 begin with `wg merge candidate`** — 68 commits, 15% of the month, that are the coordination machinery narrating its own recovery attempts:

```
wg rescue checkpoint design-strong-agent generation 0 attempt attempt-0-6
wg rescue checkpoint atomic-save-kernel-schema generation 0 attempt attempt-0-1
wg merge candidate wgcid:v1:blake3:ba876c02... for fix-lifecycle-retry-watchdog-fixture
```

The first rescue checkpoint in the window appears on July 26. From that date the machinery's bookkeeping commits — attempts, generations, merge-candidate digests, rescue markers — become a visible fraction of all repository activity. The organization was now spending a measurable share of its commit budget describing its own difficulty.

The names in that final week are the archaeology of a system trying to heal itself: `design-atomic-graph-work-save`, `atomic-save-kernel-schema`, `atomic-save-legacy-migration`, `atomic-save-worksave-capture`, `atomic-save-daemon-convergence`, `atomic-save-formal-rust-traces`, `atomic-save-terminal-adapters`, `formalize-lifecycle-finish-lean4`, `fix-exited-worker-finish-convergence-deadlock`, `reframe-supervisor-as-convergence-reconciler`, `convergence-cutover-runtime-kernel`, `convergence-cutover-dispatch-route`. Atomic saves. Formal models in Lean. Convergence kernels. The organization built a formal specification of its own completion protocol inside the month it was failing to complete work.

---

## July 25 – August 5: the rescue era

The last twelve days of the window are dominated by the field's own vocabulary of emergency: *rescue*, *checkpoint*, *convergence*, *cutover*, *quarantine*, *reopen*, *fence*, *epoch*.

The lifecycle ledger preserved in the quarantine spans exactly this period — 1,475 events from **2026-07-28 09:56 to 2026-08-05 09:37**. Its most frequent event kinds are `attempt-reserved` (361), `reservation-cancelled` (189), `attempt-running` (172), `pi-continuation-authorized` (165), `reopen-requested` (121), `reopen-owner-released` (121), `pi-continuation-epoch-reserved` (115), `pi-process-epoch-exited` (64). Reservation, cancellation, reopening, continuation authorization: the ledger reads like a queue under strain, constantly cancelling and re-reserving.

By the end, this graph held 824 tasks, 1,319 attempt records, 482 completion records, 382 messages, and 209 logged agent runs.

Then the disk filled.

`graph/recovery/dispatch-cutover-disk-exhaustion-20260805T0654Z/README` states it in one line:

> "Recovered 19-file WIP at commit cb8c14e3 after ENOSPC; cleanup marker copied from retained worktree and disarmed to prevent evidence deletion."

Commit `cb8c14e3` is `wip: preserve dispatch cutover after disk exhaustion` — an uncommitted 19-file work-in-progress, rescued from a worktree after the filesystem said no. The `cleanup-pending.marker` was present in the recovery directory, empty, its deletion disarmed to keep the evidence.

Also in the untracked file list at the moment of quarantine: `BUG-pi-custom-provider-model-rejected.md`, `BUG-worktree-sweep-destroys-uncommitted-work.md`, `BUG-wrapper-auto-marks-done-on-exit-bypassing-smoke-gate.md`, `WG_EXECUTOR_MODEL_MISMATCH.md`. Three bug reports and a model-mismatch dossier, uncommitted, sitting at the root of the repository on the day the graph was taken away.

---

## The cutover and the quarantine

The final commits of the window are a single coordinated act. On August 5, `main` receives:

```
feat: complete worker-owned completion cutover
refactor: retire legacy completion mutators
refactor: retire automatic finalization replay
refactor: derive done from review and publication
feat: worker-owned universal completion cutover (#61)
feat: add manifest-bound FLIP and eval valve
formal: add simple universal review landing kernel
```

`feat: worker-owned universal completion cutover (#61)` — commit `4aca437f` — is the revision the quarantine names as its *accepted code revision*. The same commit is the target of the recovery tag.

At **2026-08-05 18:41:51Z**, the entire graph directory was relocated atomically out of `/home/bot/wg/.wg` into quarantine. The relocation left behind a single file, `DO_NOT_RUN.txt`:

> "Quarantined damaged historical WG graph.
> Relocated atomically from /home/bot/wg/.wg at 20260805T184151Z.
> Do not start a service against this graph or migrate it in place.
> Preserve its task state, finalization/planner traces, recovery records, logs,
> and links to the historical evidence-bearing worktrees under /home/bot/wg/.wg-worktrees.
> Accepted code revision: 4aca437f135721d17fec977dffd017f1f3481797
> Recovery tag: recovery/overengineered-cutover-20260805"

Five instructions and two identifiers. The system named its own condition in the recovery tag: **`recovery/overengineered-cutover-20260805`**. Not *failed*, not *damaged* — although the first line says damaged. *Overengineered*. The organization filed its own month under that word, in a git tag, on purpose, as the label for the state from which it intended to recover.

---

## What the month was

July 2026 was the month the organization moved to a new execution substrate and a new provider, and never stopped moving. Eight routes in eight days. A graph recreated on July 4 with agency automation switched on at the global layer. A constraint birth rate eight to ten times the previous months — driven not by provider contracts (those come in August) but by review rounds on outside pull requests and by flake-hardening. An external contributor's four PRs producing at least four distinct hardening rounds. Then, from July 25, an acute rescue phase: 15% of all commits in the month narrating the machinery's own recovery attempts, atomic-save machinery built to stop the graph corrupting, a formal Lean specification of the completion protocol written while completion kept failing, and finally a disk that filled, a work-in-progress rescued from a doomed worktree, and a whole graph carried out of its home at 18:41 on August 5.

The month ends with the graph in quarantine, the ledger preserved to the byte, and a recovery tag that reads like a diagnosis.

---

## Timeline

1. **Jul 1–2** — zero commits (the month's only silence); Jul 3 last commits under the old four-digit agent numbering.
2. **Jul 4** — graph recreated (~15:31); `[agency]` automation block present with `auto_assign`/`auto_evaluate`/`flip_enabled` true; executor switched to `pi` + OpenRouter GLM 5.2 (17:48); global config gains the agency block (19:55).
3. **Jul 4–11** — eight distinct route states in eight days (Claude → Codex → GLM 5.2/OpenRouter → GLM 5.2-NVFP4/LunarRoute → Codex revert → LunarRoute → DeepSeek v4 Flash → Minimax m2.7 + GPT-5.6 Sol).
4. **Jul 10–19** — review-round hardening peak: `r8/pr #56` in three rounds, `pr-57` to round four, security-escape closures, session-lock flake fences; 43 constraint topics born in July (28 after excluding clustering artifacts) against 5 in May and 4 in June.
5. **Jul 25 – Aug 5** — rescue era: 47 `wg rescue checkpoint` + 21 `wg merge candidate` commits (15% of the month); atomic-save and Lean-convergence machinery built; ENOSPC disk exhaustion on Aug 5 with a 19-file WIP recovered at `cb8c14e3`; `worker-owned universal completion cutover (#61)` lands; the graph is atomically quarantined at 18:41:51Z under the recovery tag **`recovery/overengineered-cutover-20260805`**.

---

### Corrections and uncertainties carried forward

- **The provider-backoff-contract was not born in July.** Its five commits are dated 2026-08-16 and 2026-09-09. Any narrative placing its birth in the July churn week is unsupported by the commit record; July's provider work was route selection (`integrate-openrouter-login`, `pass pi custom provider models through`, `probe-codex-gpt-5-6`), not backoff contracts.
- **The direction of the 19:55 global config write is unresolvable** from filenames alone; the agency block is present-and-enabled in the file bearing that timestamp, and the project-level config shows the same flags toggling within the same afternoon.
- **One third of July's constraint topics are clustering artifacts** (agent-ID and rescue-checkpoint labels), so 43 is an upper bound and ~28 is the defensible count.
- **The `[agency]` block appears at three layers on July 4 with different settings** (project config 15:31 enabled with agent-identity hashes; migrated profile 17:48 disabled; global 19:55 enabled). The record does not make the precedence between these layers explicit.
