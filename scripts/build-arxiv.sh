#!/usr/bin/env bash
# Academic variant: paper-arxiv.md is derived from paper.md (stripped rhetoric).
# Em-dash closure + unicode minus happen here; figures reuse the same anchors.
set -euo pipefail
cd "$(dirname "$0")/.."
python3 - << 'PYEOF'
import re
s = open('paper/paper-arxiv.md').read()
s = s.replace(' \u2014 ', '\u2014').replace('\u2212', '-')
F = 'figures'; W = '{width=100%}'
s = s.replace("documented in configuration snapshots and resolution records, not in commit subjects.\n",
"documented in configuration snapshots and resolution records, not in commit subjects.\n\n"
f"![**Figure 1.** Monthly commit velocity (bars) and governance-vocabulary share of commit subjects (line).]({F}/fig1-velocity.png){W}\n", 1)
s = s.replace("verified docs-only, no source changes.\n",
"verified docs-only, no source changes.\n\n"
f"![**Figure 2.** The provider-backoff-contract sequence: cumulative specification size after each hardening commit; the governed functionality never shipped in the period shown.]({F}/fig2-ratchet.png){W}\n", 1)
s = s.replace("Which brings us to the finding we did not expect.\n",
"Which brings us to the finding we did not expect.\n\n"
f"![**Figure 3.** Gate census: constraints added and removed per month, with cumulative active constraints.]({F}/fig3-accretion.png){W}\n", 1)
s = s.replace("Total recorded metered cost for the window: **$683.55**.",
"Total recorded metered cost for the window: **$683.55**.\n\n"
f"![**Figure 4.** Model mix in the session-attributable window; structured metering fields only.]({F}/fig4-models.png){W}\n", 1)
open('paper/paper-arxiv-build.md','w').write(s)
PYEOF
pandoc paper/paper-arxiv-build.md -o bureaucratization-cascade-arxiv.pdf \
  --pdf-engine=pdflatex -V geometry:margin=1in -V fontsize=10pt -V colorlinks=true
echo "built bureaucratization-cascade-arxiv.pdf"
