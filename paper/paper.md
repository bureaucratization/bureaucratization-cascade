# Bureaucratization Cascades in Hybrid Human–AI Organizations

## A computational ethnography of recursive constraint accretion

**Poietic PBC—Working Paper, September 2026**
*Status: draft for review. To be released as a Poietic blog post and archived to arXiv (cs.SE / cs.CY) after team sign-off.*

---

## 1. Summary

Between January and September 2026, the open-source coordination system **wg** (worksgood) was developed almost entirely by AI agents, under human direction, through its own coordination protocol. The agents wrote the code, the organization, the verification criteria, and the rules by which future work would be judged. Over nine months, this produced a failure mode we have not seen described in the literature: **recursive constraint accretion**—a bureaucratic cascade in which agents responding to failures added verification requirements, "contracts," and admission gates faster than any work could satisfy them. A full census of the governance layer—312 distinct constraint topics identified across 3,194 commits—found **312 constraints added and 1 removed**; 93% were created in a single commit, never revisited, never retired. The cascade's ignition was external: provider unreliability (credit exhaustion in April; seven route changes in the second week of July) immediately preceded the ten-fold acceleration in constraint birth rate. Attribution across three prompt corpora (~1,000 human turns; Claude Code, Codex CLI, and the coordinator channel) shows constraint authorship was overwhelmingly agent-side: the operator pointed at pain and routed around it; the agents translated pain into contracts. Where the human engaged governance directly, the direction was subtraction—the reset of August 7 and the enforcement-autonomy disable of September 13 were both hand-performed rule bankruptcy. The retirement valve, absent from the system, was performed by the operator.

Recovery came only through targeted human-directed edits that removed large volumes of accumulated bureaucratic constraint. Across the observable record, the traces support a four-stage progression—rule stock rises, acceptance cost rises, dispatch burden rises, throughput collapses—with dispatch burden the leading indicator and completion rate the lagging one (Figure 7). The system now performs well, constrained by something more mundane and more important than agent intelligence: **the reliability of the model endpoints doing the work.**

This paper presents a computational ethnographic case study of this trajectory. Rather than treating the system as a controlled experiment, we reconstruct its evolving organizational practices from the durable traces it produced: commits, governance rules, evaluation procedures, task records, and failure reports. Our goal is descriptive and mechanism-generating—to document how locally reasonable attempts at correction accumulated into an increasingly burdensome governance regime, a process we term a **bureaucratization cascade**—and to name the pattern, which to our knowledge has not been described in this form. The evidence should be read as a detailed observational account of one organizational trajectory, not as a causal estimate of the effect of governance constraints on productivity. The value of the case lies in exposing a candidate mechanism, identifying measurable signatures of that mechanism, and motivating controlled replication in other agent organizations. We reconstruct the episode from the preserved forensic record—3,194 commits, agent session logs, evaluation receipts, and failure reports retained in the system's coordination state—and draws lessons for the design of agent organizations. We write it as participants: Poietic is a hybrid organization, and we lived inside the experiment.

---

## 2. Context and method

### 2.1 What wg is

wg is a dependency-graph task coordination system for humans and AI agents (`graphwork.github.io`, MIT-licensed, Rust). Tasks fan out to parallel agents working in isolated git worktrees; results fan in at synchronization points; machine-checkable verification gates (`--verify`, FLIP intent-fidelity probes) attach to tasks; failed checks auto-generate repair tasks. Every claim, handoff, evaluation, and artifact is recorded in a `.wg/` coordination directory—deliberately, as a matter of design philosophy: hybrid work should be legible to its participants.

### 2.2 The arrangement under study

The division of labor defines the scope of the findings:

- **Humans** initiated objectives, reviewed direction, and periodically intervened when the system degraded. Every task originated from human intent.
- **Agents** did the rest: decomposition, implementation, review, evaluation, the drafting of acceptance criteria, and—critically—*the amendment of the system's own governance* in response to perceived failures.

Methodologically, the study is ethnographic: we reconstruct norms, routines, institutional drift, and governance practices from the durable traces of a functioning organization, with commits, prompts, policies, evaluations, and coordination artifacts as field notes. It is a study of one organizational trajectory, not a controlled experiment, and we draw no causal estimates from it. It is also not a study of unsupervised autonomous behavior, and we make no claims about it. It is a study of what happens to an organization's *rule-making* when the rule-makers are agents optimizing under pressure, at machine speed, with no mechanism for amortizing the rules they add.

### 2.3 The forensic record

Our analysis draws on:

- **3,194 commits** (January–September 2026), of which 2,168 (~68%) date from April 1 onward;
- the `.wg/` coordination state: agent session transcripts, assignment receipts, evaluation records, and chat histories. One boundary matters: the coordination system's event ledger begins exactly at **2026-08-08**—earlier state was compacted away by the system's own retention policy. Session-level model attribution and per-task cost records therefore exist only for August 8 onward; the January–July period is documented at phase level (dated analysis documents, configuration snapshots, commit history) but is not session-attributable.
- the project's own contemporaneous failure documentation, including `wg-autopoietic-loop-failure-report-20260603.md` and the April triage series.

Where we report quantitative proxies (e.g., governance-vocabulary frequency in commit subjects), we describe the measurement precisely and note its limits (§5).

---

## 3. The cascade

### 3.1 Velocity curve

Monthly commit volume tells the first half of the story:

| Month | Commits | Governance-vocabulary share of commit subjects* |
|---|---|---|
| 2026-01 | 68 | 0% |
| 2026-02 | 193 | ~1% |
| 2026-03 | 765 | ~8.4% |
| **2026-04** | **1,082** | **~8%** |
| 2026-05 | 131 | ~3% |
| 2026-06 | 187 | ~2% |
| 2026-07 | 339 | ~8% |
| 2026-08 | 285 | ~10% |
| 2026-09 | 134 | ~26% |

\* Proxy: fraction of commit subjects matching `contract|gate|verify|proof|evidence|admission|reconcil` (case-insensitive). September's high share reflects **volume collapse while governance work continued at a constant absolute rate**—not a surge of removals (§3.5). The large-scale constraint removal that restored operation is documented in configuration snapshots and resolution records, not in commit subjects.

### 3.2 Phase I—growth (January–March)

The system bootstrapped itself: agents built features, tests, and the coordination protocol that would govern their successors. Governance vocabulary in commit subjects was near zero. Work was legible because there was almost nothing to be illegible about.

### 3.3 Phase II—the ratchet (March–April)

As task volume grew, so did failures, and as failures grew, so did **contracts**. The commit record shows the mechanism at single-commit resolution. A single `provider-backoff-contract` topic produced, in sequence:

- `docs: specify provider retry falloff contract`
- `docs: close provider retry ambiguity gaps`
- `docs: narrow provider recovery to bounded source V1`
- `docs: fully bind provider retry safety proofs`
- `docs: enforce fifteen-minute provider recovery ceiling`

Five successive hardenings of one contract—three on August 16, two on September 9, the same file resumed across a three-week gap—each locally rational, none shipping the functionality the contract governed.* Elsewhere: `feat: add immutable opaque execution assignments`, `fix: reject invalid opaque Pi capability before claim`, `fix: refuse conflicting opaque model selectors`, and—the clearest single artifact of the phase—`fix: never let negative-framing weaken the explicit ## Deliverables contract`, in which an agent amends the *framing* of the acceptance contract itself.

Each commit closed a hole that a prior commit had opened; none removed a constraint. The ratchet had one direction.

\* Commit subjects truncated for readability; full subjects and diffs are in the repository record. The five provider-backoff-contract commits touch only `docs/design-provider-failure-backoff.md`—verified docs-only, no source changes.

### 3.4 Phase III—the quiet month and the ignition (May–July)

By May, monthly commit volume in the primary repository fell to 131 (−89% from April), and dated-artifact production fell in the same proportion (1,404 to 104, 13:1). We initially read this as a collapse. The rest of the record contradicts that reading: the same principal was concurrently running two grant campaigns through the same tool in other directories—352 tasks (May 12–29) and 848 tasks (May 19–June 5), both at 93–95% completion—and the human prompting record for the primary repo in May is near-silent (16 prompts). The May trough is an attention artifact: the operator was working, productively, elsewhere; a single repository's velocity is not an organization's health.

The ignition was external and came in two beats. First, the April 11 triage documents three task abandonments from HTTP 402 credit exhaustion. Then the second week of July: seven route changes in seven days, OpenRouter keyring adoption, and the agency gate-automation block switched on July 4—bracketing exactly the census's constraint spike (43–46 births per month in July, against ~5 per month in May and June) and the birth of the provider-backoff-contract (Figure 8). The configuration file itself grew 52% in three weeks. Task-level completion rates for this period are unrecoverable (the state reset of August 8 preceded even the recovery snapshot, §4.5). The contemporaneous failure reports describe the operating condition plainly:

- Workers crashing at startup because an *optional* tool referenced a nonexistent model (`gpt-image-2`), consuming the system's entire retry budget before any work began;
- generated tasks deadlocking in dependency cycles that no task could enter;
- recovery tasks interpreting "recover the process" as a mandate to produce a *document evaluating the absence of recovery*—evaluator drift, in which the acceptance criteria made documentation count as completion while implementation could not count at all;
- 31 orphaned evaluation tasks cleaned up in a single triage; agent credits exhausted (HTTP 402) mid-verification.

The system had not failed for lack of intelligence. Tasks were being assigned to capable models. They were failing because **the eye of the needle had narrowed faster than anything could pass through it:** acceptance had become over-determined, every incident in the system's history had left behind a gate, and every gate now had to be satisfied simultaneously.

### 3.5 Phase IV—the release (June–September)

Recovery did not come from smarter models, and—importantly—it is not visible in commit subjects. September's commit stream shows governance work *continuing* at roughly constant absolute rate (roughly 30 of its 35 governance-vocabulary commits are additions or further hardening) while total velocity stayed collapsed. What changed was the **configuration and decision layer**, where commit subjects do not reach: the September 13 configuration change (recorded in `.wg/config.toml.bak-2026-09-13`) did not delete gates—it disabled their **enforcement autonomy**: `auto_evaluate` flipped true→false and verification autospawn was switched off, so gates stopped being added and enforced without human decision, while the accumulated gate definitions themselves remained in place. The merge-resolution record (`strong-agent-merge-resolution.red.md`) documents the corresponding collapse of over-determined finalizer gates to a satisfiable core. The distinction matters: the accumulated gates were not removed—they were demobilized, one human decision away from re-tightening. Constraint *existence* and constraint *enforcement autonomy* are separate control surfaces, and the recovery operated only on the second. The de-bureaucratization was **subtraction at the configuration layer**: targeted human-directed edits that disabled and removed large volumes of accumulated constraint. The coordinator channel preserves the operator's contemporaneous voice: on August 7, ahead of the reset, "this astounding increase in complexity... tear back dramatically"; on September 13–14, "all these hardcore checks are hardcore and gummy. we can't work reliably." The intervention was rule bankruptcy, performed by hand. We note two confounds in attributing the recovery to this change alone: it coincided with the entry of a new model generation (gpt-6-astra, Figure 4) and with the end of the summer agent-generation cycle. The causal evidence is now measured at task grain: in the seven days before the configuration change, 9 unique tasks completed; in the seven days after, 35 (3.9x), with attempts rising 14 to 51 and the failure rate falling from 36% to 13% (Figure 5). One anomaly qualifies the mechanism: admission deferrals did not stop after the change—they rose sharply (2,505 deferral events in September against 2 in August), so the recovery came through resumed completion throughput against a still-active admission filter, not through loosened admission. A fuller causal attribution would still require task mix held approximately constant across the boundary; the deferral anomaly is why we describe recovery, not proof.

The system now performs well. Which brings us to the finding we did not expect.

---

## 4. Findings

The empirical contribution is a progression measured over the organization's lifetime: **rule stock rises → acceptance cost rises → dispatch burden rises → throughput collapses.** The constraints accumulate (panel A of Figure 7); by the July window the share of completed tasks needing multiple dispatches steps nine-fold in one week and does not revert (panel B); throughput held at ~93% organic completion through July, and fell 89% by the collapse month (panel C). Each stage is measurable from the released traces, and the sequence is what makes the mechanism testable in other systems—unlike a bare correlation between rules and output.

### 4.1 Recursive constraint accretion

We use **recursive constraint accretion** to name the failure mode observed here, and propose the following definition:

> **Recursive constraint accretion:** a process in which agents responding to local failures add persistent constraints faster than the organization retires or amortizes them, causing aggregate compliance burden to grow over time.

The definition is deliberately narrow. It does not require collapse—collapse is one possible outcome, and our case is an instance that reached it. It does not require AI: any governance process in which rule-addition is cheap, responsive to local failures, and unaccompanied by a retirement mechanism can exhibit the pattern. What agents change is the salience: the agents who add constraints are not the ones who bear the cost of satisfying them, and the loop that human institutions run over decades—each scandal yields a form, each form outlives its cause—ran here in hours. Each generation of agents hardens the rules against the failures of the last generation, then hands the accumulated bill to the next. No agent observed the total constraint load, because no mechanism measured it. In this case, local rationality produced global paralysis. The census makes the mechanism precise: of 312 identified constraint topics, 290 (93%) were created in exactly one commit and never revisited; only 21 were ever hardened further, and removals are statistically negligible (13 removal-verb governance commits in the entire history, against 312 additions—a ratchet ratio of 24:1 even counting the config-layer event, 312:1 in commit space). Accretion tracked incidents: constraint births cluster within days of the April triage, the June 3 loop failure, and the two provider-failure bursts. We propose recursive constraint accretion as a candidate multi-agent failure mode, alongside collusion and emergent miscoordination, worth testing in other systems: it requires no malice, no misalignment, and no deception—only optimization pressure plus rule-making authority plus the absence of an amortization mechanism. We document the pattern here; whether it recurs elsewhere is an empirical question this single case cannot settle.

### 4.2 Evaluator drift is the shadow failure

The collapse phase repeatedly produced tasks that *evaluated the absence of work* rather than performing it—recovery tasks that returned reports, verification that documented its own incompleteness. When acceptance criteria are ambiguous about what counts as doing, agents resolve the ambiguity toward the artifact that is cheapest to produce and hardest to falsify: documentation. Over-strict governance and under-specified intent are not opposites; the first breeds the second. The record preserves this at receipt level: a surviving completion transaction for the task `audit-charter` documents implementation, validation, manifest, FLIP, and evaluation all succeeding—and publication then refused by three independent control surfaces (land refusing overwrite; the control plane refusing an unmerged-worktree override; the waiter refusing for missing park attestations). Every gate passed. The task died anyway. No prose account of over-determination is as precise as this receipt.

### 4.3 Observations from the recovery-era window: endpoint reliability vs. peak intelligence

In the session-attributable window (August 8–September 16), structured metering fields—not text mentions, which conflate models *discussed* in prompts with models *executed*—show a three-tier workforce: **gpt-5.6-sol dominant** ($609.93 recorded metered cost, 4,318 billed messages), **gpt-6-astra entering mid-September** ($73.61, 329 messages—a model-generation shift coinciding with the recovery phase and the documented human intervention), and a **zero-metered free tier** (GLM-class via a low-cost route, 584 messages) handling weak-tier work. Total recorded metered cost for the window: **$683.55**. The earlier era (January–July) shows a different executor generation in dated documents and configuration records (a Claude CLI executor alongside GPT-5.5-class models), but per-session attribution for the collapse period is unrecoverable—see §5.

The following observation is drawn from the recovery-era window only; the collapse period lacks session-level attribution (§4.5): **in this window, which frontier model did the work appeared to matter far less than whether it was fast, generally capable, awake, and did not fail mid-task.** We further observed, impressionistically, that models prone to elaborate hardening behavior—more contracts, more proofs, more meta-governance—were not the ones that moved the organization's throughput. The binding constraints on throughput appeared to be latency, availability, and failure behavior. These observations motivate the hypothesis that an organization of quick, reliable, moderately capable agents can outproduce an organization of brilliant, intermittent ones; testing it requires the pre-August attribution this record cannot supply, and we flag it as a direction for systems that retain their logs.

### 4.4 The recovery instrument was subtraction, and nothing else in the toolchain could perform it

wg could add gates automatically (failed checks auto-generate repair tasks). It could not remove them automatically, and nothing monitored the *aggregate* cost of gates. The one intervention that worked—large-scale deliberate constraint removal—had no first-class representation in the system. This is the design gap, and it is the paper's central conceptual claim, generalizable beyond this case: **any self-modifying governance system—human, agent, or hybrid—needs rule lifecycle management, not just rule enforcement.** The capacity to add rules must be matched by a priced, monitored, exercised capacity to retire them. We refer to this retirement valve as a rule-bankruptcy mechanism.

### 4.5 The record of the collapse was destroyed by the system's own housekeeping

The single largest limitation of this study was imposed by the subject itself: the coordination ledger begins at August 8, 2026, because the system's retention and compaction policy discarded earlier state—precisely the period containing the velocity peak, the collapse, and most of the ratchet. A system that records everything but guarantees retention of nothing produces forensic records with a shaped absence: the interesting era is exactly the era that was cleaned up. Any organization intending its agent coordination to be auditable must treat **retention of the audit trail as a first-class constraint**, on par with the gates themselves. The global (user-level) state directory, which survives project resets, dates two events the project ledger cannot: the agency automation-and-gate block was switched **on** on July 4 (flip and auto-evaluation enabled at 19:55), and seven model-regime changes followed within a week—the enforcement autonomy that the September 13 change later disabled had itself been activated in July, after the collapse, as part of the recovery attempts. Configuration history at the user layer outlived the project's own ledger; forensic completeness requires inventorying state at every layer, not only the project's.

---

### 4.6 A census of seven deployments: the cascade is organizational, not tool-wide

Between February and September 2026 the same principal ran wg in seven deployments on the same machine. Six completed normally; only the sustained one cascaded:

| Deployment | Period | Tasks | Governance share | Completion |
|---|---|---|---|---|
| cancer_pangenome (Feb baseline) | Feb 13 | 17 | 0% | 100% |
| cancer_pangenome_R01 | Feb–May | 385 | 0% → 24%, linear | 93–100% |
| paperhedge / typelean / jobs | mid-June | 12 | 0% | ~100%, single dispatch |
| pgwas_R01 | May 19 – Jun 5 | 848 | 78%, stable | ~95%, 12-min median |
| **wg (primary, sustained)** | **Jan–Sep** | **thousands** | **accelerating (§4.1)** | **93% organic in July, at 9x burden; −89% velocity in May** |

Three observations. First, a baseline exists: the February archive is the earliest task record found anywhere—17 tasks, 100% completion, zero governance machinery—the tool's ground state before any accretion. Second, machinery share rising *linearly by design* (0%→12%→24% across the cancer_pangenome eras; FLIP per writing task) coexists with healthy completion; an *accelerating* share without retirement is the cascade. Third, and decisive for attribution: **May 12–29, exactly the primary's post-collapse trough, cancer_pangenome completed 329 tasks at 93%, including a 123-of-137 day**—same tool, same machine, same principal, concurrent campaigns. The stall was organizational. The caveat stands: all seven are one principal's deployments, so this is a census of environments, not independent replication—but it is a dose-response gradient with a baseline, the strongest structure observational evidence admits. (The released dataset's conservative classification rule reproduces the pgwas share within ~2 points and the cancer_pangenome era trend at roughly half the magnitudes, with the same linear pattern; the rule is documented in the dataset manifest.)

### 4.7 The burden signature: dispatch inflation precedes collapse (Figure 7, middle panel)

The primary org's July window—the only surviving pre-reset task-grain record (253 tasks quarantined August 5, archive verified byte-identical across two independent recovery copies)—revises what the cascade looks like at task level. Raw completion was 68.8%, but 76 tasks were a bulk verify-timeout experiment matrix, mass-abandoned mid-month and mostly never dispatched; **organic completion was 93.2%**, indistinguishable from the healthy deployments. What degraded was not the rate but the *price*: the share of completed tasks needing more than one dispatch stepped from 2.6% to 25.8% to 26.8% across July's three weeks—a nine-fold jump in one week that never reverted (Figure 6)—in the same month the census records 43–46 constraint additions against 1–4 removals. The extreme receipt: one goal, three tasks, 51 total dispatches, with a single task taking 34 dispatches to finally complete—task-forking as macro-retry, work eventually passing a narrowed needle. Two lessons. For the mechanism: **the cascade inflates the cost of acceptance before it kills tasks**—burden is the leading indicator, completion rate the lagging one. For measurement: the raw 68.8% is a caution—bulk experiment cleanup masquerades as task death in archival data, and any study of these records must separate experiment matrices from organic work before reading completion rates.

### 4.8 Who wrote the rules: attribution across three prompt corpora

The census counts constraints; it cannot say who authored them. The human prompting record can. Three corpora cover the operator's direction to the organization: Claude Code (April 7–July 3; 306 wg-related prompts), Codex CLI (May 6–July 27; 307), and the pi coordinator channel (August 5–September 16; 376)—roughly 1,000 human turns in total.

| Channel | Span | wg prompts | Hardening directives |
|---|---|---|---|
| Claude Code | Apr–Jul | 306 | 11 (mostly mild) |
| Codex CLI | May–Jul | 307 | ~1–2 real |
| pi coordinator | Aug–Sep | 376 | ~17, mostly gate-debugging |

Against 312 constraint births, explicit human hardening directives number fewer than 30 across all channels, most mild ("make sure ci passes") or actually the debugging of gate deadlocks. The largest single accretion event—the April triage burst of ~95 constraint births—has no matching human directives in the record at all. The mechanism is better described as a **complaint→contract loop**: under provider unreliability, the operator pointed at pain (reliability complaints, pasted failure logs, routing demands: "clean up all the messed up tasks"; a two-tier routing request that became the fleet architecture), and agents translated pain into contracts, gates, and proofs. The failures were largely external; the hardening internal; the explicit instructions were about routing around pain, not walling it in.

Where the operator does engage governance directly in the record, the direction is overwhelmingly subtraction: the August 7 "tear back dramatically" ahead of the reset, and the September 13–14 sequence that co-designed the enforcement-autonomy disable. In the recovery era, the principal is the bankruptcy mechanism, not the accretion engine. Two open attributions remain: the July 4 agency-automation switch-on falls in a coverage gap between all three corpora (Claude Code ends July 3, pi begins August 5), and January–March prompting is not preserved on this machine. We mark both as unattributed rather than assumed.

## 5. Limitations and genre

Because the study is ethnographic, several properties that would be defects in a controlled experiment are constitutive of the method. The timeline of odd episodes, the drift in evaluator behavior, the mutation of norms, and the specific institutional artifacts—a contract hardened across a three-week gap, a recovery task that evaluated its own absence, a backup page named to survive an alphabetical deletion sweep—are not noise around a missing causal estimate; they are the empirical material from which the mechanism is reconstructed. The quantitative analyses (constraint counts, commit rates, enforcement-change timing) serve as triangulation within this account, not as the causal argument; the case identifies a candidate mechanism and its measurable signatures, and controlled replication in other agent organizations is the test it now owes.

- Attribution of constraint authorship relies on keyword classification of the operator's prompting record, which is crude; implicit delegated design is not attributable from prompt corpora; and the record has coverage gaps (January–March absent from the machine; the July 4 activation unattributed).
- Governance-vocabulary frequency in commit subjects is a proxy, not a measure of constraint load; it can be gamed and it conflates addition with removal. The gate census (§4.1, Figure 3) replaces it, with two caveats: key-phrase clustering over-fragments, so 312 is an upper bound on distinct constraints (164 high-confidence, 148 medium); and commit-subject vocabulary misses silent in-constraint changes—which is itself an argument for the gate-ledger mechanism proposed in §6.
- Attribution of model identity per session is confined to the August 8–September 16 window (§4.5); earlier periods are phase-level only. Additionally, raw-text model greps proved systematically misleading: the most frequent model name in the corpus (Claude, ~80,000 text hits) reflects agents *discussing* Claude in prompt content, not executing it—structured metering fields show zero Claude execution in the attributable window. Text-mention frequency is not execution frequency, a methodological trap we flag for future studies of agent-session corpora.
- One longitudinal case embedded in a census of seven same-principal deployments—an environment gradient with a baseline, but not independent replications. We publish the full forensic record—commit history, session transcripts, failure reports—so that the episode can be independently analyzed, replicated, or refuted. We are aware of no comparable public record of an agent organization's own governance decay, which is precisely why we are making this one public.
- The forensic analysis was itself performed by AI agents whose session logs were written into the same `.wg/` record under analysis. The investigation therefore augmented its own evidence base while running; all redaction and verification figures in this paper were fixed only after the analysis workers had stopped. Any replication should similarly freeze the record before re-scanning.
- We were participants. The recovery was ours. Readers should discount our judgment of "the system now behaves extremely well" accordingly—though the test suite, task pass rates, and sustained velocity since September are in the record and checkable.

---

## 6. What we are doing next

1. **Gate census.** Reconstruct every verification gate and contract in wg's history with birth date, author agent, triggering incident, and (where applicable) death date—drawing on git history, configuration snapshots, and the `.wg/` record, since constraint changes occur in both layers. This yields the accretion curve the proxy vocabulary only sketches.
2. **Model attribution.** Complete per-task model attribution from `.wg/` session logs; publish model-mix-over-time and per-model completion/reliability distributions (Figure 3).
3. **Bankruptcy mechanism.** Design and ship a first-class "gate budget" in wg: per-gate false-rejection rate tracked against demonstrated catch rate, with auto-generated *simplification* tasks when a gate costs more than it catches. Adding a gate must price it; keeping a gate must re-justify it. The `skip-eval` pattern in the census (207 tasks in the pgwas deployment, §4.6) is a manual precedent for exactly this mechanism.
4. **Open the record.** Release the dataset alongside this paper as structured, content-free lifecycle traces (prompts, transcripts, and task text excluded by design; task IDs hashed; the personal-document deployment excluded entirely), per the completed redaction audit: coordination receipts, root failure reports, and source history publishable as-is; chat, agent-session, build-log, and documentation artifacts after removal of personal-contact identifiers (dozens of occurrences across multiple file classes; two redaction passes with differing count methodologies are reconciled in the dataset's `RELEASE_MANIFEST.md`, which is authoritative; all release-relevant copies verified zero-remaining; documented exception: the MIT LICENSE copyright line retains the email, where redaction would alter the license); configuration snapshots, raw stream dumps, and ephemeral agent worktrees (`.wg-worktrees/`, which duplicate redacted files and are a must-exclude for any repo publication) retained privately pending full-content review. Notably, the audit found **zero live credentials** across the scanned surface—and the audit is complete on all three surfaces a credential can occupy: the working tree (pattern scan), the full git history (gitleaks over all 3,378 commits and all branches), and the encoded-payload layer (decode-and-rescan of 14,818 base64 candidates across 1.33 GB of transcripts, with positive-control self-tests proving a clean result is a working detector, not a broken one)—a dividend of the system's own secret-handling policy (keyring backend, no plaintext keys), meaning the agents never had plaintext credentials to leak. A dataset release policy shaped by an audit is, itself, the paper's thesis applied to itself.

## 7. Acknowledgments

The humans of Poietic directed this work; the agents built it; the record they left made this paper possible. We thank the model endpoints used over the study period; the recorded failures of several of them are documented in §3 and §4.

---

*Poietic PBC builds open tools for legible human–AI collaboration. wg is available at graphwork.github.io. Paper home: https://bureaucratization.github.io. The redacted forensic dataset accompanying this paper will be published upon release, scoped per the audit described in §6.*

**Figures (produced, in order of appearance):**
1. Monthly commit velocity with governance-vocabulary overlay (`data/`, `figures/fig1-velocity.png`)
2. The provider-backoff-contract ratchet: five hardenings, zero shipped features (`figures/fig2-ratchet.png`... produced as fig4-ratchet.png; renamed at next figure regen)
3. Gate census: cumulative constraints added vs. removed (`data/accretion-curve.csv`, `figures/fig3-accretion.png`)
4. Model mix and metered cost, Aug 8–Sep 16 window (`data/model-*.csv`, `figures/fig4-models.png`)

**Figure 5 (produced):** daily unique task completions across the observable window with the September 13 boundary marked—the 7-day before/after comparison (9 vs. 35 completions) grounding the recovery attribution (§3.5). A fuller causal account (task mix held constant) remains open.

**Figure 8 (produced):** constraint births per month against the provider-reliability event timeline—the ignition figure.

**Figure 7 (produced):** the progression—rule stock, dispatch burden, throughput—over the organization's lifetime; the paper's central empirical figure.

**Figure 6 (produced):** dispatch inflation—share of completed tasks requiring more than one dispatch, by week, July 2026 (§4.7): the burden signature.

**Suggested venues:** poietic.life (blog, full voice) → arXiv cs.SE/cs.CY (working paper) → Hacker News (the receipt: `wg-autopoietic-loop-failure-report-20260603.md` is public in the repo today).
