# Pillar A — Open-Source Contribution (CNCF Security Ecosystem)

> **Rule: pick ONE project for depth, not five for breadth.** A recognized contributor to one security project outweighs drive-by PRs to five.

## Candidate projects (pick one)

| Project | Why it fits | Pairs with |
|---|---|---|
| **Trivy** ⭐ | Overlaps daily SCA work; absorbed tfsec, so IaC + container + SBOM scanning all live here | Phases 1 & 3, daily ASPM |
| **Falco** | Runtime security; detection rules are an approachable first code contribution | Phase 3, K8s hardening playbook |
| **Kyverno** or **OPA/Gatekeeper** | Policy as code; every phase artifact uses admission policies | Phases 1 & 3, Pillar D |
| **Checkov** | Custom-policy experience from Phase 1 converts directly into upstream checks | Phase 1 artifact |

> ⭐ **Default recommendation: Trivy** — largest overlap with both the cert phases and day-job SCA work. (Note: **tfsec is not a target** — it's deprecated and merged into Trivy; contribute where the development actually happens.)

## Progression

- [ ] **Months 1–2:** docs fixes, issue triage, reproduce/confirm bugs — learn the contribution workflow and the maintainers' standards
- [ ] **Months 3–6:** first **merged code PR** — a detection rule (Falco), a policy (Kyverno), a check (Trivy/Checkov), or a small feature
- [ ] **Months 6–18:** recognized contributor — repeat PRs, review others' PRs, own an area (e.g. a scanner target or rule family)

## Ground rules
- [ ] Contribution time counts toward the quarterly artifact only when something **merges** or ships (a triaged-issues streak ≠ artifact)
- [ ] Every merged PR gets a one-paragraph note in the quarterly tracker — these become interview stories and talk seeds for [Pillar B](pillar-b-research-speaking.md)

---

_← [Pillars](README.md)_
