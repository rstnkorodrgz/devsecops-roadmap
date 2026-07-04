# Pillar D — Architecture Depth (Staff-Level Design Artifacts)

> The staff/principal signal: designs that others build on, written down, defensible.

## Threat modeling to reflex level
- [ ] STRIDE per-element without notes; PASTA for narrative attack paths; attack trees for specific scenarios
- [ ] Practice substrate: your own phase artifacts — every public repo gets a `THREATMODEL.md`
- [ ] SABSA: **optional reading, not a certification goal** — [architect/sabsa.md](../architect/sabsa.md) for the business-attribute habit; skip SCF/SCP exams

## Public reference architectures (this repo)
- [ ] **Secure multi-tenant Kubernetes baseline** — from the Phase 3 playbook + [tracks/platform-engineering.md](../tracks/platform-engineering.md) multi-tenancy module
- [ ] **Zero-trust CI/CD reference** — from the Phase 3 pipeline + [architect/zero-trust.md](../architect/zero-trust.md) PDP/PEP mapping
- [ ] **Multi-cloud security reference** — the Phase 5 capstone artifact
- [ ] All live in [architect/reference-architectures.md](../architect/reference-architectures.md) with the four-artifact standard (context diagram, architecture diagram, threat model, controls matrix)

## Design-doc habit
- [ ] Every major decision at work → written ADR/design doc (private)
- [ ] **One sanitized version published per quarter** — this is a standing quarterly-artifact source

## Reading library
The [`architect/`](../architect/README.md) modules (zero trust, cloud security, secure SDLC, platform engineering) are this pillar's curriculum — worked as design questions arise, not on a schedule.

---

_← [Pillars](README.md)_
