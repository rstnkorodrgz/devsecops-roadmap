# Phase 2 — CI/CD Pipeline & Container Security

> **Duration:** Months 3–5 (12 weeks)  
> **Target Certification:** CKS — Certified Kubernetes Security Specialist  
> **Accelerated by:** Networking knowledge → Kubernetes CNI & NetworkPolicy

---

## 📊 Phase Progress

Count your checked boxes and update the README table.

`Week 1–3` `Week 4–6` `Week 7–9` `Week 10–12`

---

## 🗓️ Weeks 1–3 — Secure CI/CD Pipelines

### Concepts
- [ ] Understand SAST (Static Analysis) — how it works, what it finds, limitations
- [ ] Understand DAST (Dynamic Analysis) — how it works, when to run it
- [ ] Understand SCA (Software Composition Analysis) — dependency vulnerability scanning
- [ ] Learn SLSA supply chain security framework — levels 1 through 4
- [ ] Study artifact signing with Sigstore / Cosign
- [ ] Understand SBOM (Software Bill of Materials) — formats (CycloneDX, SPDX), generation, consumption
- [ ] Learn GitHub Actions security hardening — token scoping, pinning actions by SHA
- [ ] Study GitLab CI/CD security — protected branches, masked variables, runner isolation
- [ ] Understand secret scanning in pipelines — prevention vs detection
- [ ] Learn Dependabot / Renovate for automated dependency updates

### Hands-on Labs
- [ ] Build a GitHub Actions pipeline with Semgrep (SAST) integrated
- [ ] Add OWASP ZAP (DAST) scan to a test pipeline against a local DVWA container
- [ ] Integrate Trivy SCA scan into a pipeline — fail on HIGH/CRITICAL CVEs
- [ ] Set up Gitleaks pre-commit hook to block secret commits
- [ ] Generate an SBOM with Syft for a sample Docker image
- [ ] Sign a container image with Cosign and verify the signature in CI
- [ ] Pin all GitHub Actions to commit SHAs in an existing workflow
- [ ] Set up Dependabot alerts and auto-PRs on a sample repo

### Tools to install (see [`../tools/macos-setup.md`](../tools/macos-setup.md))
- [ ] `semgrep` (SAST scanner)
- [ ] `trivy` (container + SCA scanner)
- [ ] `gitleaks` (secret scanner)
- [ ] `syft` (SBOM generator)
- [ ] `cosign` (artifact signing — Sigstore)
- [ ] `grype` (vulnerability scanner)
- [ ] Docker Desktop (if not installed)

---

## 🗓️ Weeks 4–6 — Container Image Security

### Concepts
- [ ] Understand the container image attack surface — layers, registries, runtime
- [ ] Learn Dockerfile security best practices — multi-stage builds, non-root user, read-only FS
- [ ] Study distroless and minimal base images — Google distroless, Alpine, Chainguard
- [ ] Understand image vulnerability scanning — CVE databases, CVSS scoring, exploitability
- [ ] Learn container runtime security — seccomp profiles, AppArmor, capabilities
- [ ] Study Linux capabilities — what CAP_NET_ADMIN, CAP_SYS_ADMIN grant and why to drop them
- [ ] Understand rootless containers — how they work and when to use them
- [ ] Learn private container registry security — ECR scanning, image signing policies

### Hands-on Labs
- [ ] Refactor a sample Dockerfile to use non-root user, multi-stage build, read-only filesystem
- [ ] Scan the refactored image with Trivy — compare CVE count before/after
- [ ] Build the same app on a distroless base and compare image size + vulnerabilities
- [ ] Apply a seccomp profile to a running container and verify blocked syscalls
- [ ] Use Docker Bench for Security to audit your local Docker configuration
- [ ] Set up ECR with image scanning on push enabled
- [ ] Drop all capabilities from a container except those explicitly needed

### Tools to install
- [ ] `docker-bench-security` (Docker security auditor)
- [ ] `dive` (inspect Docker image layers)
- [ ] `hadolint` (Dockerfile linter)
- [ ] `dockle` (container image linter)

---

## 🗓️ Weeks 7–9 — Kubernetes Security

### Concepts
- [ ] Understand Kubernetes RBAC — Roles, ClusterRoles, Bindings, ServiceAccounts
- [ ] Learn Pod Security Standards — Privileged / Baseline / Restricted profiles
- [ ] Study Kubernetes NetworkPolicy — ingress/egress rules, default-deny pattern
- [ ] Understand admission controllers — ValidatingWebhookConfiguration, MutatingWebhookConfiguration
- [ ] Learn OPA Gatekeeper — ConstraintTemplates, Rego policy language basics
- [ ] Learn Kyverno — alternative to OPA, Kubernetes-native policies
- [ ] Study etcd security — encryption at rest, access controls
- [ ] Understand Kubernetes secrets management — native secrets vs external (Vault, ESO)
- [ ] Learn Falco — rule syntax, syscall monitoring, Kubernetes audit log integration
- [ ] Study the CKS exam domains and their weights

### Hands-on Labs
- [ ] Set up a local Kubernetes cluster with `kind` or `minikube`
- [ ] Create RBAC roles that give a service account read-only pod access in one namespace only
- [ ] Enforce Pod Security Standards via namespace labels (Restricted profile)
- [ ] Write a NetworkPolicy that implements default-deny + allow only specific ingress
- [ ] Install OPA Gatekeeper and write a policy that blocks privileged containers
- [ ] Install Kyverno and write a policy that requires all images to be signed
- [ ] Deploy Falco and trigger a rule by running `cat /etc/shadow` inside a pod
- [ ] Encrypt Kubernetes secrets at rest in etcd
- [ ] Use `kube-bench` to audit cluster against CIS Kubernetes Benchmark

### Tools to install
- [ ] `kubectl` (Kubernetes CLI)
- [ ] `kind` (local Kubernetes clusters)
- [ ] `helm` (Kubernetes package manager)
- [ ] `kube-bench` (CIS Kubernetes Benchmark auditor)
- [ ] `kube-hunter` (Kubernetes penetration testing)
- [ ] `kubescape` (Kubernetes security scanner)
- [ ] `falco` (runtime security — install via Helm in cluster)
- [ ] `opa` (Open Policy Agent CLI)

---

## 🗓️ Weeks 10–12 — Supply Chain & CKS Exam Prep

### Concepts
- [ ] Review SLSA framework levels in depth — what attestations are required at each level
- [ ] Understand in-toto framework for software supply chain security
- [ ] Study Kubernetes audit logging — policy configuration, log analysis
- [ ] Learn image admission control — only allow signed/scanned images from approved registries
- [ ] Review all CKS exam domains: Cluster Setup, Hardening, Supply Chain, Runtime, Monitoring
- [ ] Study minimize microservice vulnerabilities domain (securityContext, PodSecurityPolicy migration)

### Exam Prep
- [ ] Complete killer.sh CKS simulator (comes with exam purchase) — Session 1
- [ ] Complete killer.sh CKS simulator — Session 2
- [ ] Time yourself on 5 complete hands-on scenarios under 2 hours
- [ ] Review all Kubernetes security documentation from k8s.io/docs
- [ ] Schedule CKS exam (online proctored — have your environment ready)
- [ ] ✅ **PASS CKS — Certified Kubernetes Security Specialist**

---

## 📚 Phase 2 Resources

| Resource | Type | Priority |
|---|---|---|
| Killer.sh CKS Simulator | Practice | ⭐⭐⭐ |
| "Container Security" — Liz Rice (O'Reilly) | Book | ⭐⭐⭐ |
| KodeKloud CKS Course | Course | ⭐⭐⭐ |
| CNCF Security Whitepaper | Free PDF | ⭐⭐⭐ |
| Sysdig Falco Documentation | Reference | ⭐⭐ |
| Aqua Security Blog | Reference | ⭐⭐ |
| NeuVector / StackRox docs | Reference | ⭐ |

---

## ✅ Phase 2 Completion Checklist

- [ ] All weekly concept boxes checked
- [ ] All hands-on labs completed
- [ ] All Phase 2 tools installed and tested
- [ ] CKS exam passed
- [ ] At least one full pipeline (SAST + SCA + image scan + sign) built end-to-end
- [ ] Weekly log entries written for all 12 weeks

---

_← [Phase 1](phase-1-cloud.md) | [Back to README](../README.md) | [Phase 3 →](phase-3-appsec.md)_
