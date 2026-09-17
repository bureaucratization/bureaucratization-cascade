# Fact-Check Report: `wg-bureaucratization-cascade-DRAFT.md`

*Verified against `/home/bot/wg` git history and working tree, 2026-09-16. Verdicts: PASS / FAIL / CORRECTION.*

## A. Commit-hash claims

| # | Claim | Verdict | Evidence |
|---|---|---|---|
| A1 | `fc846d01` "fix: complete opaque Pi launch contract" | **PASS** | exact subject match |
| A2 | `65f993f4` "docs: specify provider retry falloff contract" | **PASS** (minor) | full subject is "...contract **(provider-backoff-contract)**"—draft truncates the suffix; harmless, note it |
| A3 | `754ff16b` "docs: close provider retry ambiguity gaps" | **PASS** (minor) | same suffix note |
| A4 | `677523fd` "docs: narrow provider recovery to bounded source V1" | **PASS** (minor) | same suffix note |
| A5 | `76a927f2` "docs: fully bind provider retry safety proofs" | **PASS** (minor) | same suffix note |
| A6 | `cb591d7a` "docs: enforce fifteen-minute provider recovery ceiling" | **PASS** (minor) | same suffix note |
| A7 | `cda3dc66` "fix: never let negative-framing weaken the explicit ## Deliverables contract" | **PASS** (minor) | full subject has "(pr54-round3)" suffix |
| A8 | `c260ef2b` "feat: add immutable opaque execution assignments" | **PASS** | exact match |
| A9 | `5a4b9f98` "fix: reject invalid opaque Pi capability before claim" | **PASS** (minor) | suffix "(fix-opaque-pi-negative-admission)" |
| A10 | `17fd9bf0` "fix: refuse conflicting opaque model selectors" | **PASS** | exact match |
| A11 | **CRITICAL: five provider-backoff commits are docs-only, none ship functionality** | **PASS** | `git show --stat` on all five: every one touches only `docs/design-provider-failure-backoff.md`. Diffs: +617; +80/−31; +702/−700; +127/−16; +1/−1. No `src/` changes anywhere. |
| A12 | five commits are "sequential hardenings of the same contract topic" | **PASS** (nuance) | same file, same topic ✓—but chronology clusters: 65f→754→76a on **2026-08-16**, then 6775→cb59 on **2026-09-09**. "Five successive hardenings" is accurate; "continuous spiral" would overstate. |

## B. Quantitative claims

| # | Claim (draft) | Recomputed | Verdict |
|---|---|---|---|
| B1 | Total 3,194 commits | 3,194 (`git rev-list --count HEAD`) | **PASS** |
| B2 | 2,170 commits since Apr 1 (~68%) | **2,168** (67.9%) | **CORRECTION**—2,170 → 2,168 |
| B3 | Jan 57 | **68** | **CORRECTION** (month-boundary bug in original query) |
| B4 | Feb 215 | **193** | **CORRECTION** |
| B5 | Mar 746, 8.0% | **765, 8.4%** | **CORRECTION** |
| B6 | Apr 1,089 peak, 8% | **1,082, 8.1%** | **CORRECTION** |
| B7 | May 128, 3% | **131, 3.1%** | **CORRECTION** |
| B8 | Jun 198, 2% | **187, 2.1%** | **CORRECTION** |
| B9 | Jul 339, 8% | **349, 7.7%** | **CORRECTION** |
| B10 | Aug 293, ~10% | **285, 9.8%** | **CORRECTION** |
| B11 | Sep 134, 35, ~26% | 134, 35, 26.1% | **PASS** |
| B12 | May collapse −88% | **−89.0%** (131 vs 1,082) | **CORRECTION**—"−88%" → "−89%" |
| B13 | "September's high share reflects the de-bureaucratization phase... removals rather than additions" | **NOT SUPPORTED** | See B13 analysis below |
| B14 | Monthly sums = total | 68+193+765+1082+131+187+349+285+134 = 3,194 | **PASS** (no out-of-window commits) |

**B13 analysis (important):** All 35 September governance-vocab commits were listed and categorized. ~30 are **addition/hardening** ("add opt-in managed process wake proof", "complete opaque Pi launch contract", "reject invalid... before claim", "capture... boundary", "preserve... evidence", the two provider-backoff docs commits). Only ~3–4 are removal/simplification (`bd1c4e1f` "separate optional completion evidence from gates", `bdca7830` "remove incidental message proof claim", arguably `677523fd` "narrow... to bounded source V1", `6fbd47c1` "bound completion review evidence in time"). The 26% share is explained by *volume collapse while governance work continued*, not by a removal surge. The draft's §3.5 framing and the table footnote must be revised: the de-bureaucratization the authors describe is real (per human testimony) but is **not visible in September commit subjects**—it likely lives in non-commit artifacts (e.g., `config.toml.bak-2026-09-13`, `strong-agent-merge-resolution.red.md`) or in commits not matching the vocab regex. The paper must either locate that evidence or soften the claim to "recovery coincided with reduced velocity; the removal work is documented in [X]".

## C. Failure-report and triage claims

| # | Claim | Verdict | Evidence |
|---|---|---|---|
| C1 | `wg-autopoietic-loop-failure-report-20260603.md` exists | **PASS** | present at repo root |
| C2 | gpt-image-2 startup failure documented | **PASS** | "The model 'gpt-image-2' does not exist." + `param: tools` (3 mentions) |
| C3 | "Cycle failure restart 1/3…3/3" quoted lines | **PASS** | exact strings present, verbatim |
| C4 | four c4-loop-* task names | **PASS** | all four present verbatim |
| C5 | deadlock cycle description | **PASS** | §"Dependency deadlock" lists the four-task cycle exactly as drafted |
| C6 | recovery task produced docs-only evaluation | **PASS** | "Evaluation evidence gathered: no task-scoped recovery artifacts… found" verbatim |
| C7 | FINAL_TRIAGE: 31 evaluation/FLIP tasks removed | **PASS** | "Orphaned evaluations: ✅ CLEANED (31 evaluation/FLIP tasks removed)" |
| C8 | FINAL_TRIAGE: 1558 tests passing | **PASS** | "1558 tests, 0 failures" |
| C9 | FINAL_TRIAGE: HTTP 402 credit exhaustion | **PASS** | 3 mentions (".flip-fix-ci-and: 402 credit exhaustion with minimax/minimax-m2.7", etc.) |
| C10 | FINAL_TRIAGE dated 2026-04-11 | **PASS** | "Completed: 2026-04-11 by document-final-triage (agent-15023)" |
| C11 | "TASC" appears nowhere except base64 noise | **PASS** | `grep -ril` across *.rs, *.md, *.toml (excl. target/.git): zero hits. Only jsonl hits are random base64 substrings (verified visually) |

## D. Structural claims

| # | Claim | Verdict | Evidence |
|---|---|---|---|
| D1 | website/ exists (graphwork.github.io) | **PASS** | `website/` present with assets, hero-snippet.html |
| D2 | LICENSE exists, MIT | **PASS** | "MIT License" first line |
| D3 | `.wg/` with agent session logs | **PASS** | 14G total; 1,144 files in `.wg/agents` (1.5G); pi-session jsonl transcripts confirmed |

## Required edits to the draft (numbered)

1. **§3.1 table:** replace all monthly counts/shares with corrected values: Jan 68/0.0%, Feb 193/1.0%, Mar 765/8.4%, Apr 1,082/8.1%, May 131/3.1%, Jun 187/2.1%, Jul 349/7.7%, Aug 285/9.8%, Sep 134/26.1%.
2. **§1 & §3.4:** "monthly commit volume peaked at 1,089" → **1,082**; "collapsed by 88%" → **"collapsed by 89%"**.
3. **§2.3:** "2,170 (~68%)" → **"2,168 (~68%)"**.
4. **§3.5 / Table footnote (B13):** revise or substantiate. Current text claims September's 26% reflects removals; the record shows ~85% of September governance commits are additions/hardening. Either (a) cite the actual removal evidence (config snapshots, merge-resolution docs) explicitly, or (b) reframe: "velocity collapsed and governance work continued at constant absolute rate, raising its share; the large-scale constraint removal that restored operation is documented in [artifact], not in commit subjects."
5. **§3.3 commit quotes:** append the actual suffixes or add a footnote "subjects truncated; full subjects in the repository record" (recommended: footnote, keeps prose readable).
6. **§3.3 "five successive hardenings":** add "(three on 2026-08-16, two on 2026-09-09)" or soften "in sequence"—the hardening is real but clustered in two bursts, not continuous.
7. Optional precision: B12 "−88.2%" → "−89.0%" wherever the collapse percentage appears.

**Summary: 24 PASS / 0 FAIL / 13 CORRECTION items (9 of which are the same month-boundary bug in one table).** Zero fabricated citations—every commit hash, quoted string, and document reference is genuine. Two substantive corrections: the collapse is −89% not −88% (trivial), and the September-removals interpretation (B13) is not supported by commit subjects and must be substantiated or reframed before publication.
