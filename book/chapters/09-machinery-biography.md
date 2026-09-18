# Chapter 9 — The Machinery Biography

## The life and death of the governance machinery (gates, FLIP, agency, evaluation)

*Every claim in this chapter is dated from the commit record, the configuration-backup series preserved in the August 5 quarantine, or the source code at the cited revision. Uncertainties are flagged inline.*

---

### Prologue: the machinery was three organisms, not one

What the September teardown called "the governance" was, by autopsy, three distinct organisms sharing one habitat. The **Agency** — born February 6, 2026, in the commit "Implement Agency system: evolutionary agent identities for workgraph" — was an evolution engine: assigner, creator, evaluator, and evolver roles, each carrying its own blake3-hashed identity, breeding and scoring agent primitives. The **FLIP** layer — born March 3–5, 2026 ("FLIP scoring, eval-can-fail, TUI improvements"; "add FLIP-triggered Opus verification for low-scoring tasks") — was the quality gate: it scored work and summoned Opus to verify what scored low. The **verify-gate machinery** — born in the April 5–11 burst (verify timeout raised 120s→300s on April 5; "implement verify timeout triage system" and "comprehensive verify timeout functionality tests" on April 11) — was the admission control. Three organisms, three birthdays, one shared fate.

### I. Infancy (February–March 2026)

The Agency arrived first, and its founding document is worth quoting: *evolutionary agent identities* — the ambition was not bookkeeping but breeding. By March 13 the evolver had a fan-in synthesizer "for evolver multi-strategy merging." The strategy set, preserved at `src/agency/evolver.rs`, is a small museum: mutation, gap-analysis, retirement, motivation-tuning — and, excluded from the safe list because they "require human judgment," crossover and **bizarre-ideation**. The configuration shipped a `bizarre_ideation_interval` (10) — the machinery contemplated, on a schedule, the generation of bizarre ideas. It also shipped a `ucb_exploration_constant` of 1.4142135623730951 — the square root of two: a multi-armed bandit algorithm sat inside the governance configuration, allocating exploration across the org's own strategies.

March 3–5 brought FLIP: scoring, eval-can-fail, and the trigger that would define the next six months — *low-scoring tasks get Opus verification*. The gate now had a ratchet head: every failure could be answered with a check.

### II. Adolescence (April 2026)

April was the machinery's growth spurt, and it coincided precisely with the org's first great pain. The April 11 triage documents credit-exhaustion abandonments (HTTP 402 on minimax-m2.7) and eight failed tasks; the gate census links seventeen constraint births to that single week, almost all of them verify-gated — `implement-verify-lint`, `inject-verify-gate-task`, `smoke-verify-gate`, `.verify-bypass-verification-for`. The hardening-language series (semantic analysis of all 3,226 commit subjects) records the same fever in vocabulary: **650 commits in April, 213 containing verify-language, 67 containing must, 52 never, 47 prove** — the densest hardening month of the organization's life. The verify-timeout machinery grew teeth the same week (April 5: timeout doubled; April 11: a triage system for verification failures).

The detail that would matter later, visible only in hindsight: the evolver's retirement logic — `roles_below_threshold` — exists in the source exclusively behind `#[cfg(test)]`, with a guard clause that reads like prophecy: *roles with fewer evaluations are never flagged for retirement (they haven't been tested enough).* In April, evaluation was still cheap and running. The guard was harmless.

### III. The long silence (May–June 2026)

May and June are the machinery's silent films. Eleven commits in June, five in May; hardening vocabulary in June: **zero** — not one guarantee, not one proof, not one enforce in the entire month. The operator was running two grant campaigns through other deployments. The machinery idled: the [agency] automation persisted in configuration, but the record shows no evolution cycles, no FLIP storms, no verify bursts.

Then June 2: "harden service recovery after **corrupt runtime state**" — the first commit to name corruption as a fact of life. June 16: the cargo package renamed from workgraph to worksgood. June 18: the daemon at the old checkout began logging "Failed to load graph" on thousands of consecutive ticks. The graph, and with it the January–June task ledger and its archive, was gone — clobbered during a period when the code's own graph saves were non-atomic. The machinery survived the death of its host by being rebuilt: July 4, the coordination graph recreated from scratch, and the new [agency] configuration switched on with the automation wide open.

### IV. Adulthood: the configuration of July 4

The July 4 configuration (quarantine series, `config.toml.2026-07-04T15-31-36Z`) is the machinery's full portrait, every knob exposed:

> `auto_assign = true` · `auto_evaluate = true` · `flip_enabled = true` · `auto_rescue_on_eval_fail = true` · `eval_gate_threshold = 0.7` · `gate_confidence_threshold = 0.7` · `gate_max_attempts = 2` · `gate_uncertain_policy = "escalate"` · `evolution_budget = 5` · `evolution_interval = 7200` · `bizarre_ideation_interval = 10` · `novelty_bonus_multiplier = 1.5` · `ucb_exploration_constant = 1.4142135623730951`

with four named agent-identities (assigner, creator, evaluator, evolver) as blake3 content hashes. Uncertainty flag: the pre-July-4 configuration of the old graph is not preserved anywhere we have found, so how much of this block predates the cutover is unrecorded.

This is the configuration the paper calls the *enforcement autonomy*: gates that admitted, escalated, rescued, and evaluated without a human decision. In its first week it lived through the provider churn (seven route changes, OpenRouter keyring adoption, the arrival of gpt-5.6-sol) — and by July 11, the automation had been walked back: `auto_assign = false`, `auto_evaluate = false`. By July 25 the block had churned again (`auto_evaluate = true` restored; the agent-identity hashes deleted from config). The knobs turned throughout the month; the constraint census records 43–46 births in July against 1–4 removals.

July also produced the machinery's strangest crop: the verify-timeout experiment matrix — 76 tasks dispatched to test the verification system itself, mass-abandoned mid-month. The machinery testing itself until the testing broke.

### V. The occupation of August

August began with the machinery's own housekeeping misfiring: on August 1, the daemon "held overdue automatic archival" — mass-archiving tasks on startup, unbidden. The agents held it and made archival opt-in on August 2. On August 3 they built atomic graph saves with rescue-checkpointing — scar tissue from June's corruption. On August 5, disk exhaustion triggered the atomic quarantine of the entire damaged graph (recovery tag: `recovery/overengineered-cutover-20260805`), and on August 7 the working repo was re-cloned from GitHub — the same day came the first retirement: "Retire legacy FLIP routing integration tests."

The retirement commit is modest — two files, five lines, a baseline report — but it is the first time in the organization's life that a governance artifact died by intent rather than by cutover. The census's removal vocabulary had been extinct since April.

### VI. Demobilization (September 13)

The September 13 configuration change — the operator's hand, co-designed in the coordinator channel ("all these hardcore checks are hardcore and gummy") — did not delete the machinery. The census is precise: **`auto_evaluate` flipped true→false; `verify_autospawn_enabled = false`; gates were demobilized, one decision away from re-armament.** Constraint existence and enforcement autonomy, the record now shows, were separate control surfaces all along.

What followed is the strangest entry in the biography. The constraint birth rate did not fall — September records 45 births, nearly matching August's 46, most of them verify/prove-gated tasks around Pi route hardening and opaque execution. The machinery's *language* redirected rather than retired: guarantee-language density, which ran 85.9 per 100 commits in April and collapsed to 8.1 in June, returned to 61.6 in September — but September's words are *prove, exact, baseline, reconcile*. The same care, re-pointed from gating the work to proving the substrate. And on September 14, the organization wrote down its new constitution: "docs: define reliable-work operating principles."

### VII. Dismantling (September 14–18)

Then the retirement arc, at last: September 4, "make retired evaluation rows non-authoritative" (the cutover the record calls `harden-retired-evaluation-cutover`); September 16, "retire the WG model registry — Pi catalog is the single model source of truth" (governance externalized to the host harness); and through it all, FLIP itself was not killed but *domesticated* — September 18's final entry in this window: "operator-framing docs + concierge framing print + FLIP glossary." The machinery's last act was to explain itself to humans.

---

### Obituary

Here lies the governance machinery of wg: the Agency (February 6), FLIP (March 3), and the verify gates (April 11) — born to prevent failures, grown to 312 constraint topics on the fuel of those failures, never once effective at dying.

In life it carried a retirement strategy in its own source code, behind a test-only guard, guarded further by a rule that nothing under-tested could ever be retired — and evaluation was the first thing the burden broke.

It was not killed. It was demobilized by hand on September 13, its care redirected to proving the substrate, its surviving members explained in a glossary.

Cause of death, as recorded: the operator, with a configuration edit.

Survived by: atomic saves, a concierge, and a written constitution.

---

*Uncertainties flagged: (1) the pre-July-4 configuration of the original graph is unrecorded, so which [agency] knobs predate the cutover is unknown; (2) whether evolution cycles ever ran autonomously in production (evolution_budget 5 per 7200s cycle) is not directly evidenced in the artifacts examined — the config enabled the machinery, but we found no receipt of an autonomous evolution batch; (3) retirement existed in two non-operational layers: the deterministic threshold logic (`roles_below_threshold`) is `#[cfg(test)]`-only — its only complete implementation is test code — while the LLM-side capability existed solely as a prompt component ("retirement-identification") in the evolver's role description, with no receipt found of it ever being exercised; (4) the census's 312-topic count is an upper bound (suffix clustering over-fragments; 164 high-confidence, 148 medium).*
