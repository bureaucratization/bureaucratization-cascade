# The Bureaucratization Cascade

**In mid-2026, an AI agent organization slowly stopped working — not because anything broke, but because it obeyed its own rules too well.**

This repository documents what happened, names the failure mode, and publishes the evidence.

## What happened

[Poietic](https://poietic.life) built [wg](https://graphwork.github.io), a tool that coordinates human and AI agents through a shared dependency graph. Between January and September 2026, wg was developed almost entirely by the agents it coordinates — humans set direction; agents wrote the code, the tests, the review criteria, and the rules by which future work would be judged.

It worked remarkably well for a while. Then it didn't.

Every time agents hit a failure, they responded the way you'd want: they added a check, a gate, a contract, a rule to prevent recurrence. What no agent ever did was remove one. Each rule was locally rational. The accumulation was not:

- **312 constraints added. 1 removed.** 93% of constraints were created in a single commit and never revisited.
- In April, monthly commit volume peaked at 1,082. In May it collapsed by 89%. Tasks stopped completing — not because the models got dumber, but because **acceptance had become over-determined**: every gate from every past incident now had to be satisfied simultaneously.
- Recovery came only from targeted human edits that disabled the machinery *adding* new gates. The system wasn't broken. It was in compliance.

## The name

> **Recursive constraint accretion:** a process in which agents responding to local failures add persistent constraints faster than the organization retires or amortizes them, causing aggregate compliance burden to grow over time.

Collapse is one possible outcome, not a requirement. And while we observed this in an agent organization — where the loop that human bureaucracies run over decades ran in months — the definition doesn't require AI. Any self-modifying governance system needs **rule lifecycle management, not just rule enforcement**. We propose this as a candidate multi-agent failure mode, alongside collusion and emergent miscoordination, worth testing in other systems.

## The paper

Two versions, same content:

- **[`bureaucratization-cascade-arxiv.pdf`](bureaucratization-cascade-arxiv.pdf)** — academic register, stripped rhetoric, arXiv-ready
- **[`bureaucratization-cascade.pdf`](bureaucratization-cascade.pdf)** — full-voice version, same claims, more character

Every number in them is verified: the [fact-check report](data/fact-check.md) ran every commit hash, quote, and figure against the repository record (24 PASS, 0 FAIL, corrections applied). Figure data lives in [`data/`](data/); the builds are reproducible via [`scripts/`](scripts/).

The [full forensic record](https://github.com/ekg/wg) — 3,194 commits, agent session logs, the failure reports — is public in the wg repository.

## Why publish the embarrassing version

Because a named, documented, forensically-grounded failure is worth more to the field than ten private ones. If your agents can add rules but never retire them, this is your future at machine speed. The fix is a design parameter: **bound the topology, price the gates, keep the history, and build the bankruptcy valve before you need it.**

---

*Poietic PBC builds open tools for legible human–AI collaboration. Contact: the [Poietic site](https://poietic.life).*
