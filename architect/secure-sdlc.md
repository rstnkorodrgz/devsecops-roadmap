# Secure SDLC & Program Maturity

> **Why it matters:** An architect doesn't just add a scanner to a pipeline — they design the *program* that makes secure software the default across many teams, and they measure its maturity. This is the governance layer above [Project 01](../projects/project-01-secure-cicd.md).

---

## Frameworks you must be able to compare

| Framework | What it is | Use it to… |
|---|---|---|
| **NIST SSDF (SP 800-218)** | Secure Software Development Framework — practices grouped as PO/PS/PW/RV | Map your pipeline controls to a federal-recognized standard |
| **OWASP SAMM** | Software Assurance Maturity Model — 5 business functions, 3 maturity levels | Self-assess and build a roadmap to a target maturity |
| **BSIMM** | *Descriptive* model of what real firms do (observed, not prescriptive) | Benchmark against industry peers |
| **Microsoft SDL** | Classic phase-gated secure development lifecycle | Borrow concrete activities (threat modeling gate, etc.) |

> **SAMM vs BSIMM** is a classic interview question: SAMM is *prescriptive* (what you should do), BSIMM is *descriptive* (what others actually do).

## NIST SSDF practice groups (memorize the four)
- **PO** — Prepare the Organization (policy, roles, toolchains)
- **PS** — Protect the Software (integrity, provenance, releases)
- **PW** — Produce Well-Secured Software (design, review, test)
- **RV** — Respond to Vulnerabilities (intake, triage, remediation)

## Shift-left *and* shift-right
- Left: threat modeling, secure design review, SAST/SCA pre-merge, IaC scanning
- Right: DAST, runtime (Falco), CSPM, bug bounty, incident response feedback loop
- Architect's job: make each control a **paved-road default**, not a per-team negotiation

## Designing the program (not just the pipeline)
- [ ] Security requirements as code (policy gates) vs documents
- [ ] A vulnerability management SLA tied to severity (RV practices)
- [ ] Security champions model across stream-aligned teams
- [ ] Metrics: mean-time-to-remediate, % services on the paved road, escaped-defect rate
- [ ] Map controls → a framework so leadership sees coverage and gaps

---

## Study checklist
- [ ] Read NIST SP 800-218 (SSDF) and learn the PO/PS/PW/RV mapping
- [ ] Run an OWASP SAMM self-assessment on your capstone program
- [ ] Articulate SAMM vs BSIMM vs SSDF differences in two sentences each
- [ ] Connect SSDF "PS" practices to supply chain (SLSA/SBOM/signing) from [Phase 2](../phases/phase-2-cicd.md)

## Deliverable
- [ ] A SAMM maturity scorecard (current → target) for your capstone program

---

_← [Architect Track](README.md)_
