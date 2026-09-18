# Chapter 6 — Recovery and Burden: The Gummy Month

## August 12 – September 13, 2026

*(commits 2026-08-12 → 2026-09-13; ledger window Aug 8–Sep 16; 99 commits in window)*

---

### The silence after the quarantine

The gummy month begins in near-silence. After the twin traumas of early August — the atomic quarantine of August 5 and the re-clone from GitHub on August 7 — the primary organization produced almost nothing for three weeks. The commit record shows: four commits on August 16 (the provider-backoff-contract docs burst, closing its three-week-old ambiguity gaps), one on August 20 (a completion-budget fix), then nothing until September 2. Nineteen days of near-total quiescence, August 21 through September 1.

The ledger agrees. Of 115 distinct tasks in the post-reset ledger, August's share is thin: 61 attempts reserved, 39 unique tasks succeeded, 12 attempt-failure events, 5 abandonments. The organization was alive but moving slowly — a convalescent pulse after the cutover.

The configuration tells you why. The surviving pre-intervention snapshot (`config.toml.bak-2026-09-13T02-32-08Z`) shows the machinery in its wounded state: `auto_evaluate = true` still on, but `flip_enabled = false`, `auto_assign = false`, `auto_create = false`, `auto_triage = false`, `auto_rescue_on_eval_fail = true`. The automation that had compounded the spring's cascade was off; what remained was a system running on attended, half-disabled machinery — capable of work, but with every movement requiring supervision. The deferral record shows the cost of that posture: even in quiet August, tasks were being held at the door (2 deferral events, an early tremor of what September would bring).

### The deepening tightness

The task mix in late August and early September tells a story of an organization working on its own reliability rather than its purpose. The commits are dominated by governance-adjacent repair: the provider-backoff-contract docs trio (Aug 16), a completion-rejection budget scoped to source attempts (Aug 20), then — after the September 2 resumability fix and the September 3 design document for project-local Pi configuration — a rapid sequence of authority hardening: "reject all global routing aliases" and "finish project-local Pi authority contract" (both September 6), "bound completion review evidence in time," "pin causal completion review boundary" (September 6), the genuine-FLIP-v2-seed pair (September 5), "Make completion rejections and landing leases authoritative" (September 5).

This is the gummy pattern in commit form: the machinery of acceptance — landing leases, review boundaries, evidence binding, canary gates — receiving obsessive attention while the product itself waits. The commit vocabulary of the window is telling: *bound, pin, scope, exact, authority, boundary, fence, gate, lease, canary*. The org had learned from its collapse that discipline was survival, and it was applying discipline everywhere — including where it would soon become "hardcore and gummy."

### September 4: the fleet re-routes

Amid the tightening, one date marks a quiet revolution: September 4, when two config commits routed Pi workers through "Codex Sol" and Pi agency reviews through "Codex Luna," followed by "make project config sole execution authority." This is the gpt-6-astra-era fleet arriving — the mid-September model-generation shift the metering data confirms (gpt-6-astra: $73.61 across 329 billed messages after this date). The organization was re-founding its model stack on project-local Pi authority at the same moment it was tightening every acceptance surface. New models, new authority structure, new tightness — all in the same week. It is worth noting the coincidence: the model-generation shift and the peak tightness arrive together, and the recovery that follows will be credited to the config change. The ledger cannot fully separate these causes; the paper says so.

### The deferral anomaly

Then September 3–4 opened the gates of a strange new phenomenon: admission deferrals. The ledger records 2,505 admission-deferred events in September against 2 in all of August — clustered at Sep 3 (789), Sep 15 (1,567), Sep 16 (112). The deferrals continued and even peaked *after* the September 13 intervention, so they are not the cost the intervention removed; they are the signature of an admission filter that stayed active throughout, through which a resurgent task population now had to pass. The task mix suggests the source: a refresh-build-baseline-admission task repeatedly re-attempting admission. The org had, in effect, an admission bouncer that became the busiest worker in the building.

### The Sept-13 boundary measured at task grain

The ledger's sharpest measurement brackets the intervention precisely:

| 7-day window | attempts | unique succeeded | failed | abandoned |
|---|---|---|---|---|
| Sep 6–12 (before) | 14 | 9 | 5 | 0 |
| Sep 13–19 (after) | 51 | 35 | 6 | 4 |

Unique completions rose 3.9×; attempt volume rose 3.6×; the failure rate fell from 36% to 13% — not because fewer attempts failed in absolute terms (5 → 6), but because far more attempts now succeeded. The system resumed *attempting* work at scale the moment enforcement autonomy was disabled. The after-window's task mix is recovery-and-release work: `first-user-release-rehearsal`, `fix-first-user-landing-ux`, `unify-project-route-authority`, repeated `route-verification-probe` runs — the org repairing its front door before opening it.

### The audit-charter receipt

The window's defining artifact is the surviving completion transaction for `audit-charter` — all five phases (implementation, validation, manifest, FLIP, evaluation) succeeded, and publication was then refused by three independent control surfaces: land refusing overwrite, the control plane refusing an unmerged-worktree override, and the waiter refusing on missing park attestations. Every gate passed; the task died anyway. This is the gummy month's thesis in a single receipt: acceptance had become over-determined, and correctness no longer implied completion.

### Reconciling the two stories

The commit record and the ledger disagree in emphasis, and both are true. Commits say: quiet August, then an explosion of acceptance-hardening and route-authority work September 4–13, with the intervention itself nearly invisible in git (a config-layer event) and the following days dominated by baseline fences and admission repairs. The ledger says: quiet August, a task-starved system that resumed attempting work at 3.6× volume the day autonomy was disabled, with completions rising 3.9× and the failure rate halving. Together: the gummy month was real (deferrals, tightness, the receipt), and the intervention worked on the dimension the commits couldn't show — the permission to attempt.

### Timeline

- **Aug 16** — provider-backoff-contract docs trio; ambiguity gaps closed, no functionality shipped
- **Aug 20 – Sep 1** — near-silence: one commit in twelve days; machinery half-disabled, org convalescing
- **Sep 2–6** — project-local Pi configuration designed, migrated, proven; routing aliases rejected; authority contracts bound
- **Sep 4** — fleet re-routes to Codex Sol/Codex Luna (the gpt-6-astra arrival); project config made sole execution authority
- **Sep 13** — enforcement autonomy disabled; completions 9→35/week; baseline fences and admission repairs follow immediately
