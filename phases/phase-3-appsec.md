# Phase 3 — Advanced AppSec, Threat Modeling & AI Security

> **Duration:** Weeks 29–40 (12 weeks)  
> **Primary outcome:** **PortSwigger Web Security Academy** completion (practical, free, employer-recognized) + a full **Threat Model Report** for your capstone.  
> **Optional certs:** GCP Professional Cloud Security Engineer; GIAC GWEB *only if your employer pays* — see the [GWEB note](#-note-on-gweb).  
> **Accelerated by:** SonicWall DPI experience → service mesh observability

> 🔁 **Roadmap v1.2 change:** GWEB was demoted from a required cert to optional. Market demand for cloud-native + Kubernetes security (AWS Sec, CKS) is higher than for GWEB alone, and PortSwigger gives you the same web-AppSec depth, hands-on and free. See [Recommendation #6 rationale in the README](../README.md#-whats-new-in-v12).

---

## 📊 Phase Progress

Count your checked boxes and update the README table.

`Weeks 29–31` `Weeks 32–34` `Weeks 35–37` `Weeks 38–40`

---

## 🗓️ Weeks 29–31 — Advanced Threat Modeling

### Concepts
- [ ] Master **STRIDE** — the six categories, per-element application, and its limits
- [ ] Understand PASTA (Process for Attack Simulation & Threat Analysis) — all 7 stages
- [ ] Learn **MITRE ATT&CK** — tactics vs techniques, how to map threats to real adversary TTPs
- [ ] Learn **MITRE ATT&CK for Containers/Cloud** — relevant matrices for this roadmap
- [ ] Understand LINDDUN — privacy-focused threat modeling framework
- [ ] Learn how to run a threat modeling session in a sprint team setting
- [ ] Study architecture risk analysis (ARA) — how to quantify architectural risks
- [ ] Learn Threagile — automated threat modeling as code (YAML-based)
- [ ] Understand attack trees — how to construct and use them
- [ ] Study red team vs threat modeling — complementary, not competing
- [ ] Learn how to write a threat model document (assets, threats, mitigations, residual risk)
- [ ] Study CVSS scoring — v3.1 (still what most scanners emit) **and v4.0** (new threat/environmental metrics, supplemental attributes)
- [ ] Understand DREAD — alternative risk scoring (Damage, Reproducibility, Exploitability, Affected users, Discoverability)

### Hands-on Labs
- [ ] Model a realistic 3-tier SaaS application using STRIDE end-to-end
- [ ] Apply PASTA to the same application — compare outputs vs STRIDE
- [ ] Install and run Threagile on a sample architecture YAML file
- [ ] Write a complete threat model document for an API you know well
- [ ] Build an attack tree for an AWS S3 data exfiltration scenario
- [ ] Run OWASP Threat Dragon and export findings as JSON
- [ ] Map your top threats to MITRE ATT&CK technique IDs (e.g. T1078, T1525)

### 📄 Deliverable — Threat Model Report
- [ ] Produce a complete **Threat Model Report** for your [capstone application](../projects/project-05-devsecops-capstone.md), containing:
  - System description + architecture diagram with trust boundaries
  - STRIDE pass per element + a PASTA narrative for the top attack path
  - Ranked threats (CVSS/DREAD) mapped to **MITRE ATT&CK** technique IDs
  - Mitigations, and **explicit residual-risk acceptance** for anything unmitigated
  - Commit it to the capstone repo and link from [`architect/reference-architectures.md`](../architect/reference-architectures.md)

### Tools to install (see [`../tools/macos-setup.md`](../tools/macos-setup.md))
- [ ] `threagile` (threat modeling as code)
- [ ] OWASP Threat Dragon (Electron app — download from GitHub releases)
- [ ] `drawio` desktop app (architecture diagramming)

---

## 🗓️ Weeks 32–34 — Cloud-Native AppSec & API Security

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

## 🗓️ Weeks 35–37 — Multi-Cloud Security & CSPM

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
- [ ] `trivy` (`trivy config` — successor to the deprecated tfsec)
- [ ] `terrascan` (multi-cloud IaC scanner)
- [ ] `gcloud` CLI (GCP — for GCP Security Engineer cert)
- [ ] `az` CLI (Azure CLI — for multi-cloud awareness)

---

## 🗓️ Weeks 38–40 — Practical Web AppSec (PortSwigger), AI/LLM Security & Bug Bar

> Primary path is hands-on and free. GWEB is optional below.

### Concepts
- [ ] Study secure SDLC — how to embed security at each stage (deep-dive: [`architect/secure-sdlc.md`](../architect/secure-sdlc.md))
- [ ] Understand bug bar definition — how to define severity thresholds and SLAs
- [ ] Learn penetration testing methodology (PTES, OWASP WSTG)
- [ ] Review XSS (all types), CSRF, SSRF, XXE, IDOR, Insecure Deserialization deeply
- [ ] Study secure code review methodology — what to look for in code, tooling vs manual

### Practical Path (primary)
- [ ] Complete the **PortSwigger Web Security Academy** core topics (SQLi, XSS, SSRF, access control, auth, JWT, deserialization)
- [ ] Finish the "Expert" labs in at least 3 topics you're weakest in
- [ ] Write a short blog/README walk-through of 2 exploits you solved (portfolio signal)
- [ ] Run a full OWASP WSTG-guided assessment on your own capstone app and log findings

### 🤖 AI/LLM Security (new in v1.3)

> AI security shows up in most 2026 senior DevSecOps job descriptions. This is the minimum viable coverage — treat it like any other attack surface.

#### Concepts
- [ ] Study the **OWASP Top 10 for LLM Applications** — prompt injection (direct & indirect), insecure output handling, sensitive data disclosure, excessive agency
- [ ] Understand **AI pipeline security** — training data poisoning, model provenance & signing, model registry access control (the supply chain lens from Phase 2 applied to models)
- [ ] Learn LLM app patterns and their risks — RAG (retrieval poisoning), tool-use/agents (privilege escalation via tools), output validation before execution
- [ ] Skim the **NIST AI Risk Management Framework** — enough to place AI risk in a governance conversation
- [ ] Understand where classic controls still apply: secrets in prompts, tenant isolation of context, logging/audit of model I/O

#### Hands-on Labs
- [ ] Complete a prompt-injection lab (e.g. Lakera's Gandalf, or PortSwigger's LLM attack labs)
- [ ] Build a small LLM-backed app (API + one tool call) and **threat-model it** — STRIDE plus the LLM Top 10 as a checklist
- [ ] Add guardrails and demonstrate one blocked attack (input filtering, output validation, tool allow-listing)
- [ ] Extend your capstone Threat Model Report with an AI/LLM section if the capstone gains any AI-assisted feature

### GCP Security Engineer (Optional / Parallel)
- [ ] Complete Google Cloud Skills Boost — Security Engineer learning path
- [ ] Pass GCP Professional Cloud Security Engineer exam
- [ ] ✅ **PASS GCP Professional Cloud Security Engineer** _(optional)_

### <a id="-note-on-gweb"></a>📌 Note on GWEB (optional)
GIAC GWEB is excellent but expensive (~$2.5k+ with training). Pursue it **only if your employer pays**. If self-funding, the PortSwigger path above plus the threat-model deliverable demonstrate the same web-AppSec competence to hiring managers at zero cost, and your budget is better spent on CKS/CISSP.
- [ ] _(optional)_ Build a personal GWEB cheat sheet / index (GIAC is open-book)
- [ ] _(optional)_ Score 80%+ on two full GIAC practice tests → schedule → ✅ **PASS GIAC GWEB**

---

## 📚 Phase 3 Resources

| Resource | Type | Priority |
|---|---|---|
| "The Web Application Hacker's Handbook" | Book | ⭐⭐⭐ |
| PortSwigger Web Security Academy (free) | Labs | ⭐⭐⭐ |
| OWASP API Security Top 10 (owasp.org) | Free | ⭐⭐⭐ |
| OWASP Top 10 for LLM Applications (free) | Free | ⭐⭐⭐ |
| GIAC GWEB Course (SANS SEC542) | Course | ⭐ _(optional — only if employer-funded)_ |
| crAPI — Completely Ridiculous API (lab) | Lab | ⭐⭐⭐ |
| Istio Security Documentation | Reference | ⭐⭐ |
| Google Cloud Security Best Practices | Free | ⭐⭐ |

---

## ✅ Phase 3 Completion Checklist

- [ ] All weekly concept boxes checked
- [ ] All hands-on labs completed
- [ ] All Phase 3 tools installed and tested
- [ ] PortSwigger Web Security Academy core topics completed (GWEB optional)
- [ ] AI/LLM security section completed — one prompt-injection lab + one threat-modeled LLM app
- [ ] **Threat Model Report** written for your capstone (STRIDE + PASTA + MITRE ATT&CK mapping)
- [ ] Multi-cloud IaC scanning pipeline built (Checkov + Trivy)
- [ ] Weekly log entries written for all 12 weeks

---

_← [Phase 2](phase-2-cicd.md) | [Back to README](../README.md) | [Phase 4 →](phase-4-cissp.md)_
