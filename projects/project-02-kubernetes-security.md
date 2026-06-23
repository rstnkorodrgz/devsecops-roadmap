# Project 02 — Kubernetes Security

> **Pairs with:** [Phase 2 / CKS](../phases/phase-2-cicd.md) · **Proves:** you can harden a cluster *and* detect attacks against it.

---

## Brief

Stand up a Kubernetes cluster (EKS from [Phase 1.5](../phases/phase-1.5-iac.md), or kind/k3s for cost) and take it from default to hardened, then prove the hardening works by attacking it.

## Two halves — both matter

### Harden (preventive)
- [ ] RBAC: least-privilege, no wildcard `cluster-admin` bindings, audited
- [ ] Pod Security: enforce restricted Pod Security Standards
- [ ] NetworkPolicy: default-deny, explicit allow-lists
- [ ] Admission control: Kyverno/Gatekeeper policies (no root, no `:latest`, signed images only, drop capabilities)
- [ ] Secrets: encrypted at rest (KMS), external secrets operator or sealed-secrets
- [ ] Supply chain: only signed images from an approved registry (ties to [Project 01](project-01-secure-cicd.md))
- [ ] CIS Kubernetes Benchmark via `kube-bench`; NSA/CISA hardening guide checklist

### Detect (runtime)
- [ ] Falco deployed with custom rules
- [ ] Audit logging enabled and shipped somewhere queryable
- [ ] Demonstrate detection: spawn a shell in a pod, read a secret, crypto-miner sim → show the Falco alert

## Acceptance criteria
- [ ] `kube-bench` run with findings triaged (fixed or justified)
- [ ] A documented "attack → detection" walk-through with screenshots
- [ ] `THREATMODEL.md` for the cluster (container escape, RBAC abuse, supply chain, lateral movement → MITRE ATT&CK for Containers mapping)
- [ ] Controls matrix mapped to NSA/CISA K8s Hardening Guide

## Stretch
- [ ] Multi-tenancy: two isolated tenants, prove cross-tenant access fails (ties to [Phase 3.5](../phases/phase-3.5-platform-engineering.md))
- [ ] Service mesh mTLS (Istio/Linkerd) with strict mode

## Tools
Kyverno/Gatekeeper · Falco · kube-bench · Trivy · NetworkPolicy · Cosign

---

_← [Projects](README.md)_
