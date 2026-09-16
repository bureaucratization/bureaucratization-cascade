#!/usr/bin/env bash
# Build paper.pdf from paper/paper.md + figures/.
# Transformations: (1) close spaced em-dashes, (2) replace Unicode minus,
# (3) insert figure blocks, (4) pandoc -> pdflatex.
set -euo pipefail
cd "$(dirname "$0")/.."

python3 - << 'EOF'
s = open('paper/paper.md').read()
F = 'figures'
W = '{width=100%}'

# 1. close spaced em-dashes; 2. sanitize unicode minus
s = s.replace(' \u2014 ', '\u2014').replace('\u2212', '-')

# 3. insert figures at anchor points
s = s.replace(
"The large-scale constraint removal that restored operation is documented in configuration snapshots and resolution records, not in commit subjects.\n",
"The large-scale constraint removal that restored operation is documented in configuration snapshots and resolution records, not in commit subjects.\n\n"
f"![**Figure 1.** Monthly commit velocity (bars) and governance-vocabulary share of commit subjects (line). The April peak and the May collapse frame the ratchet period; September's vocabulary spike is volume collapse with governance work at constant absolute rate.]({F}/fig1-velocity.png){W}\n", 1)

s = s.replace(
"The five provider-backoff-contract commits touch only `docs/design-provider-failure-backoff.md`\u2014verified docs-only, no source changes.\n",
"The five provider-backoff-contract commits touch only `docs/design-provider-failure-backoff.md`\u2014verified docs-only, no source changes.\n\n"
f"![**Figure 4.** The provider-backoff-contract sequence: cumulative size of the specification document after each hardening commit. Two bursts separated by a three-week gap; the functionality the contract governed never shipped during the period shown.]({F}/fig4-ratchet.png){W}\n", 1)

s = s.replace(
"The system now performs well. Which brings us to the finding we did not expect.\n",
"The system now performs well. Which brings us to the finding we did not expect.\n\n"
f"![**Figure 2.** Gate census: constraints added (red) and removed (green) per month, with cumulative active constraints (line). Accretion tracks incidents; the collapse months are an accretion freeze, not a recovery; the ratchet resumes in July.]({F}/fig2-accretion.png){W}\n", 1)

s = s.replace(
"Total recorded metered cost for the window: **$683.55**.",
"Total recorded metered cost for the window: **$683.55**.\n\n"
f"![**Figure 3.** Model mix in the session-attributable window. Structured metering fields only; text-mention frequency is deliberately excluded (see \u00a75). The gpt-6-astra entry coincides with the recovery phase.]({F}/fig3-models.png){W}\n", 1)

open('paper/paper-build.md', 'w').write(s)
print('paper/paper-build.md generated')
EOF

pandoc paper/paper-build.md -o bureaucratization-cascade.pdf \
  --pdf-engine=pdflatex -V geometry:margin=1in -V fontsize=10pt -V colorlinks=true
echo "built bureaucratization-cascade.pdf"
