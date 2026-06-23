# 🚀 Portfolio Projects

> **The single highest-value part of this roadmap for hiring.** Certifications get you past the résumé filter; a public portfolio of *working, documented, secure systems* gets you shortlisted and gives you something concrete to talk through in interviews.

Each project is a **standalone public GitHub repo** (not just notes here). This folder holds the brief, the acceptance criteria, and a link to the live repo.

---

## The five projects

| # | Project | Pairs with | Proves you can… |
|---|---|---|---|
| 01 | [Secure CI/CD Pipeline](project-01-secure-cicd.md) | Phase 2 | Design a pipeline with SAST/DAST/SCA + supply chain controls |
| 02 | [Kubernetes Security](project-02-kubernetes-security.md) | Phase 2 (CKS) | Harden and defend a real cluster |
| 03 | [Cloud Security (AWS)](project-03-cloud-security.md) | Phase 1 / 1.5 | Provision a secure, scanned, monitored AWS environment |
| 04 | [Platform Engineering](project-04-platform-engineering.md) | Phase 3.5 | Build a self-service paved road |
| 05 | [DevSecOps Capstone](project-05-devsecops-capstone.md) | Phase 4 | Tie it all together end-to-end |

---

## What every project repo must contain

This is the bar that turns a hobby repo into a portfolio piece:

- [ ] **README** with an architecture diagram (source + exported image) at the top
- [ ] **Working code/IaC** that someone else can run from the README
- [ ] **A threat model** (`THREATMODEL.md`) — STRIDE pass minimum
- [ ] **A security controls matrix** (mapped to NIST CSF / SSDF / CIS)
- [ ] **A runbook** (`RUNBOOK.md`) — how to operate it
- [ ] **CI that actually runs** (green badge) including the security gates
- [ ] A short **"what I'd do next / known gaps"** section (signals seniority)

> Recruiters skim. Lead with the diagram and a one-paragraph "what this is and why it's secure."

---

_← [Back to README](../README.md)_
