# Chapter 1 — Bootstrap (January 18 – February 28, 2026)

*Every dated claim in this chapter comes from the wg commit log itself (`git log main`, Jan 18 – Feb 28, 2026, 258 commits). Quotes are verbatim from commit subjects or bodies, trimmed to 200 characters.*

## Day zero, twice

The repository's first three commits land on **January 18, 2026**, and they are a project in miniature:

1. `0d06613d` — "Initial workgraph library with core types, parser, queries, and checks"
2. `70064848` — "Add CLI with init, add, done, ready, blocked, check, list, graph, cost"
3. `8b4b523c` — "Add research documentation and project notes"

A library, a CLI, and notes — by a human author (Erik Garrison; all 192 commits in this window are his). The next day comes the commit that makes the project unlike any other in the record: **`56e1ae70` — "Bootstrap workgraph with its own development tasks + Claude skill."** The commit body states it without decoration: *"Self-hosting: workgraph now tracks its own development roadmap."* The same day adds `7a86766e` — "Add CLAUDE.md with workgraph agent protocol" — the first constitution: a written protocol for how agents would enter and work in the repository.

So day two is the day the tool began tracking its own construction. Every subsequent commit in the record is the system developing itself, under one human's direction.

## The first week: a CLI grows a vision (Jan 19–24)

January 19 is a burst of fourteen commits — analysis commands in three phases, timestamp scheduling, a `plan` command ("wg plan --budget X --hours Y"), a `coordinate` command for parallel dispatch, claim/unclaim commands for agent coordination, resource and actor commands, and the first research documents ("Add human interface research document," "Add human summoning and TUI design research"). The pattern established on day two — build the tool, then write the research note — is already visible.

January 20 delivers two structural decisions in a single day: `324fc5b0` — "Rename binary from 'workgraph' to 'wg'" — the binary's name shortens three weeks before the package itself would (June's rename is prefigured here); and `13685266` — "Design workgraph path to autonomous agents" — the roadmap document that the following days execute.

January 21–24 is a deliberate construction sequence, each commit a named layer:

- Jan 21: "Implement Layer 0: foundation tasks"; "Implement Layer 1: task metadata and failure handling"
- Jan 23: "Implement agent-identity: capabilities, trust levels, matching"; "Implement context-inheritance: artifacts and context flow"; "Implement agent-architecture: autonomous work loop support"
- Jan 24: "Implement trajectory-claiming: context-efficient task chains"; "Implement execution-model: coordination-only with exec helper"; and finally — with a celebratory emoji, the only one in the early record — **"Implement autonomous-runtime: the goal task! 🎉"**

In seven days the project goes from three commits to an autonomous runtime. The "goal task" — a task whose purpose is to spawn and coordinate further tasks — is the seed of everything that follows: the June swarms, the July burden, the September constitution all descend from this commit's idea.

## Late January: the agent loop closes (Jan 26 – Feb 3)

After the runtime lands, the record pauses (no commits Jan 25–30) and resumes with infrastructure for the agents who will use it: spawn prompt fixes, model selection, coordinator detection of finished agents (Jan 31); then the first **verification workflow** (Feb 1: "Add verification workflow for tasks," "Add wrapper script to auto-complete tasks when agents exit"). The first governance — a verification step — arrives three weeks in, gently.

February 2 is a consolidation day: the coordinator merges into the service daemon with event-driven task pickup; the interactive TUI dashboard lands (`wg tui`); service daemon logging and hot-reload arrive. And one quiet commit with long consequences: **"Stop tracking workgraph runtime state files"** — the runtime state leaves git's view on February 2, four months before the state's own survival becomes the story's crisis.

February 3 adds the matrix-lite Matrix client (the first communication substrate), a DAG layout engine, `wg quickstart`/`wg status`, and the first skill-install command. February 6 closes the month's arc with two commits that define the next phase: "Make wg init add .workgraph to .gitignore" (the state directory officially becomes untracked — a decision whose costs arrive in §4.5 of the paper) and **"Implement Agency system: evolutionary agent identities for workgraph"** — the first appearance of the word *agency* in the record.

## February: audits, ADRs, and the org-eval experiment (Feb 6–28)

Mid-February is dominated by audit cycles: fourteen consecutive "Audit cycle cleanup/fixes" commits (Feb 14–15), addressing clippy warnings, dead code, error handling, Unicode truncation, shell escaping, atomic saves — "add validation, atomic saves, better diagnostics" appears on **Feb 15**, nearly five months before atomic saves would be rebuilt as a response to the June graph loss. The hygiene instinct was present from the start; it simply was not a mechanism.

The late-February record is an explosion of ambition: 114 commits in the final two weeks of the month. February 24–26 brings ASCII DAG visualization with box-drawing characters, a TUI search UX, token usage display with "in/out/val slash notation," a four-layer LLM test suite ("snapshots, contracts, mock executor, Haiku smoke"), typst documentation conversion, and `57489e2a` — "wg setup auto-installs skill/bundle for chosen executor" — the first executor-choice plumbing.

Then the agency experiment goes vertical. February 26–27 delivers, in order: "agency system overhaul, TUI viz viewer, service hardening"; "propagate evaluations to role components"; "unified evaluation with org dimensions"; a CLAUDE.md directive — "Task tool prohibition, orchestrating agent role"; and on February 27 alone: "compose special agents at agency init," "proper scoring rules and rubric spectrum for evaluations," "autopoietic task generation with guardrails," "agency audit, gc/link/tradeoff/create commands, exec_mode," and "coordinator org-eval, assigner evaluation, agency create command."

The vocabulary shift is the story of the fortnight: by February 27 the record speaks of *evolutionary agent identities, org-evaluations, assigner scoring, rubric spectra, tradeoffs, and autopoietic task generation*. The tool is no longer a task graph; it is becoming an **evolutionary agent organization** — with scoring rules, special agents composed at init, and evaluation recorded "against special agent entity." One commit on Feb 27 — "refactor: remove org-eval infrastructure" — suggests the first experiment was already being torn out the day after its biggest expansion: the accrete-and-remove cycle, present in miniature from the very first month, at a scale of days rather than months.

The window closes (Feb 28) with improvement-loop commits — "improvement-loop-1: extract evolve module... clean dead code" through "improvement-loop-3: split spawn/main modules" — the first recorded *improvement loops*, an explicit self-improvement pattern that foreshadows the June autopoietic loop and its failure report.

## The first 30 days

- **Jan 18:** library, CLI, notes. **Jan 19:** self-hosting begins; the agent protocol written.
- **Jan 21–24:** layered construction to an autonomous runtime with a "goal task."
- **Jan 31–Feb 6:** the agent loop closes (spawn, verify, daemon, TUI), the state leaves git, and the **Agency system** appears.
- **Feb 14–15:** fourteen audit-cycle hygiene commits — including the first "atomic saves."
- **Feb 24–28:** visualization, four-layer LLM tests, executor-choice setup, and the org-eval/agency explosion — with its first same-week teardown.

The cast is one human (all 192 commits authored by Erik Garrison) and, from late February, an expanding population of special agents with component-based identities and scoring rubrics. The governance count at window's end is small — the accretion has not begun in earnest — but three of its future ingredients are already committed to the record: verification workflows (Feb 1), the Agency system (Feb 6), and autopoietic task generation (Feb 27). The needle exists on day two. It will take five months to close.

### Timeline — Chapter 1

- **Jan 18:** workgraph born — library, CLI, notes (first 3 commits)
- **Jan 19:** self-hosting: the tool tracks its own roadmap; agent protocol written
- **Jan 24:** "Implement autonomous-runtime: the goal task! 🎉" — the autonomous runtime lands
- **Feb 6:** Agency system (evolutionary agent identities); `.workgraph` added to `.gitignore`
- **Feb 26–28:** org-eval/agency explosion, autopoietic task generation; first same-week teardown; 258 commits in the window
