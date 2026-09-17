# wg model-attribution—extraction summary

- Agent dirs scanned: 14; pi-sessions parsed: 18
- Attempt state.json records: 130; operations-log model entries: 23
- model_change events found in sessions: 21
- **Session-level coverage: 2026-08-08 → 2026-09-16 only.** The event ledger (lifecycle/events.jsonl) starts 2026-08-08; .wg state was compacted/reset at that date. Jan–Jul attribution is phase-level only (git config commits + repo analysis docs).

## Recorded cost by model family (from usage.cost fields in session logs—actual metered values, not estimates)
- gpt-5.6-sol: $609.93 across 4318 billed messages
- gpt-6-astra: $73.61 across 329 billed messages
- glm: $0.00 across 584 billed messages
- **TOTAL recorded: $683.55** (Aug 8 – Sep 16 window only)

## Session-level mix by month

| month | glm | gpt-5.6-sol | gpt-6-astra |
|---|---|---|---|
| 2026-08 | 0 | 69 | 0 |
| 2026-09 | 20 | 77 | 1 |
| unknown | 1 | 3 | 0 |

## Phase-level attribution for Jan–Jul 2026 (lower confidence)
Sources: git config commits naming models; dated analysis docs (COMPARATIVE_PROMPT_ANALYSIS.md etc., 2026-08-07) referencing the executor history; config.toml backups.
- IMPORTANT CORRECTION: raw-text greps show ~80K 'claude' mentions, but these are overwhelmingly agents DISCUSSING claude in prompt/task content, not executing it. Structured model fields in the surviving Aug–Sep sessions show ZERO claude execution. Actual executed models in the recoverable window: gpt-5.6-sol (dominant), gpt-6-astra (appears mid-September), glm-5.x (zero-cost routed tier, 584 messages).
- The historical period (Jan–Jul) used the claude CLI executor and gpt-5.5/gpt-5.4 per the analysis docs; gpt-5.5 is the most-cited model in WG_EXECUTOR_MODEL_MISMATCH docs (the April-era executor/model mismatch triage).
- gpt-5.5 / gpt-5.4 appear in mismatch-triage docs; 2026-09-04 commit: 'config: route Pi workers through Codex Sol' (gpt-5.6-sol era begins); 2026-09-16: workers → lunaroute glm-5.3-flash, agency weak tier → deepseek-4.1-flash.

## Notable findings for the paper
1. **gpt-6-astra appears in September 2026** (329 billed messages, $73.61)—a model generation shift during the recovery phase, consistent with the human intervention timeline.
2. **glm tier runs at $0.00 recorded cost** (584 msgs, ~102M tokens)—routed via lunaroute; this is the "cheap tier" from the 2026-09-16 config commit. A two-tier cost architecture (expensive worker + free weak tier) is visible in the metering itself.
3. **Pre-Aug 8 usage is unrecoverable from .wg**—the entire Jan–Jul cost story is archaeologically lost at the session level; only git commits and dated docs survive. This is itself a finding: the coordination record's retention policy destroyed the forensic record of the collapse period.
4. The earlier draft's claim that 'Claude dominates the log' was a text-mention artifact and must be corrected in the paper.

## Caveats
- Attribution confidence: HIGH for agents/ + attempts/ rows (structured fields); MEDIUM for operations-log rows; LOW (phase-level) for Jan–Jul.
- Cost figures are the system's own recorded metering for the Aug–Sep window; they exclude any pre-Aug 8 usage (unrecoverable from .wg) and any messages without usage fields.
- Base64 false-positive risk was avoided by using structured JSON fields only.