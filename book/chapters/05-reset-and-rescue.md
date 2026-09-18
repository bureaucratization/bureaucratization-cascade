# Chapter 5 — Reset and Rescue (August 5–12, 2026)

*The week the organization was relocated, re-cloned, re-founded — and audited itself to a constitution.*

---

By August 5, the machinery had eaten the graph. The coordination state that had been quarantined that morning — 824 tasks, the accreted rulebook, months of attempt records — was damaged beyond in-place repair, its own recovery directory littered with the week's failures: `dispatch-cutover-disk-exhaustion`, `terminal-rewrite-loop`, `planner-schema5-bootstrap`. Disk exhaustion, save corruption, planner bootstrap failures — the substrate itself was failing, and the governance layer had grown too dense to survive on it. The quarantine note said what it was: a damaged historical graph, relocated atomically, do not run.

What followed was not one rescue but three, layered over four days: a teardown, an audit, and a refounding — each with its own record.

## The teardown day

August 7 is the densest deletion in the repository's history. The commit subjects from that single day read like a demolition order executed by a crew that knew exactly which walls to drop:

- "Delete evaluator reconciliation status authority"
- "Delete completion-side validation authorities"
- "Quarantine legacy completion through lifecycle"
- "Delete evaluator-driven retry authority"
- "Remove dormant evaluator repair controller"
- "Retire legacy FLIP routing integration tests"
- "Merge simplified lifecycle control plane"

Forty-seven commits landed on August 7 alone (159 across August 5–7), and their verbs are overwhelmingly subtractive — *delete, retire, quarantine, remove, drop, prune*. This was the enforcement-autonomy disable of September 13 in its first, cruder form: days before the config-level change the recovery narrative remembers, the organization was already tearing out the machinery that added and enforced gates without a human decision. The "simplified lifecycle control plane" that replaced it is the ancestor of everything that works today.

## The audit paradox

Then, in the middle of the teardown, the organization did something that looks contradictory until you understand what it had learned: it audited itself. Between August 7 and 9, 76 commits carry "audit" in their subject. The result was a fourteen-part system audit — code architecture, orchestration lifecycle, model execution plane, agency-evaluation, federation and security, documentation, testing — plus a synthesis, an independent review of the synthesis, a calibration of the review's evidence, and a "cross-audit contradiction, drift, and uncertainty register."

The register is a remarkable document. Written by agents about their own organization, dated August 8, it deduplicates "repeated IDs for the same underlying conflict" across fourteen audits and records, in its own labels, the drift that had accumulated: `wg done --help` still advertising five legacy flags while the code rejected them; review/evaluation prose describing "ratified or complete enforcement" where the implementation "provides a narrower spark"; point-in-time designs "preserved correctly but lack status, applicability, and supersession edges." The organization had learned to write its own contradiction register — the exact artifact a bureaucracy needs and almost never produces.

## The rescue manifesto

On August 9 at 08:00, the operator committed the document that anchors the whole week: **"Simple Local WG Recovery Work Document"** (357 lines, branch `rescue/simple-local-wg`, status "ACTIVE — operator recovery; WG dispatch is stopped"). It is the clearest statement in the entire record of what the system had become and what it was supposed to be.

The mission section restores, in seven numbered lines, the original contract: "A user asks for work. Chat creates a task graph. Trusted local workers fan out and coordinate freely through that graph... Tasks become Done without hidden controller deadlocks or manual object-store surgery." And it names the intervention precisely: "This is a **semantic rollback**, not a blind historical Git revert" — keep worktree isolation, attribution, fencing, immutable evidence, accounting; remove "default permission and completion machinery that prevents trusted local work."

Then the evidence section lists, with dates and counts, the disease as observed during the August 8–9 audit run:

- "The trust-first fix passed its substantive validation, then accumulated at least 10 consecutive FLIP rejections," expanding to 15 commits and ~3,653 inserted lines "including new 'seal' and 'fail closed' controls contrary to the requested simplification."
- "The build-admission fix initially passed build, format, clippy, targeted tests, install, and owned smokes, then accumulated at least 20 review rejections and expanded to 28 commits and approximately 1,628 inserted lines."
- A malformed capability path "prevented a dead worker from even recording its own failure."
- The documented escape hatch `wg done --skip-verify --skip-smoke` was itself "rejected with legacy wg done bypass/merge/cycle flags are not supported by publication-derived completion."

The sentence that summarizes the whole chapter is the document's own diagnosis: **"These are control-plane failures, not failures of the requested source, audit, or scientific work."** The accretion was fighting the rescue in real time — the requested *simplification* was being expanded by review machinery into new seals and fail-closed controls, exactly as the census predicted a rulebook under incident pressure would behave. A "non-negotiable target contract" section then deletes by name: no model reviewer "with unbounded source-task blocking authority," no mandatory quality-pass dependency, no hidden build concurrency limits, no infrastructure outage classified as scientific failure.

## The unmerged survivors

The rescue produced work that never fully reached main. A scan of all 56 local branches finds seven with commits main does not contain: `wg/agent-23/restore-trust-first-local-worker-control` (15 commits), `wg/agent-24/fix-build-admission-default-ui` (28), `wg/agent-41/completion-classification-precedence` (23), `wg/agent-43/completion-review-candidate-budget` (13), and three smaller ones — 87 unmerged commits in total, all from the rescue fortnight. The August 9 recovery bundle preserves them (`preserved-refs.bundle`, with `rescue/simple-local-wg` and `main` pointing at the same commit, `e12ee37c`), which is why this chapter can be written at all: the rescue was reflog-fragile — the reflog shows repeated `reset: moving to ...` entries through August 9–10, including three in the early hours of August 10 — and the bundle is what made the branch state durable.

Whether the unmerged 87 were superseded, abandoned, or simply left behind is not determinable from the refs alone; they are flagged here as the record's one open drawer.

## The new order

By August 10, the replacement order was writing itself down. "Receipt-backed scored evaluation" defines what an evaluator is now allowed to be: "deliberately narrower than task completion," observation and findings only, one bounded call, "no task status, lifecycle, retry, publication, or graph node can be changed" — evaluators demoted from authorities to witnesses. The same day, "record stigmergic loop validation" closes the loop on the term this book has used throughout: the organization validated that its coordination now worked by stigmergy — traces in the environment, not commands in a hierarchy.

The cast for the week: agents 21–43 and the audit fleet; the operator, present in every rescue document as "repository operator"; and the daemon, finally loading a graph it could serve.

## Timeline

- **Aug 5, 18:41** — damaged graph atomically quarantined ("overengineered-cutover"); disk-exhaustion recovery capture same day
- **Aug 7** — 47-commit teardown day: evaluator authorities deleted, FLIP routing retired, simplified lifecycle control plane merged
- **Aug 8** — fourteen-part system audit + contradiction register published; `wg done` escape hatch found rejected by the machinery
- **Aug 9, 08:00** — operator's rescue manifesto committed; semantic rollback declared; 76 audit-adjacent commits total across the run
- **Aug 10** — scored evaluation demoted to observation-only; stigmergic loop validated; repeated reflog resets end; the new order holds

---

*Uncertainties flagged: individual commit authorship within the rescue (operator versus agents) is not distinguishable from commit metadata alone; the disposition of the 87 unmerged branch commits is unknown; the precise cause of the August 8 reflog resets (three before 03:00) is unrecorded.*
