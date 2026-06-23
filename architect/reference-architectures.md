# Reference Architectures & Controls Matrices

> A living library of diagrams and control mappings you produce across the roadmap. These are the artifacts you put in front of an interview panel — collect them here as you go.

---

## How to use this file

For each design, capture **four** things (this is the architect's standard deliverable set):

1. **Context diagram** — system in its environment (who/what talks to it)
2. **Architecture diagram** — components, trust boundaries, data flows
3. **Threat model** — STRIDE/PASTA pass, ranked threats, mitigations, residual risk
4. **Controls matrix** — every control mapped to a framework (NIST CSF / SSDF / CIS)

Commit diagram **source** (e.g. `diagrams/*.drawio`, Mermaid, or `diagrams-as-code`) alongside the exported `.png` so they stay reviewable in PRs.

---

## Diagram backlog (fill these in)

| # | Architecture | Source | Status |
|---|---|---|---|
| 1 | Secure AWS landing zone ([Phase 1.5](../phases/phase-1.5-iac.md)) | `diagrams/landing-zone.*` | ☐ |
| 2 | Secure CI/CD pipeline ([Project 01](../projects/project-01-secure-cicd.md)) | `diagrams/cicd.*` | ☐ |
| 3 | Hardened EKS / multi-tenant cluster ([Project 02](../projects/project-02-kubernetes-security.md)) | `diagrams/eks.*` | ☐ |
| 4 | Zero-trust app architecture ([zero-trust.md](zero-trust.md)) | `diagrams/zero-trust.*` | ☐ |
| 5 | Full capstone reference ([Project 05](../projects/project-05-devsecops-capstone.md)) | `diagrams/capstone.*` | ☐ |

---

## Controls matrix template

Copy this per design:

| Control | Implementation | Type (Prev/Det/Corr) | NIST CSF | Framework ref | Status |
|---|---|---|---|---|---|
| Image signing | Cosign + Kyverno admission | Preventive | PR.DS / PR.PT | SLSA L3, SSDF PS.1 | ☐ |
| IaC scanning | Checkov gate in CI | Preventive | DE.CM / PR.IP | SSDF PW.4 | ☐ |
| Runtime detection | Falco → SIEM | Detective | DE.CM | NIST 800-53 SI-4 | ☐ |
| Centralized audit | Org CloudTrail → log-archive acct | Detective | DE.AE | CIS AWS 3.x | ☐ |
| Network isolation | Default-deny NetworkPolicy | Preventive | PR.AC / PR.PT | NSA K8s hardening | ☐ |

> Map to **one** primary framework per audience: NIST CSF for execs, SSDF for the SDLC story, CIS for prescriptive config.

---

## The "tells" of a strong architecture artifact
- Trust boundaries are drawn explicitly (not just boxes and arrows)
- Every threat has a mitigation **or** a written residual-risk acceptance
- Controls trace to a business attribute ([SABSA](sabsa.md)) and a framework
- Failure modes / blast radius are addressed, not just the happy path

---

_← [Architect Track](README.md)_
