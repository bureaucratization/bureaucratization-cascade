# The Bureaucratization Cascade

A computational ethnography of recursive constraint accretion in a hybrid human–AI organization. Poietic PBC working paper, September 2026.

**Paper:** [`bureaucratization-cascade.pdf`](bureaucratization-cascade.pdf) · Development: [`paper/`](paper/) + [`scripts/build.sh`](scripts/build.sh)

## Abstract

Between January and September 2026, the open-source coordination system **wg** was developed almost entirely by AI agents, under human direction, through its own coordination protocol. The agents wrote the code, the organization, the verification criteria, and the rules by which future work would be judged. Over five months this produced a failure mode we have not seen described in this form: locally reasonable attempts at correction accumulated into an increasingly burdensome governance regime. By late April the system's monthly commit volume peaked at 1,082; by May, output had collapsed by 89%. A census of the governance layer found **312 constraints added and 1 removed**; 93% of constraints were created in a single commit and never revisited. Recovery came only through targeted edits that disabled the machinery adding new constraints.

We name this failure mode and document it from the preserved forensic record — 3,194 commits, agent session logs, evaluation receipts, and failure reports.

> **Recursive constraint accretion:** a process in which agents responding to local failures add persistent constraints faster than the organization retires or amortizes them, causing aggregate compliance burden to grow over time.

The definition does not require collapse, and does not require AI. We propose it as a candidate multi-agent failure mode worth testing in other systems.

## Contents

- `paper/paper.md` — source; edit this
- `bureaucratization-cascade.pdf` — built paper
- `figures/` — the four figures (PNG)
- `data/` — verified datasets and audit reports backing every claim (gate census, accretion curve, model attribution, metered costs, fact-check, security audits)
- `research/` — related-work dossier with four annexes (prior sightings of the phenomenon)
- `reviews/` — dated review notes
- `scripts/build.sh` — reproducible build: `./scripts/build.sh`

## Related

- wg (the system studied): [graphwork.github.io](https://graphwork.github.io) · [github.com/bureaucratization/bureaucratization-cascade](https://github.com/bureaucratization/bureaucratization-cascade)
- Poietic PBC: [poietic.life](https://poietic.life)
