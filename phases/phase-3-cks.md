# Phase 3 — CI/CD, Containers & Kubernetes Security (CKS)

> **Duration:** Months 7–9
> **Target Certification:** CKS — Certified Kubernetes Security Specialist ★ **the key differentiator cert of this ladder**. Requires the active CKA from Phase 2. **Book the exam at the start of the phase.**
> **Quarterly artifact:** Kubernetes hardening playbook, mapped to the CIS Kubernetes Benchmark
> **Accelerated by:** networking background → CNI & NetworkPolicy; daily CI/CD security work → pipeline content is partly review

---

## 🗓️ Month 7 — Secure CI/CD & Supply Chain

### Concepts
- [ ] Understand SAST / DAST / SCA — how each works, what it finds, limitations
- [ ] Learn the SLSA v1.0 supply chain framework — Build track levels L0–L3 and what each requires
- [ ] Study artifact signing with Sigstore / Cosign — including **keyless** (Fulcio + Rekor)
- [ ] Understand SBOM — formats (CycloneDX, SPDX), generation, consumption
- [ ] Learn GitHub Actions hardening — token scoping, pinning actions by SHA, OIDC
- [ ] Understand **provenance & attestations** — in-toto, SLSA provenance, what an attestation proves
- [ ] **Verify at deploy time**, not just sign at build time — admission rejects unsigned/unattested images (Kyverno `verifyImages` / sigstore policy-controller)
- [ ] Study real supply-chain attacks (SolarWinds, `event-stream`, XZ Utils, dependency confusion) and which control would have stopped each
- [ ] Dependency integrity — lockfiles, pinning, hash verification, private registry + allow-list
- [ ] Map your controls to **SLSA v1.0 Build levels** and **NIST SSDF "PS" practices** ([architect/secure-sdlc.md](../architect/secure-sdlc.md))

### Hands-on Labs
- [ ] Build a GitHub Actions pipeline with Semgrep (SAST) + Trivy (SCA) — fail on HIGH/CRITICAL
- [ ] Set up Gitleaks pre-commit hook; generate an SBOM with Syft; sign the image with Cosign (keyless) and verify in CI
- [ ] Pin all GitHub Actions to commit SHAs in an existing workflow

---

## 🗓️ Month 8 — Container & Kubernetes Hardening

### Concepts
- [ ] Container image attack surface — layers, registries, runtime
- [ ] Dockerfile security — multi-stage builds, non-root, read-only FS, distroless/Chainguard bases
- [ ] Linux capabilities, seccomp, AppArmor — what to drop and why
- [ ] Kubernetes RBAC — least privilege, no wildcard `cluster-admin`
- [ ] Pod Security Standards via **Pod Security Admission** (PSP was removed in K8s 1.25)
- [ ] NetworkPolicy — default-deny + explicit allow patterns
- [ ] Admission control — OPA Gatekeeper and Kyverno policies
- [ ] etcd encryption at rest; secrets management (External Secrets Operator / Key Vault CSI)
- [ ] Falco — rule syntax, syscall monitoring, audit log integration

### Hands-on Labs
- [ ] Refactor a Dockerfile: non-root, multi-stage, distroless — compare Trivy CVE counts before/after
- [ ] On a kind cluster: enforce Restricted PSA, default-deny NetworkPolicy, and a Kyverno policy requiring signed images
- [ ] Deploy Falco; trigger and document detections (shell in pod, read `/etc/shadow`, crypto-miner sim)
- [ ] Run `kube-bench`; triage every finding (fix or justify)

---

## 🗓️ Month 9 — CKS Exam & Artifact

### Exam Prep
- [ ] Review all CKS domains: Cluster Setup, Hardening, System Hardening, Minimize Microservice Vulnerabilities (securityContext, **Pod Security Admission**), Supply Chain, Monitoring/Runtime
- [ ] Complete killer.sh CKS simulator — both sessions
- [ ] ✅ **PASS CKS — Certified Kubernetes Security Specialist**

### 📦 Quarterly artifact (Q3)
- [ ] **Kubernetes hardening playbook** (public): every hardening control applied, mapped to CIS Kubernetes Benchmark + NSA/CISA guide sections, with a documented **attack → detection walkthrough** (screenshots of Falco alerts)

---

## 🧰 Tools
- [ ] `semgrep` · `trivy` · `gitleaks` · `syft` · `cosign` · `grype`
- [ ] `hadolint` · `dockle` · `dive` · `docker-bench-security`
- [ ] `kube-bench` · `kubescape` · `falco` (Helm) · `kyverno` / `opa`

## 📚 Resources
- Killer.sh CKS Simulator · KodeKloud CKS Course
- *Container Security* — Liz Rice · CNCF Security Whitepaper
- NSA/CISA Kubernetes Hardening Guide

---

_← [Phase 2](phase-2-cka.md) | [Back to README](../README.md) | [Phase 4 (SC-500) →](phase-4-sc500.md)_
