# Phase 3.5 — Platform Engineering & Paved Roads

> **Duration:** Weeks 41–44 (bridges AppSec → Architect track)
> **Target outcome:** A working Internal Developer Platform (IDP) slice that makes the *secure* path the *easy* path.
> **Why this phase exists:** This is the bridge from Senior → Architect. Architect interviews increasingly center on self-service platforms, golden paths, and multi-tenancy — not on running scanners.

---

## 📊 Phase Progress

`Week 41` `Week 42` `Week 43` `Week 44`

---

## 🗓️ Week 41 — Platform Engineering Foundations

### Concepts
- [ ] Understand the **Internal Developer Platform (IDP)** model vs "DevOps team as ticket queue"
- [ ] Learn **golden paths / paved roads** — opinionated, secure-by-default templates
- [ ] Study **Team Topologies** (stream-aligned, platform, enabling teams)
- [ ] Understand the platform-as-product mindset (developers are your customers)
- [ ] Learn the difference between *guardrails* (can't do the wrong thing) and *guidelines* (shouldn't)
- [ ] Study **DORA metrics** and how platform work moves them

### Hands-on
- [ ] Write a one-page "paved road" definition for one workload type (e.g. a Go microservice)
- [ ] Map every manual security step a developer hits today → candidate for automation

---

## 🗓️ Week 42 — Backstage & Service Catalogs

### Concepts
- [ ] Understand **Backstage** — software catalog, TechDocs, scaffolder templates
- [ ] Learn `catalog-info.yaml` and component/ownership modeling
- [ ] Study **software templates** (scaffolder) for self-service repo creation
- [ ] Understand how to surface security signal in the catalog (scorecards, ownership, SLOs)

### Hands-on
- [ ] Run Backstage locally
- [ ] Register 2–3 components in the catalog
- [ ] Build a scaffolder template that generates a new service **with security baked in**: pre-commit hooks, CI security gates, SBOM step, Dependabot config

---

## 🗓️ Week 43 — Self-Service Infrastructure & GitOps

### Concepts
- [ ] Understand **GitOps** (Argo CD / Flux) — desired state in Git, reconciliation
- [ ] Learn **Crossplane** / Terraform modules as self-service infrastructure APIs
- [ ] Study secure-by-default Helm charts / Kustomize bases
- [ ] Understand progressive delivery (canary, blue/green) and its security implications
- [ ] Learn admission control as a guardrail (Kyverno / OPA Gatekeeper) — link to [Phase 2 CKS](phase-2-cicd.md)

### Hands-on
- [ ] Stand up Argo CD against your EKS cluster from Phase 1.5
- [ ] Deploy an app via GitOps with a signed image gate (link to Cosign / supply chain)
- [ ] Enforce a Kyverno policy: "no container runs as root, all images from approved registry"

---

## 🗓️ Week 44 — Kubernetes Multi-Tenancy

### Concepts
- [ ] Understand soft vs hard multi-tenancy
- [ ] Learn namespace-per-team isolation: RBAC, ResourceQuotas, LimitRanges, NetworkPolicy
- [ ] Study **vCluster** and **Capsule** for stronger tenant isolation
- [ ] Understand node isolation (taints/tolerations, separate node groups) for sensitive workloads
- [ ] Learn how policy (Kyverno/Gatekeeper) enforces per-tenant guardrails at scale

### Hands-on
- [ ] Build a 2-tenant cluster: isolated namespaces, default-deny NetworkPolicy, quotas
- [ ] Prove tenant A cannot reach tenant B's pods or read its secrets
- [ ] Document the tenancy model as a reference architecture → feeds [`architect/reference-architectures.md`](../architect/reference-architectures.md)

---

## 🧰 Tools
- [ ] `kubectl`, `helm`, `kustomize`
- [ ] Backstage (Node.js)
- [ ] Argo CD CLI (`argocd`) or `flux`
- [ ] `kyverno` CLI / OPA Gatekeeper
- [ ] `vcluster` (optional, multi-tenancy deep-dive)

---

## 📚 Resources
- *Team Topologies* — Skelton & Pais
- Backstage docs (backstage.io) — Software Templates section
- CNCF Platforms Working Group — "Platforms White Paper"
- Argo CD / Kyverno official docs

---

_← [Phase 3](phase-3-appsec.md) | [Architect Track →](../architect/README.md)_
