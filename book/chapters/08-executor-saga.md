# Chapter 8 — The Executor Saga

*Thematic chapter. The organization's nine-month effort to decide who — or what — actually runs the work.*

---

## The tax

Every eighth commit in wg's entire lifetime was about moving house.

By subject-line grep across all 3,226 commits, **511 commits (15.8%)** mention an executor, provider, route, profile, or model. The semantic classifier run over the same corpus scores provider/executor migration at **430 commits, 13%** — the single largest non-implementation theme in the repository, larger than verification, larger than documentation. An organization built to coordinate agents spent a seventh of itself deciding which agents to coordinate it with.

The distribution is not flat:

| Phase | Window | Commits | Executor/provider-touching |
|---|---|---|---|
| Native + Claude | Jan 18 – Apr 17 | 1,805 | 424 |
| Codex adapter | Apr 18 – May 5 | 481 | 70 |
| Nex / OpenRouter | May 6 – Jun 9 | 113 | 37 |
| Opencode | Jun 10 – Jun 21 | 66 | 13 |
| Pi arrival | Jun 22 – Jul 3 | 184 | 66 |
| Churn week | Jul 4 – Jul 25 | 255 | 72 |
| Sol-stable | Jul 26 – Aug 31 | 552 | 144 |
| Project-local Pi | Sep 1 – Sep 30 | 175 | 78 |

The first row dominates by volume because the whole organization was being built then. The interesting rows are the middle ones: in the six weeks from May 6 to June 21, **85 of 179 commits (47%)** concerned executors, providers, or routes — in a period when total volume had collapsed to a fraction of spring's. **The organization was doing less work, and nearly half of it was about how work gets run.**

## The zoo

The executor catalogue grew by accretion, each addition locally reasonable.

**February 18** — `feat: add amplifier as built-in executor`. The first external harness joins the native executor.

**April 18–20** — the external-executor abstraction becomes real: `docs + config: external-executor class design + claude/codex TOML examples`, then `feat(phase7): wg codex-handler — third executor adapter, three-way coord smoke`. Three adapters: native, Claude, Codex. A design pattern is now established — *executors are pluggable, so add executors*.

**April 3 – May** — OpenRouter arrives as a *provider* underneath those executors, not an executor itself. The arc is dense and fast: March 5 `research OpenRouter integration status and gaps`; March 7 `OpenRouter provider client with attribution headers and URL fix` + `OpenAI SSE streaming with tool call accumulation`; March 8 `OpenRouter end-to-end validation report`; April 3 a cluster of smoke tests (`exec-smoke-tool-loop`, `exec-smoke-streaming`, `exec-smoke-errors`, `exec-smoke-wg-tools`, and integration tests); **April 11 `implement OpenRouter cost cap enforcement`** — the provider is now metered, and a cap is a new kind of rule.

**May 31** — the directive that opens the zoo. In the principal's own words, recorded in the Codex prompt corpus:

> "i want to enable all the coolest executors. opencode! then the next most popular ones that work on an open backend. amplifier. anything else. dispatch research"

**June 1** — ten `exec-*` commits land in a single day: `exec-opencode-aider (agent-21)`, `exec-goose-qwen-cline (agent-11)`, `exec-crush-amplifier (agent-12)`, `exec-openrouter-normalize (agent-5)`, `exec-final-integration (agent-42)`, `exec-discovery-docs (agent-23)`, `exec-tests (agent-22)`, `exec-rank-defaults`, `exec-smoke-arena`, plus `fix-nex-openrouter (agent-36)`. Alongside them, the reliability complaints that would define the season:

> "get openrouter set up correctly and smoke test nex and wg nex and opencode etc. here is our key ~/.openrouter.key. i fixed it"

> "fix-nex-openrouter is stuck too pending-eval forever"

The key arrives as a file the principal fixes by hand. The executor does not work; the *route* does not work; nobody can yet say which.

**June 8–14** — the zoo consolidates into `nex`, which gets its own line of development: `nex-openrouter-default-ui`, `nex-optional-openrouter-endpoint`, `research-openrouter-cli-executors`, `expose-opencode-openrouter`, and a long tail of TUI fixes (`fix-tui-opencode`, `fix-opencode-tui`, `fix-opencode-build`, `verify-opencode-chat`). By mid-June the organization is maintaining an executor that exists to test other executors.

## The answer arrives as a question

**June 15, 13:36** — one line in the prompt record:

> "thinking we should test out and integrate the executor called 'pi'. wdyt?"

This is the pivot of the entire saga, and it arrives as a suggestion, not a plan.

**June 22** — `pi-design-integration: pi.dev integration plan (executor handler + chat/TUI + light-touch patch)`. Same day: `pi-plugin-impl-handler`, `route pi handler through plugin`. **June 23–24** — the architectural idea that makes Pi survivable: `design-handler-first (agent-5674)`, `implement-handler-first (agent-5701)`, `fix-pi-handler (agent-5707)`.

Handler-first is the decisive inversion. Under the accumulating design, wg had to *know* about models — to resolve them, register them, validate them, price them. Handler-first says: wg passes the route spec through verbatim (`pi:zai:glm-5.2`, `claude:opus`) and the executor resolves it. No network. No registry lookup. No central model knowledge. It is, in miniature, the resolution of the entire saga — and it was written in June, five weeks before the dispatcher actually wedged on a missing API key.

## The churn week

Through June 23 the stable regime was `claude:opus` primary with `claude:haiku` for evaluator/assigner/flip roles. Then, in the week of **July 4–11, the primary model/route changed seven times**:

1. **Jul 4, 17:08** — `claude:opus` → `codex:gpt-5.5`
2. **Jul 4, 19:55** — the `[agency]` automation-and-gate block switched **ON**; OpenRouter keyring adopted; `on_provider_failure = "pause"`; `provider_failure_threshold = 3`
3. **Jul 6, 14:47** — → `pi:openrouter:z-ai/glm-5.2`
4. **Jul 7, 11:31 → 11:44** — → `lunaroute glm-5.2-nvfp4`, reverted to codex thirteen minutes later
5. **Jul 8, 09:20 → 11:53** — second lunaroute attempt, abandoned same day for `deepseek-v4-flash` via OpenRouter
6. **Jul 11, 17:59** — → `openai-codex:gpt-5.6-sol` (the long-stable regime begins)
7. **Jul 26, 09:59** — → `pi:zai:glm-5.2` (direct z.ai, bypassing OpenRouter entirely)

The configuration file that held all this was **341 bytes on June 23**. On July 4 at 19:55, one edit took it to **3,376 bytes** — a ten-fold jump, because that is the moment the 25-key `[agency]` block landed. The project config grew from 3,376 to **5,129 bytes between July 4 and July 25: +52% in three weeks.**

The naming in that config is the saga in one line: `on_provider_failure = "pause"`, `provider_failure_threshold = 3`, the OpenRouter keyring — all arriving **on July 4, the same moment gate automation switched on**. The infrastructure was being hardened against provider failure by the same mechanism that hardened it against everything else.

## The wedge

**July 25** — the commit that explains the entire problem in its own words:

> `fix(dispatch): decouple spawning from the OpenRouter catalog refresh`

> "A non-built-in provider model (e.g. `pi:zai:glm-5.2`) used to wedge the dispatcher when the OpenRouter-backed registry refresh was unavailable (no `OPENROUTER_API_KEY`): the refresh failed into a 60-min cooldown that looked like a wedged dispatcher, and the model-resolution warning made the failure look unfixable without restoring **the accidental key dependency**."

Read that again. wg's own model registry — the catalogue of models it was willing to route to — was refreshed from OpenRouter's API. It had a **circuit breaker**. When the API key was absent, the refresh failed into a **sixty-minute cooldown** that presented to the operator as a wedged dispatcher. **Metadata about models had become load-bearing infrastructure, and its absence could stop all work for an hour.**

The fix is the saga's turns in miniature: (1) decouple dispatch from the refresh — "the refresh is metadata; its absence cannot wedge dispatch"; (2) fail-soft resolution for handler-first specs; (3) first-class static registration; (4) an opt-out flag; (5) surface genuinely unresolvable models loudly at startup instead of in daemon logs.

## What the saga cost

Set against the constraint census, the executor saga is the ignition's fuel. The April credit-exhaustion events (three tasks abandoned on **HTTP 402 with minimax/minimax-m2.7**, one exit-143 agent kill) were the spring's provider pain. July's churn week bracketed the census's constraint spike (43–46 births/month, against ~5 in May and June) and produced the provider-backoff-contract — five docs-only hardenings, zero shipped features. Provider failure was not a background condition of the accretion; **it was its precipitating environment.**

And in the provider domain alone, the human *did* direct hardening explicitly. **August 16**:

> "Let's implement a kind of exponential fall off, back off, when we see provider failure information."

That is not a complaint routed around; that is a hardening directive in the realm where the principal's expertise applied. It produced the provider-backoff-contract — which then failed, was debugged, failed again, and was hardened four more times. The one place the operator asked for a rule, the rule machinery still over-produced.

## Verdict

The executor saga cost the organization roughly a seventh of its total output, a third of its commits during the summer, a wedged dispatcher, a five-week debugging arc on a contract that shipped nothing, and at least one hour of total organizational downtime per missing API key. It also directly ignited the constraint accretion that this book is about — the provider-backoff-contract family exists because endpoints failed, and it was born in the same week as the automation that let such contracts compound. What fixed it was not a better model, and not a better provider: it was **ceding authority**. Handler-first (June) made route resolution the executor's problem; `openrouter_refresh = false` and dispatch decoupling (July 25) made provider metadata non-load-bearing; the September 3 Pi-only proposal — *"We now use Pi as the sole model/authentication interface. Provider login and credentials belong to Pi, so WG's global secrets and model-routing state are usually unnecessary"* — and the **September 16 registry retirement** finished the job: wg deleted its own model registry, its daemon registry-refresh path, its circuit breaker, and its OpenRouter fetch, and read rates from the host harness's catalog instead. The organization stopped trying to be a model-routing authority. One commit in eight had been spent building that authority; one commit ended it.

---

*Uncertainties flagged: (1) The per-phase commit counts use my own date-window boundaries, which are analytical, not organizational — the phases overlap at their edges and the "native + Claude" row is inflated by the fact that all early development was executor-adjacent. (2) The 15.8% subject-grep figure and the 13% semantic-classifier figure measure different things (term presence vs. classified theme); both are reported rather than reconciled. (3) The seven-route-change count follows the config backups, which are timestamped but may omit changes reverted within a single backup interval; the true count is ≥7. (4) Attribution of the July 4 automation switch-on remains open — it falls in a coverage gap between the Claude (ends Jul 3), Codex (interactive ends Jul 12 and shows no matching directive), and pi (begins Aug 5) corpora.*
