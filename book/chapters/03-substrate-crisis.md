# Chapter 3 — The Quiet and the Substrate Crisis
### May 1 – June 30, 2026 · 324 commits on main in the window (approximately 130 in May and 190 in June by author date — the paper's monthly table uses committer date and differs by a few commits — against April's 1,089)

## 3.1 The quiet

The primary repository went quiet in May. Not because the organization failed — because its operator was elsewhere. Two grant campaigns ran through *other* wg deployments on the same machine in exactly this window: *grant campaign B* (352 tasks, May 12–29, 93% completion, including a 123-of-137 day) and *grant campaign A* (848 tasks, May 19–June 5, ~95% completion). The tool was working; the operator was working; the primary repo simply received less attention. Later reconstruction would show the same pattern in the human prompt record: near-silence for the primary repo in May (16 prompts), against ~1,000 turns across the whole study.

This matters for everything that follows. May–June is *not* a collapse; it is the calm before the ignition — and, as it turned out, the period in which the organization's own record of itself died.

There is one more quiet-month record, and it closes the loop. The wg repository itself kept developing during this window — on the operator's laptop, through a separate wg deployment whose graph survived intact: **1,466 tasks created April–May at *declining* multi-dispatch (6.4%→3.1%)**, 90% completed with a real failure tail, and flat average dispatch (~0.85). The same development work, the same tool, the same operator — moved to another machine — ran healthy. The primary's problem was never the tool, the executor era, or the period. It was the primary's accumulated rulebook.

## 3.2 The executor zoo

The main technical story of May–June is not governance. It is **executor and model churn** — the systematic attempt to find a better way to run the agents. The commit record names at least four executor lineages in play, plus a menagerie of configuration templates:

- **`nex`** — a custom CLI/executor that dominated this window (~280 commits touching it), with its own streaming client, cursor handling, and OpenRouter endpoints: `nex-optional-openrouter-endpoint`, `nex-openrouter-default-ui`, `bench-nex-minimax-terminal`, `feat(tui): native executor now runs interactive wg nex REPL in PTY`.
- **`opencode`** — researched and exposed June 11–14 (`research-opencode-executors`, `expose-opencode-openrouter`, `fix-opencode-per-task-routing`).
- **`codex`** — the incumbent; still the daemon's declared executor in the death window (§3.5).
- **`pi`** — the newcomer whose migration sprint fills June 17–23 (`design-systematic-pi`, `implement-pi-plugin`, `fix-wg-pi`, `fix-pi-model`, `fix-pi-handler`, `design-handler-first`, and on June 22 the verdict commit `feat: pi-plugin-research — verdict + wg-pi-plugin design`).

The template directory of the era (preserved in the August 5 quarantine) lists nine executor recipes: `aider, amplifier, claude, cline, codex, crush, goose, opencode, qwen`. Model routing ran over OpenRouter with per-task endpoint overrides; a minimax model was benchmarked (`bench-nex-minimax-terminal`); a "model-scout" was built to tune the choice (`bug-model-scout-tuning-not-installed`). Across the organization's whole life, provider/executor migration would account for 430 commits — **13% of everything** — and most of that tax was paid in this window.

## 3.3 Corruption was already a known hazard

Well before anything broke publicly, the record shows the runtime state as a fragile surface:

- **May 2** — `feat: fix-nex-cursor-corruption (agent-1799)`.
- **Late May** — design documents themselves had to be restored from prior revisions: `fix: restore corrupted journal-based-coordinator-self-compaction.md design doc`, `fix: properly restore corrupted design doc from e4a8a8d2`.
- **June 2** — `fix: harden service recovery after corrupt runtime state (fix-service-recovery)`.

Read in sequence, these are not incidents; they are a pattern. By the first week of June, *corrupt runtime state* was a thing the system had hardened against once and would have to survive again. Nothing in the surviving record suggests the hazard was considered contagious to the task graph itself — the graph, after all, was the durable thing, and the archive behind it was append-only.

## 3.4 The rename — "the merger"

On **June 16**, the operator directed a wholesale rename: the Rust package `workgraph` became `worksgood`. It took five commits to land — `01726b5a` and `d4fab0a8` (partial: crate refs done, build passing), `aaa329eb` (complete, touching `src/config.rs`), `d2d5af17` (final cleanup), `664a3ada` (`feat: rename-cargo-package (agent-5304)`). In the operator's memory this was "the merger"; in the log it is a package-and-branding rename executed by agents at 16:29 on a Tuesday.

Two days later, the graph would be gone.

## 3.5 The death — June 18

The only surviving witness to the death is a daemon log at the *original* checkout, `/home/bot/workgraph/.wg/service/`. Its first retained line:

> `2026-06-18T11:48:10.014Z [INFO] Coordinator tick #1927 starting (max_agents=8, executor=codex)`
> `2026-06-18T11:48:10.018Z [ERROR] Coordinator tick error: Failed to load graph for task-aware reaping`

From that tick until the log's final entry on **June 22, 22:00**, the daemon logged the same error on essentially every tick — **76,371 recorded failures across two rotated files** (`daemon.log.1`: 53,318; `daemon.log`: 23,053), while continuing to start coordinators with `executor=codex`. The service was alive. It was simply blind: the graph it needed to load was not there to load.

The same day, June 18, the record shows an adjacent failure in the executor layer: `fix: eliminate nex streaming interruption (error decoding response body)`, whose body documents a request-timeout misdiagnosis cutting healthy long generations — *"[reqwest] bytes_stream() maps EVERY body error to Kind::Decode ... the client's 300s TOTAL request timeout cut healthy long generations"*. Read strictly, that fix explains a streaming symptom, not the missing graph. But it establishes that June 18 was a day of compounding, partly-misdiagnosed failures in the execution layer.

**What we know:** the graph file was unloadable or absent at the original path by the morning of June 18, two days after the rename, in the middle of the pi migration sprint, and the failure went unobserved for at least four and a half days while the daemon ticked.

## 3.6 Three hypotheses, honestly stated

The operator's hypothesis is that the failure explosion was caused *in part by switching to other models or executors that did not feel the context* of the running system — new runners acting on state they did not understand. The evidence cannot yet confirm this. Three candidate mechanisms survive the records:

1. **Corruption (the felt hypothesis).** Corruption was demonstrably recurring (§3.3). A bad save or a partial write during the churn could have destroyed `graph.jsonl` and, with it, the archive's host directory. *For:* the history of corrupted state and corrupted docs. *Against:* no surviving log or commit names the corrupting event; the daemon's error is "failed to load," which is equally consistent with the file being absent.
2. **Relocation / path loss.** The original checkout's state directory is now a husk — `stats.json` contains only `{"service": 98}`, `usage.log` is empty, and there is no `graph.jsonl`, no `archive.jsonl`, no `agents/`. That signature is as consistent with *the state having moved* (and a stale daemon looking at the old path) as with corruption. The July 4 cutover then recreated a graph from scratch at the new checkout (`/home/bot/wg/.wg`), whose earliest files are dated July 4 — so even if the state moved, its history did not survive the relaunch.
3. **Wipe during migration churn.** Multiple executors (nex, opencode, codex) and routing profiles coexisted in this window; the migration era was, in aggregate, a period of aggressive self-modification. An unwise migration step could have cleared state.

**What would distinguish them:** a filesystem-level forensic (inode history, extents, or backups) that no longer exists, or a surviving copy of the pre-June-18 graph, which the exhaustive search of this machine did not find. The honest formulation for the book: *the graph died on or before June 18, during the executor-migration era, with corruption a demonstrated recurring hazard, relocation a live alternative, and no surviving artifact that discriminates between them.*

One thing the hypotheses share is more important than which is true: **the state was durable but local, and nothing — human or agent — was watching it during the quiet.** The daemon's 76,371 failures were logged and read by no one. The operator learned days later, in passing.

## 3.7 The world outside kept moving

June is also the month the project became genuinely public. Eleven Windows-portability PRs from an outside contributor (`njt`) merged — bash resolver, service start timeout, wrapper paths, home lookup, `wg doctor` — plus a multi-bot Telegram feature from a second (`lucapinello`). On **June 26**, the diverged lineages were reconciled:

> **Synthesize diverged mains: merge public origin/main into the internal main** — *"Key fact: this merge is CONTENT-NEUTRAL... There were ZERO conflicts to resolve. The merge commit exists only to join origin/main's history under local's so a `git push origin main` fast-forwards."*

So the "one merger" that the operator half-remembers has two faces: the June 16 package rename, and the June 26 history reconciliation. Neither destroyed content. The content that died was not in git at all.

## 3.8 What was lost in the quiet

By June's end the organization had lost: the task graph for January–June (its audit chains, statuses, and history), the durable task archive that had been accumulating since spring, and any record of which agents did what in the spring. The git history survived — it lived on GitHub. The state did not — it lived only in a local directory that stopped being readable on June 18 and was superseded by a fresh state directory on July 4.

That asymmetry — remote git, local state — is the whole lesson of the chapter. The archive's design was sound (append-only, crash-safe, restorable). Its *placement* was the vulnerability: durable, local, unwatched, in the exact directory that a rename, a migration, and four days of inattention passed through.

## Timeline

- **May 1–31** — Quiet: 128 commits; operator running two grant campaigns elsewhere; `nex`/`opencode` executor experiments begin; corruption fixes (nex cursor, May 2).
- **June 2** — `harden service recovery after corrupt runtime state` — corruption is a hardened-against hazard.
- **June 11–14** — opencode executor researched and exposed over OpenRouter.
- **June 16, 16:29** — `rename-cargo-package: workgraph -> worksgood` completes (5 commits; "the merger").
- **June 18, 11:48** — daemon at `/home/bot/workgraph/.wg` begins failing every tick: *"Failed to load graph"*; same day, nex streaming-timeout misdiagnosis fixed.
- **June 22, 22:00** — final daemon entry (tick continuing to fail); pi migration sprint underway (`pi-plugin-research — verdict`).
- **June 26** — diverged mains reconciled, content-neutral, zero conflicts.
