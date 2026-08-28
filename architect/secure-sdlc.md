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
| **OWASP DSOMM** | DevSecOps Maturity Model — 4 dimensions, maturity levels 1–4, scored per activity | Assess a *pipeline*, not a programme — the only one of these built for DevSecOps specifically |

> **SAMM vs BSIMM** is a classic interview question: SAMM is *prescriptive* (what you should do), BSIMM is *descriptive* (what others actually do).

## DSOMM — the pipeline-level model

> Added in v2.2. SAMM and BSIMM assess a *security programme*; DSOMM assesses a *delivery pipeline*, which is the altitude most of this roadmap operates at.

Four dimensions, each scored across maturity levels 1–4:

| Dimension | Asks |
|---|---|
| **Build & Deployment** | Is the pipeline itself defined, reproducible, and gated? |
| **Culture & Organisation** | Do developers own security outcomes, or is it thrown over a wall? |
| **Implementation** | Are the controls (SAST/SCA/DAST/secrets/IaC) actually wired in and enforcing? |
| **Information Gathering** | Do you have logging, monitoring, and a **central place findings land**? |

- [ ] Read the model at [dsomm.owasp.org](https://dsomm.owasp.org) and score [project-01](../projects/project-01-secure-cicd.md) honestly against all four dimensions
- [ ] Note where the low scores cluster — for most engineers it is *Information Gathering*, which is exactly why DefectDojo went into project-01 in v2.2
- [ ] Set a target level per dimension and put the delta in [`progress/quarterly-tracker.md`](../progress/quarterly-tracker.md)

> **Which model when:** DSOMM to argue for the next control in *your* pipeline. SAMM to build a multi-team roadmap. BSIMM to benchmark against peers. SSDF when a regulator or federal customer asks for a recognised standard. Being able to pick the right one for the audience is the staff-level skill.

## DevOps fundamentals you're expected to already know

> Vocabulary, not lab work — but it appears in written assessments and in the first ten minutes of an interview, and this roadmap never wrote it down.

- [ ] **CAMS** — Culture, Automation, Measurement, Sharing. The original DevOps framing, and still the cleanest way to explain why a tool-only DevSecOps rollout fails
- [ ] **People / Process / Technology** — and why security programmes that only fund the third one stall
- [ ] The claimed benefits: speed, reliability, availability, scalability, automation, cost, visibility — and which of them security work actually *degrades* if done badly (speed) versus improves (reliability, visibility)
- [ ] **Deployment strategies** and their security implications: blue/green, canary, rolling — see [tracks/platform-engineering.md](../tracks/platform-engineering.md) Module C
- [ ] **DORA metrics** — deployment frequency, lead time, change failure rate, MTTR — and the counter-intuitive finding that high-performing teams ship *more* often and break things *less*. Security gates that slow deployment frequency need this data to survive a budget conversation

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
- [ ] Articulate SAMM vs BSIMM vs DSOMM vs SSDF differences in two sentences each
- [ ] Connect SSDF "PS" practices to supply chain (SLSA/SBOM/signing) from [Phase 3](../phases/phase-3-cks.md)

## Deliverable
- [ ] A SAMM maturity scorecard (current → target) for your capstone program
- [ ] A **DSOMM scorecard** for the project-01 pipeline — current level per dimension, target level, and the single next control that moves the lowest one

---

_← [Architect Track](README.md)_
