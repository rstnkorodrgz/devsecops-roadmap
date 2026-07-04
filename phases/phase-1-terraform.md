# Phase 1 — Infrastructure as Code (Terraform)

> **Duration:** Months 1–3
> **Target Certification:** HashiCorp Terraform Associate (003) — **book the exam in Week 1** (execution rule)
> **Quarterly artifact:** Hardened Terraform module + custom Checkov policy set, published in this repo
> **Why first:** Terraform fluency is the baseline every later phase builds on — the Azure landing zone here is reused by Phases 3–5 and Pillar D. Skills are provider-portable: if the AWS elective ever activates, everything here transfers.

---

## 🗓️ Month 1 — Terraform Core

### Concepts
- [ ] Understand the Terraform workflow: `init` → `plan` → `apply` → `destroy`
- [ ] Learn state: local vs remote, why state is sensitive, state locking
- [ ] Master providers, resources, data sources, variables, outputs, locals
- [ ] Understand modules — composition, inputs/outputs, versioning, the registry
- [ ] Learn `for_each` vs `count` and when to use each
- [ ] Understand the dependency graph and `depends_on`
- [ ] Study workspaces vs directory-per-environment patterns
- [ ] Know that **OpenTofu** exists (the open-source fork, post-IBM acquisition of HashiCorp) — syntax-compatible; the cert target remains Terraform Associate, but some shops have migrated

### Hands-on Labs (Azure)
- [ ] Provision a resource group + storage account + RBAC role assignment with `azurerm` from scratch
- [ ] Move state to a remote **Azure Storage backend** (blob lease = state locking)
- [ ] Refactor repeated resources into a reusable module
- [ ] Write a module with validated input variables and meaningful outputs

---

## 🗓️ Month 2 — Terraform at Scale + Policy as Code

### Concepts
- [ ] Understand DRY infrastructure with **Terragrunt** (`terragrunt.hcl`, `include`, `dependency`)
- [ ] Learn environment isolation: dev / staging / prod state separation
- [ ] Study remote state data sources for cross-stack references
- [ ] Understand drift detection and `terraform plan` in CI
- [ ] Learn secrets handling: never commit secrets — Azure Key Vault + `azurerm_key_vault_secret` data sources
- [ ] Study the "least-privilege CI runner" pattern: GitHub Actions **OIDC → Entra ID workload identity federation** (no client secrets)
- [ ] Understand **Checkov** — policy packs, custom checks, baselines, suppressions
- [ ] Understand **Trivy** (`trivy config`) — IaC misconfiguration scanning (successor to the deprecated tfsec)
- [ ] Learn **OPA / Rego** fundamentals and **Conftest** against plan JSON
- [ ] Understand *preventive* (policy gate) vs *detective* (drift/scan) controls

### Hands-on Labs
- [ ] Build a 3-environment layout with Terragrunt (dev/staging/prod)
- [ ] Wire GitHub Actions to Azure via **OIDC federated credentials** (zero static secrets)
- [ ] Add a `terraform plan` comment-on-PR workflow
- [ ] Run Checkov against the repo, triage every finding
- [ ] Write **three custom Checkov checks** (e.g. "all storage accounts deny public blob access", "all Key Vaults have purge protection", "no NSG rule allows 0.0.0.0/0 inbound")
- [ ] Write one Rego policy + run it with Conftest against a plan JSON
- [ ] Gate the pipeline: fail the PR on HIGH/CRITICAL IaC findings; document one justified suppression

---

## 🗓️ Month 3 — Capstone: Secure Azure Landing Zone + Exam

Build the foundation reused by every later phase.

```
Terraform / Terragrunt  (remote state in Azure Storage, locked)
        ↓
   Hub-spoke VNets (NSGs, Private Endpoints, no public ingress by default)
        ↓
   AKS cluster (private API server, workload identity, Azure Policy add-on)
        ↓
   Key Vault (RBAC mode, purge protection) · Defender for Cloud enabled
        ↓
   GitHub Actions (OIDC, plan/apply, Checkov + trivy config gates)
```

### 📦 Quarterly artifact (Q1)
- [ ] Versioned Terraform modules for VNet + AKS in a public repo
- [ ] **Custom Checkov policy set** shipped alongside the module
- [ ] CI pipeline: `fmt` → `validate` → `plan` → Checkov → `trivy config` → manual approve → `apply`
- [ ] A `SECURITY.md` documenting the controls enforced by the pipeline
- [ ] Architecture diagram (`.png` + source) committed to the repo

### 🎓 Terraform Associate (003) exam milestone
- [ ] Work through the official HashiCorp exam review guide — flag weak objectives
- [ ] Complete two full practice exams (e.g. Bryan Krausen's on Udemy) at 85%+
- [ ] ✅ **PASS HashiCorp Terraform Associate (003)** _(exam was booked in Week 1)_

---

## 🧰 Tools
- [ ] `terraform` (via `hashicorp/tap`) · `terragrunt` · `tflint` (GitHub releases)
- [ ] `checkov` · `trivy` (`trivy config`) · `opa` + `conftest`
- [ ] `az` CLI · `infracost` (cost-aware reviews — bonus)

## 📚 Resources
- HashiCorp **Terraform Associate (003)** study guide + HashiCorp Learn track (free)
- *Terraform: Up & Running* (3rd Ed.) — Yevgeniy Brikman
- Checkov docs → custom policies guide · OPA Rego Playground
- Azure landing zone docs (Cloud Adoption Framework) — design-level reference

---

_← [Phase 0](phase-0-foundation.md) | [Back to README](../README.md) | [Phase 2 (CKA) →](phase-2-cka.md)_
