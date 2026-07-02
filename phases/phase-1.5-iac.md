# Phase 1.5 — Infrastructure as Code & Policy as Code

> **Duration:** Weeks 9–12 (bridges Phase 1 → Phase 2)
> **Target Certification:** HashiCorp Terraform Associate (003)
> **Why this phase exists:** Almost every Senior DevSecOps role expects Terraform fluency. You cannot secure infrastructure you cannot provision, and you cannot scale security reviews without policy as code.

---

## 📊 Phase Progress

Count your checked boxes and update the README table.

`Week 9` `Week 10` `Week 11` `Week 12`

---

## 🗓️ Week 9 — Terraform Core

### Concepts
- [ ] Understand the Terraform workflow: `init` → `plan` → `apply` → `destroy`
- [ ] Learn state: local vs remote, why state is sensitive, state locking
- [ ] Master providers, resources, data sources, variables, outputs, locals
- [ ] Understand modules — composition, inputs/outputs, versioning, the registry
- [ ] Learn `for_each` vs `count` and when to use each
- [ ] Understand the dependency graph and `depends_on`
- [ ] Study workspaces vs directory-per-environment patterns
- [ ] Know that **OpenTofu** exists (the open-source fork, post-IBM acquisition of HashiCorp) — syntax-compatible; the cert target remains Terraform Associate, but some shops have migrated

### Hands-on Labs
- [ ] Provision a single AWS S3 bucket + IAM policy from scratch
- [ ] Move state to a remote S3 backend with DynamoDB state locking
- [ ] Refactor repeated resources into a reusable module
- [ ] Write a module with validated input variables and meaningful outputs

---

## 🗓️ Week 10 — Terraform at Scale (Terragrunt + Patterns)

### Concepts
- [ ] Understand DRY infrastructure with **Terragrunt** (`terragrunt.hcl`, `include`, `dependency`)
- [ ] Learn environment isolation: dev / staging / prod state separation
- [ ] Study remote state data sources for cross-stack references
- [ ] Understand drift detection and `terraform plan` in CI
- [ ] Learn secrets handling: never commit secrets, use SSM/Secrets Manager/Vault
- [ ] Study the "least-privilege CI runner" pattern (OIDC, no long-lived keys)

### Hands-on Labs
- [ ] Build a 3-environment layout with Terragrunt (dev/staging/prod)
- [ ] Wire GitHub Actions to assume an AWS role via **OIDC** (no static keys)
- [ ] Add a `terraform plan` comment-on-PR workflow
- [ ] Detect and remediate intentional drift in a deployed resource

---

## 🗓️ Week 11 — Policy as Code & IaC Security Scanning

### Concepts
- [ ] Understand **Checkov** — policy packs, custom checks, baselines, suppressions
- [ ] Understand **Trivy** (`trivy config`) — Terraform misconfiguration scanning (successor to the now-deprecated tfsec; legacy tfsec rule IDs map to Trivy AVD IDs)
- [ ] Learn **OPA / Rego** fundamentals and **Conftest** for arbitrary config
- [ ] Study **Sentinel** (Terraform Cloud/Enterprise) at a conceptual level
- [ ] Understand the difference between *preventive* (policy gate) and *detective* (drift/scan) controls
- [ ] Learn how to write a custom Checkov policy and a custom Rego rule

### Hands-on Labs
- [ ] Run Checkov against your Terragrunt repo, triage every finding
- [ ] Write one custom Checkov check (e.g. "all S3 buckets must have logging")
- [ ] Write one Rego policy + run it with Conftest against a plan JSON
- [ ] Gate a GitHub Actions pipeline: fail the PR on HIGH/CRITICAL IaC findings
- [ ] Produce a documented suppression with justification for one false positive

---

## 🗓️ Week 12 — Capstone Mini-Project: Secure AWS Landing Zone

Build the foundation you'll reuse in [Project 03](../projects/project-03-cloud-security.md) and the [Capstone](../projects/project-05-devsecops-capstone.md).

```
Terraform / Terragrunt
        ↓
   AWS VPC (multi-AZ, private subnets, flow logs)
        ↓
   EKS cluster (private endpoint, IRSA)
        ↓
   GitHub Actions (OIDC, plan/apply, Checkov gate)
```

### Deliverables
- [ ] Versioned Terraform modules for VPC + EKS in a public repo
- [ ] Remote state with locking and encrypted backend
- [ ] CI pipeline: `fmt` → `validate` → `plan` → Checkov → `trivy config` → manual approve → `apply`
- [ ] A `SECURITY.md` documenting the controls enforced by the pipeline
- [ ] Architecture diagram (`.png` + source) committed to the repo

### 🎓 Terraform Associate (003) exam milestone
- [ ] Work through the official HashiCorp exam review guide — flag weak objectives
- [ ] Complete two full practice exams (e.g. Bryan Krausen's on Udemy) at 85%+
- [ ] Schedule the exam (online proctored, 60 min, ~57 questions)
- [ ] ✅ **PASS HashiCorp Terraform Associate (003)**

---

## 🧰 Tools to install (see [`../tools/macos-setup.md`](../tools/macos-setup.md))
- [ ] `terraform` (via `hashicorp/tap`)
- [ ] `terragrunt`
- [ ] `checkov`
- [ ] `trivy` (`trivy config` replaces the deprecated `tfsec`)
- [ ] `opa` + `conftest`
- [ ] `tflint`
- [ ] `infracost` (cost-aware reviews — bonus)

---

## 📚 Resources
- HashiCorp **Terraform Associate (003)** study guide — official
- *Terraform: Up & Running* — Yevgeniy Brikman (the Terragrunt author)
- Checkov docs → custom policies guide
- OPA / Rego "Policy Language" docs + the Rego Playground

---

_← [Phase 1](phase-1-cloud.md) | [Phase 2 →](phase-2-cicd.md)_
