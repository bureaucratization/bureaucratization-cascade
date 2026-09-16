# The Bureaucratization Cascade

Forensic case study of recursive constraint accretion in a hybrid human-AI organization (Poietic PBC working paper).

## Layout
- `paper/paper.md` — master source (edit this; spaced em-dashes, no figures embedded)
- `paper/paper-build.md` / `paper/paper-arxiv-build.md` — generated (do not edit)
- `paper/paper-arxiv.md` — academic variant (stripped rhetoric, derived from paper.md)
- `figures/` — figure PNGs (generated from `data/`)
- `data/` — verified forensic datasets and audit reports backing every claim
- `reviews/` — dated external review notes; each revision should reference one
- `scripts/build.sh` — reproducible build: paper.md → paper.pdf (em-dash closure, figure insertion, pandoc/pdflatex)

## Build
    ./scripts/build.sh        # full-voice version
    ./scripts/build-arxiv.sh  # academic version

## Status
- All quantitative claims fact-checked (data/fact-check.md: 24 PASS, 0 FAIL)
- Security: redaction audit + gitleaks history sweep clean; base64 rescan pending
- Review 1 received (reviews/2026-09-16-review-1.md); revision pending
