# Project 05 — DevSecOps Capstone

> **Pairs with:** [Phase 5](../phases/phase-5-ccsp.md) · **Proves:** everything, end-to-end. This is the repo that gets you shortlisted.

---

## The target

By the end of the roadmap, one flagship public repo that demonstrates the full secure software delivery lifecycle on real infrastructure:

```
GitHub Actions
      ↓
  Terraform ──► AWS ──► EKS
      ↓
  Trivy · Checkov · Snyk        (scan: code, deps, IaC, images)
      ↓
  Syft (SBOM) · Cosign (sign)   (supply chain)
      ↓
  Kyverno admission              (only signed, compliant workloads run)
      ↓
  Falco                          (runtime detection)
      ↓
  Prometheus + Grafana           (observability + security dashboards)
```

## Required documentation set (this is what differentiates it)
- [ ] **Architecture diagram** (source + image) at the top of the README
- [ ] **Threat model** — STRIDE + PASTA pass, ranked, with mitigations & residual risk
- [ ] **Security controls matrix** — mapped to NIST CSF / SSDF / CIS
- [ ] **Runbook** — how to deploy, operate, rotate secrets, respond to alerts
- [ ] **Incident response playbook** — at least one scenario (e.g. compromised CI token, malicious image) walked through
- [ ] **"Known gaps & what's next"** — explicit residual risk and roadmap

## Acceptance criteria
- [ ] Anyone can stand it up from the README
- [ ] Every security gate is green in CI and **one planted failure is demonstrated**
- [ ] An attack scenario is detected by Falco and visible in Grafana
- [ ] The four-artifact set above is complete and reviewable

## The recruiter test
> If a hiring manager opens this repo, sees the diagram, the threat model, the green security pipeline, and the IR playbook — they shortlist you for a Senior DevSecOps interview on the spot. That is the bar.

---

_← [Projects](README.md)_
