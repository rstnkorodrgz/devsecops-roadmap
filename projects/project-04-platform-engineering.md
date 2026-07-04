# Project 04 — Platform Engineering (Paved Road)

> **Pairs with:** [Platform track](../tracks/platform-engineering.md) + [Pillar D](../pillars/pillar-d-architecture.md) · **Proves:** you can make the secure path the default — the core architect capability.

---

## Brief

Build a self-service "paved road" so a developer can go from *nothing* to a *running, secure service* without filing a ticket or hand-wiring security. The point is not the tooling — it's that **security controls become defaults**.

## Architecture

```
Developer ─► Backstage scaffolder ("New Service")
                 ↓ generates a repo with:
                   - CI security gates pre-wired (SAST/SCA/secret scan)
                   - SBOM + image signing steps
                   - Dependabot/Renovate config
                   - default-deny NetworkPolicy + restricted PSS
                 ↓
            GitOps (Argo CD) ─► EKS
                 ↓ guardrails:
            Kyverno admission (signed images, no root, approved registry)
```

## Acceptance criteria
- [ ] A working Backstage scaffolder template that generates a new service repo
- [ ] The generated service ships **secure by default** — list every control that's automatic
- [ ] GitOps deploys it; admission control rejects a non-compliant variant (demonstrate the rejection)
- [ ] A "paved road" design doc (ties to [`architect/platform-engineering.md`](../architect/platform-engineering.md)) listing each gate→default conversion
- [ ] Time-to-first-secure-deploy measured and recorded

## Stretch
- [ ] Self-service infra via Crossplane or a Terraform module exposed through the catalog
- [ ] A scorecard surfaced in Backstage (ownership, scan status, SLOs)

## Tools
Backstage · Argo CD · Kyverno · Helm/Kustomize · GitHub Actions

---

_← [Projects](README.md)_
