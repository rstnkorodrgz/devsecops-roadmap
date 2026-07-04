# Phase 4 — Cloud & AI Security on Azure (SC-500)

> **Duration:** Months 10–13
> **Target Certification:** **SC-500 — Microsoft Cloud and AI Security Engineer Associate.** **Book the exam at the start of the phase.**
> **Quarterly artifact:** Azure security baseline — landing-zone security controls doc, mapped to Microsoft cloud security benchmark / CIS Azure Foundations Benchmark
> **Accelerated by:** daily Azure work; the Phase 1 landing zone is the lab environment

> 🔁 **Why SC-500 and not AZ-500:** AZ-500 (Azure Security Engineer Associate) **retired on August 31, 2026**. SC-500 is Microsoft's direct replacement at the same engineer level — same Azure security core (Entra ID, Defender for Cloud, Sentinel) **plus AI security coverage**, which compounds directly with [Pillar C](../pillars/pillar-c-ai-security.md). Third-party study materials are still thin for a new exam — lean on the official Microsoft Learn path and check the current study guide for exact measured skills.

---

## 🗓️ Month 10 — Identity & Network Security

### Concepts
- [ ] **Microsoft Entra ID** — users/groups, app registrations vs enterprise apps, managed identities
- [ ] Conditional Access — policies, named locations, sign-in risk, break-glass accounts
- [ ] **PIM** (Privileged Identity Management) — just-in-time roles, access reviews
- [ ] Workload identity federation (the GitHub OIDC pattern from Phase 1 — now understand it end-to-end)
- [ ] Network security — NSGs vs Azure Firewall vs WAF; hub-spoke enforcement
- [ ] **Private Link / Private Endpoints** — killing public data-plane exposure
- [ ] DDoS protection tiers; service endpoints vs private endpoints

### Hands-on Labs
- [ ] Configure Conditional Access requiring MFA + compliant device for admin roles (report-only first)
- [ ] Set up PIM for a privileged role with approval + time-box; document the flow
- [ ] Put a storage account and Key Vault behind Private Endpoints in the Phase 1 landing zone; verify public access is dead

---

## 🗓️ Month 11 — Compute, Data & Posture Management

### Concepts
- [ ] **Microsoft Defender for Cloud** — CSPM (secure score, recommendations) vs workload protection plans
- [ ] AKS security — Defender for Containers, Azure Policy add-on, workload identity, private clusters
- [ ] Key Vault — RBAC vs access policies, purge protection, rotation
- [ ] Storage & SQL security — encryption models, CMK, Defender plans, auditing
- [ ] Azure Policy at scale — initiatives, deny vs audit vs deployIfNotExists, exemptions

### Hands-on Labs
- [ ] Enable Defender for Cloud on the landing zone; drive secure score up and document every fix
- [ ] Assign a policy initiative (e.g. CIS benchmark) and remediate non-compliant resources
- [ ] Configure a customer-managed key for a storage account via Key Vault

---

## 🗓️ Month 12 — Security Operations (Sentinel) & AI Security

### Concepts
- [ ] **Microsoft Sentinel** — data connectors, analytics rules, workbooks, automation (SOAR)
- [ ] **KQL** — the query language; this is the deepest technical skill of the phase
- [ ] Defender XDR integration — incidents, hunting
- [ ] **AI security (the new SC-500 ground):** securing Azure OpenAI / AI Foundry workloads, AI posture in Defender for Cloud, prompt-injection and data-leak controls for LLM apps, model/data supply chain
- [ ] Connect this domain to [Pillar C](../pillars/pillar-c-ai-security.md) — the cert study and the specialization artifacts feed each other

### Hands-on Labs
- [ ] Stand up Sentinel on a workspace; connect Entra ID + activity logs; write 3 custom KQL analytics rules
- [ ] Build one automation rule / playbook (e.g. auto-isolate on high-severity incident)
- [ ] Deploy a minimal Azure OpenAI app and apply the AI security controls you can; note the gaps — that's Pillar C material

---

## 🗓️ Month 13 — Exam & Artifact

### Exam Prep
- [ ] Complete the official **Microsoft Learn SC-500 path** (free)
- [ ] Review the current SC-500 study guide for measured-skill weights
- [ ] Practice exams (MeasureUp or equivalent as they mature for the new exam)
- [ ] ✅ **PASS SC-500 — Cloud and AI Security Engineer Associate**
- [ ] Note: Microsoft role certs renew **annually** via a free online assessment — calendar it

### 📦 Quarterly artifact (Q4)
- [ ] **Azure security baseline** (public): the landing-zone security controls documented as a reusable baseline — identity, network, data, posture, SecOps — each control mapped to Microsoft cloud security benchmark / CIS Azure and marked preventive/detective

---

## 📚 Resources
- Microsoft Learn — SC-500 learning path + study guide (free, authoritative)
- John Savill's Technical Training (YouTube) — Azure security deep dives (free)
- KQL: "Must Learn KQL" series (free) — needed for Sentinel depth
- Microsoft cloud security benchmark (MCSB) docs

---

_← [Phase 3](phase-3-cks.md) | [Back to README](../README.md) | [Phase 5 (CCSP) →](phase-5-ccsp.md)_
