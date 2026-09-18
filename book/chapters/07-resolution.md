# Chapter 7 — Resolution and Constitution (September 13–18, 2026)

*The Book of WG, chapter 7. Sources: git log on main (2026-09-13 through HEAD), the `.wg/config.toml.bak-2026-09-13T02-32-08Z` snapshot, the current live configuration, the coordinator chat record, and `docs/reliable-work-guiding-principles.md` (b025694e).*

---

## The night of September 13

The intervention began at 04:32 local time — the configuration snapshot `config.toml.bak-2026-09-13T02-32-08Z` was written at 02:32 UTC, which is 04:32 in the operator's timezone. The commit record knows nothing of this: the change was made entirely in the configuration layer, where git does not reach. What the config snapshot preserves is the moment the `[agency]` automation-and-gate block was demobilized — `auto_evaluate` and the autonomous evaluation loop switched off, `auto_assign` and `auto_create` disabled. The machinery that had been adding and enforcing constraints without a human decision was, from that moment, unable to act unbidden.

The coordinator chat record preserves the operator's contemporaneous voice from these hours: *"jfc FLIP is being an asshole... these hardcore checks are hardcore and gummy. we can't work reliably."* This is what rule bankruptcy looks like from the inside: late-night, exasperated, and entirely hand-performed.

## The morning after

At 08:54 on September 13, the first commit lands: `fix: refresh exact cargo baseline admission` (fc2c9ddd). Then a tight sequence over the following hour:

- 09:13 — `test: exercise production baseline publication` (01e33c07)
- 09:22 — `fix: scope cold baseline fences by exact key` (1bcded95)
- 09:37 — `test: cover baseline failure recovery matrix` (a925f85f)
- 09:41 — `docs: record baseline admission reproduction` (5a0b28a6)

This is the recovery made visible at task grain: the seven-day window before the configuration change contained 9 unique task completions; the seven days after contained 35 — a 3.9× rise, with attempts rising from 14 to 51 and the failure rate falling from 36% to 13%. The morning-after commits are the repair of the *measurement apparatus itself*: baseline admission, baseline publication, the failure-recovery matrix. Before the organization could work again, it had to be able to see what "working" meant.

That afternoon brought two quieter commits — `Allow completion help after semantic rejection` (caee4aed) and `Persist completion repair saved-work locator` (cfeab43c) — both softening the acceptance edges that had been strangling completion: work that had been semantically rejected could now get help instead of dying.

## September 14: the constitution

The next day at 16:58, the organization wrote down how it intended to work. Commit b025694e — `docs: define reliable-work operating principles` — added 245 lines to `docs/reliable-work-guiding-principles.md`. It opens with what the document calls **the promise**:

> "Give WG a bounded piece of work. Receive an inspectable result or a precise request for a necessary decision. Work does not disappear, and the user does not have to repair the coordination machinery."

And then, the sentence that reads as a direct verdict on the preceding five months:

> "This is a work-coordination system, not a ceremony-enforcement system."

The constitution's first principle is "Make the ordinary path small": *Understand the task → do the work → check the result → repair if appropriate → finish or ask for help.* It explicitly warns against the pathology the census had measured: "A run that succeeds only after repeated manual retries, contract edits, or daemon restarts is not an autonomous success, even if the task eventually says Done." The July dispatch-inflation signature — 2.6% → 25.8% → 26.8% of completed tasks needing multiple dispatches — is here forbidden in principle. The document also draws the distinction the whole crisis had blurred: **coordination requests are not product acceptance criteria** — "a request for an early message must not become a requirement to prove the message's timestamp inside the candidate manifest."

The same evening, the repair continued: `fix: restore reliable baseline routing tests` (17:27) and `docs: record baseline failure diagnosis` (17:37).

## The redirected care

The semantic analysis of the commit corpus shows what happened to the organization's characteristic language. Guarantee-vocabulary density (never, enforce, reject, guarantee, must) ran at 85.9 per 100 commits in April — the accretion months — collapsed to 8.1 in June, and returned to 61.6 in September. But September's words are different words: *prove, exact, baseline, reconcile*. The same energy that had spent the summer walling work in was now spent proving the substrate: stable environment identity, deterministic validation evidence, hermetic tests.

The hardening did not die. It changed object — from gating the work to proving the ground it stood on.

## September 16: the great day of forward work

September 16 is the densest single day in the repository's post-crisis history — roughly forty commits in one day, and their subjects tell a story of an organization doing something it had not done since spring: **forward feature work, without the burden signature.**

The day's headliners:

- `feat: embed a live, read-only VizView work-graph panel in the wg-pi plugin` (a490d852) — the organization gained a live view of its own graph.
- `docs: design retiring the WG model registry in favor of Pi's models-store catalog` (277ef3ac, 460 lines) and its implementation the same night (`b5019738`, 23:13) — the WG model registry, a piece of in-organization governance, was **retired in favor of externalizing the function to the host harness**. The design document is authored by Erik Garrison directly; the milestone was executed the same evening.
- `feat: concierge-guided Pi readiness gates in attended interactive setup` (cea99615) — the new pattern for gates: attended, concierge-guided, operator-present. Gates by decision, not by emergence.
- `feat: reap orphaned descendant process groups on agent death` (60de44a8) — real infrastructure repair, the kind of work that had been impossible in the burden era.
- `test: make lib suite hermetic against cross-test env races` (a5ee70ce) and `test: pin completion-pipeline fixes with three credential-free smoke scenarios` (6eb90375) — the test suite hardened against its own environment, not against its own workers.
- `docs: npm distribution decision doc for WG binaries` (54fd6424) — thoughts of shipping, of users beyond the operator. The first sustained sign in months that the roadmap existed.

The day also shows the new normal's texture: opaque-Pi-execution trial reports with admission blocked by admin boundaries (c8928c2f, 3484fbd1 — trials run *under operator authority*, a phrase that would have been unnecessary in August), route-hardening batch synthesis with config-hygiene migration "flagged as not executed" (59d35b7f — work is now *deferred deliberately* rather than silently compounding), and a chore dropping migration backups from the repository (5e960d24 — hygiene).

## The ending, and what it cost

Two honest footnotes. First, the resolution was not instant: a test fix for cross-crate module paths (`fix E0433 in bin-crate test modules`) landed on September 18, two days after the constitution's implementation wave — the substrate was still being stabilized. Second, the cost: September's capacity went into teardown, baseline repair, and constitution-writing rather than the roadmap. Subtraction consumed the fall — the retirement valve was exercised by hand, late, and it was expensive. The constitution's own promise — *"the user does not have to repair the coordination machinery"* — describes a state that, as of HEAD, the organization had earned only by a month of exactly that repair.

## Timeline

- **2026-09-13, 04:32 local** — enforcement autonomy disabled in configuration (invisible to git; the intervention itself)
- **2026-09-13, 08:54–09:41** — the baseline sequence: five commits repairing the measurement apparatus
- **2026-09-14, 16:58** — the constitution: 245 lines of reliable-work operating principles (b025694e)
- **2026-09-16** — the great day of forward work: model registry retired, VizView panel, concierge-guided gates, process-group reaping, npm distribution (~40 commits)
- **2026-09-18** — last stabilization fix at chapter close (E0433 test modules)

**Where the org stands at HEAD:** the automation is off and stays off; the registry is externalized; the constitution is written and its promise is explicit; forward work is flowing again. The system that remains is smaller than the one that cascaded — and its constraint ledger, for the first time in the organization's history, is one that nobody is afraid to read.
