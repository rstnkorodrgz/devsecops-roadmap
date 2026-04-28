# Phase 3 — Advanced AppSec & Threat Modeling

> **Duration:** Months 6–8 (12 weeks)  
> **Target Certifications:** GIAC GWEB + GCP Professional Cloud Security Engineer  
> **Accelerated by:** SonicWall DPI experience → service mesh observability

---

## 📊 Phase Progress

Count your checked boxes and update the README table.

`Week 1–3` `Week 4–6` `Week 7–9` `Week 10–12`

---

## 🗓️ Weeks 1–3 — Advanced Threat Modeling

### Concepts
- [ ] Understand PASTA (Process for Attack Simulation & Threat Analysis) — all 7 stages
- [ ] Understand LINDDUN — privacy-focused threat modeling framework
- [ ] Learn how to run a threat modeling session in a sprint team setting
- [ ] Study architecture risk analysis (ARA) — how to quantify architectural risks
- [ ] Learn Threagile — automated threat modeling as code (YAML-based)
- [ ] Understand attack trees — how to construct and use them
- [ ] Study red team vs threat modeling — complementary, not competing
- [ ] Learn how to write a threat model document (assets, threats, mitigations, residual risk)
- [ ] Study CVSS v3.1 scoring — how to score vulnerabilities accurately
- [ ] Understand DREAD — alternative risk scoring (Damage, Reproducibility, Exploitability, Affected users, Discoverability)

### Hands-on Labs
- [ ] Model a realistic 3-tier SaaS application using STRIDE end-to-end
- [ ] Apply PASTA to the same application — compare outputs vs STRIDE
- [ ] Install and run Threagile on a sample architecture YAML file
- [ ] Write a complete threat model document for an API you know well
- [ ] Build an attack tree for an AWS S3 data exfiltration scenario
- [ ] Run OWASP Threat Dragon and export findings as JSON

### Tools to install (see [`../tools/macos-setup.md`](../tools/macos-setup.md))
- [ ] `threagile` (threat modeling as code)
- [ ] OWASP Threat Dragon (Electron app — download from GitHub releases)
- [ ] `drawio` desktop app (architecture diagramming)

---

## 🗓️ Weeks 4–6 — Cloud-Native AppSec & API Security

### Concepts
- [ ] Study OWASP API Security Top 10 (2023 edition) — know every category deeply
- [ ] Understand API authentication patterns — OAuth 2.0, OIDC, API keys, mTLS
- [ ] Learn service mesh security with Istio — mTLS, AuthorizationPolicies, PeerAuthentication
- [ ] Study SPIFFE/SPIRE — workload identity for zero-trust environments
- [ ] Understand JWT security — algorithm confusion, none algorithm, key confusion attacks
- [ ] Learn GraphQL security — introspection abuse, batching attacks, depth limiting
- [ ] Study WAF rules and bypass techniques — SQL injection, XSS, path traversal
- [ ] Understand rate limiting and DDoS patterns at the API layer
- [ ] Learn OWASP WSTG (Web Security Testing Guide) — testing methodology

### Hands-on Labs
- [ ] Set up a deliberately vulnerable API (vAPI or crAPI) and exploit OWASP API Top 10
- [ ] Install Istio on your local kind cluster and enforce mTLS between services
- [ ] Write an Istio AuthorizationPolicy that restricts service-to-service communication
- [ ] Deploy SPIRE in a local cluster and issue SVIDs to workloads
- [ ] Exploit a JWT none-algorithm vulnerability in a lab environment (jwt_tool)
- [ ] Set up an OWASP ZAP active scan against a local API and triage findings
- [ ] Write a WAF rule in AWS WAF to block a specific injection pattern

### Tools to install
- [ ] `jwt_tool` (JWT testing — Python)
- [ ] `ffuf` (web fuzzer)
- [ ] `nuclei` (vulnerability scanner — template-based)
- [ ] `katana` (web crawler for attack surface mapping)
- [ ] OWASP ZAP (GUI + CLI)
- [ ] `httpie` (API testing CLI)
- [ ] `istioctl` (Istio CLI)

---

## 🗓️ Weeks 7–9 — Multi-Cloud Security & CSPM

### Concepts
- [ ] Understand Cloud Security Posture Management (CSPM) — what it detects, how it differs from CSEM
- [ ] Study Wiz security graph — how it correlates findings across cloud layers
- [ ] Learn Prisma Cloud / Orca Security concepts (even if you don't have access — understand what they do)
- [ ] Understand multi-cloud IAM federation — AWS IAM Identity Center, GCP Workload Identity Federation
- [ ] Study Azure Defender for Cloud — Secure Score, recommendations, alerts
- [ ] Learn GCP Security Command Center — findings, assets, compliance reports
- [ ] Understand policy-as-code at scale — Open Policy Agent in enterprise contexts
- [ ] Study infrastructure drift detection — Terraform Cloud sentinel policies, Checkov
- [ ] Learn security champions program design — how to build and sustain one

### Hands-on Labs
- [ ] Run Checkov against a Terraform AWS project and remediate findings
- [ ] Set up a free GCP account and enable Security Command Center standard tier
- [ ] Use `steampipe` to query resources across AWS for misconfigurations
- [ ] Write an OPA Rego policy that validates Terraform plan output
- [ ] Set up Prowler v3 for a multi-account AWS environment scan
- [ ] Create a security champions onboarding checklist for a fictional team

### Tools to install
- [ ] `checkov` (IaC security scanner — Python)
- [ ] `tfsec` (Terraform security scanner)
- [ ] `terrascan` (multi-cloud IaC scanner)
- [ ] `gcloud` CLI (GCP — for GCP Security Engineer cert)
- [ ] `az` CLI (Azure CLI — for multi-cloud awareness)

---

## 🗓️ Weeks 10–12 — GWEB Exam Prep & Bug Bar

### Concepts
- [ ] Review all GWEB exam domains: web app security, testing, defense
- [ ] Study secure SDLC — how to embed security at each stage
- [ ] Understand bug bar definition — how to define severity thresholds and SLAs
- [ ] Learn penetration testing methodology (PTES, OWASP WSTG)
- [ ] Review XSS (all types), CSRF, SSRF, XXE, IDOR, Insecure Deserialization deeply
- [ ] Study secure code review methodology — what to look for in code, tooling vs manual

### Exam Prep
- [ ] Complete GIAC practice exam — GWEB domain 1
- [ ] Complete GIAC practice exam — GWEB domain 2
- [ ] Build a personal GWEB cheat sheet / index (GIAC is open-book)
- [ ] Score 80%+ on two full GIAC practice tests
- [ ] Schedule GWEB exam
- [ ] ✅ **PASS GIAC GWEB — Web Application Defender**

### GCP Security Engineer (Optional / Parallel)
- [ ] Complete Google Cloud Skills Boost — Security Engineer learning path
- [ ] Pass GCP Professional Cloud Security Engineer exam
- [ ] ✅ **PASS GCP Professional Cloud Security Engineer** _(optional)_

---

## 📚 Phase 3 Resources

| Resource | Type | Priority |
|---|---|---|
| "The Web Application Hacker's Handbook" | Book | ⭐⭐⭐ |
| PortSwigger Web Security Academy (free) | Labs | ⭐⭐⭐ |
| GIAC GWEB Course (SANS SEC542 or self-study) | Course | ⭐⭐⭐ |
| OWASP API Security Top 10 (owasp.org) | Free | ⭐⭐⭐ |
| crAPI — Completely Ridiculous API (lab) | Lab | ⭐⭐⭐ |
| Istio Security Documentation | Reference | ⭐⭐ |
| Google Cloud Security Best Practices | Free | ⭐⭐ |

---

## ✅ Phase 3 Completion Checklist

- [ ] All weekly concept boxes checked
- [ ] All hands-on labs completed
- [ ] All Phase 3 tools installed and tested
- [ ] GWEB exam passed
- [ ] Complete threat model document written for a real or realistic system
- [ ] Multi-cloud IaC scanning pipeline built (Checkov + tfsec)
- [ ] Weekly log entries written for all 12 weeks

---

_← [Phase 2](phase-2-cicd.md) | [Back to README](../README.md) | [Phase 4 →](phase-4-cissp.md)_
