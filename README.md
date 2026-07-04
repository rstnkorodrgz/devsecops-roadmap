# 🛡️ DevSecOps Roadmap v2.0 — Technical Expertise Track

> **Goal:** Senior DevSecOps → **Staff/Principal (deep technical IC)** — not the management ladder
> **Duration:** 18 months of certification phases + an open-ended technical ladder (the Pillars)
> **Strategy:** **Azure-primary** (daily work + Chilean regulated market), AWS preserved as a dormant elective, multi-cloud at the *design* level
> **Philosophy:** past senior level, certifications stop differentiating — **public artifacts do**. One artifact ships every quarter, no exceptions.
> **Budget:** 8–10 hrs/week (two weeknights + one weekend block)

---

## ⭐ What's new in v2.0

| # | Change | Rationale |
|---|---|---|
| 1 | **CCSP replaces CISSP** as the capstone certification | Cloud security architecture depth without managerial framing; ISC2 brand for regulated-market filters. CISSP → [contingency](electives/cissp-contingency.md) with an explicit trigger. |
| 2 | **SC-500 is the cloud security cert** (not AZ-500, not AWS SCS) | AZ-500 **retired 2026-08-31**; SC-500 is Microsoft's direct replacement and adds AI security — compounding with Pillar C. AWS SCS → [dormant elective](electives/aws-security-specialty.md) with a USD-remote trigger. |
| 3 | **Azure-primary labs** — the landing zone, baselines, and SecOps labs are Azure-native | Compounds with daily Azure work; Chilean regulated market is Azure-heavy. AWS lives on at *design level* in the Phase 5 multi-cloud capstone. |
| 4 | **Phase 6: the four Pillars** (open source · speaking · AI security · architecture) | The post-certification ladder — where staff/principal differentiation actually happens. |
| 5 | **Quarterly artifact rule** as the roadmap-wide KPI | One public artifact per quarter: merged PR, talk, post, or reference architecture. Tracked in [progress/quarterly-tracker.md](progress/quarterly-tracker.md). |
| 6 | **AI security expanded** from a module into [Pillar C](pillars/pillar-c-ai-security.md) | Fastest-appreciating niche, no dominant cert → portfolio-driven; first-mover advantage in LATAM. |
| 7 | v1.x deep-dive content preserved as **background tracks** and the **architecture library** | Nothing deleted: [tracks/](tracks/) feed the Pillars; [architect/](architect/) is Pillar D's curriculum (SABSA now optional reading). |

Full history in [`CHANGELOG.md`](CHANGELOG.md).

---

## 📋 My Credential Baseline

| Credential | Status | Notes |
|---|---|---|
| CompTIA Security+ | ✅ Active | Theory foundation covered |
| CCNA | ⚠️ Expired | Networking knowledge intact — accelerates Phases 2–4 |
| SonicWall Administrator | ⚠️ Expired | Firewall/IDS experience → Phase 4 SecOps |

---

## 🗺️ Certification Ladder

```
Phase 1  Terraform Associate ──► hands-on IaC baseline           months 1–3
Phase 2  CKA                 ──► Kubernetes core (CKS prereq)    months 4–6
Phase 3  CKS                 ──► Kubernetes security ★ key diff  months 7–9
Phase 4  SC-500              ──► cloud + AI security (Azure)     months 10–13
Phase 5  CCSP                ──► cloud security architecture     months 14–18
Phase 6  Pillars A–D         ──► open-ended technical ladder     ongoing
────────────────────────────────────────────────────────────────
Elective     AWS Security Specialty — trigger: USD-remote / AWS-heavy pivot
Contingency  CISSP                 — trigger: ≥2 postings/quarter require it
```

### Execution rules
1. **Book the exam at the start of each phase**, not the end.
2. 8–10 hrs/week — protect the two weeknights + weekend block.
3. **Each phase ships a public artifact** into this repo (mapping below).
4. Review elective triggers **quarterly** — a trigger firing is a plan change, not a failure.

---

## 🎯 Capability Matrix

What a staff-level panel actually evaluates — and where you build and prove it.

| Capability | Built in | Proven by |
|---|---|---|
| Infrastructure as Code | [Phase 1](phases/phase-1-terraform.md) | Hardened module + Checkov policy set |
| Kubernetes operations | [Phase 2](phases/phase-2-cka.md) | Cluster build & troubleshooting runbook |
| Kubernetes & supply chain security | [Phase 3](phases/phase-3-cks.md) | Hardening playbook (CIS-mapped) + signed pipeline |
| Cloud & AI security (Azure) | [Phase 4](phases/phase-4-sc500.md) | Azure security baseline |
| Cloud security architecture | [Phase 5](phases/phase-5-ccsp.md) | Multi-cloud reference architecture |
| Open-source credibility | [Pillar A](pillars/pillar-a-open-source.md) | Merged PRs in one CNCF security project |
| Public technical voice | [Pillar B](pillars/pillar-b-research-speaking.md) | 2 talks/year + written versions |
| AI security | [Pillar C](pillars/pillar-c-ai-security.md) | LLM testing harness + secure RAG architecture |
| Staff-level design | [Pillar D](pillars/pillar-d-architecture.md) | Reference architectures + quarterly design docs |

---

## 📁 Repo Structure

```
devsecops-roadmap/
├── README.md                       ← You are here
├── phases/                         ← The 18-month certification ladder
│   ├── phase-0-foundation.md       ← Leverage map + foundations (parallel with Phase 1)
│   ├── phase-1-terraform.md        ← IaC + Azure landing zone      (months 1–3)
│   ├── phase-2-cka.md              ← Kubernetes core               (months 4–6)
│   ├── phase-3-cks.md              ← K8s & supply chain security   (months 7–9)
│   ├── phase-4-sc500.md            ← Cloud + AI security on Azure  (months 10–13)
│   └── phase-5-ccsp.md             ← Architecture consolidation    (months 14–18)
├── pillars/                        ← Phase 6: the post-cert technical ladder
│   ├── README.md                   ← Quarterly artifact rule + KPIs
│   ├── pillar-a-open-source.md     ├── pillar-b-research-speaking.md
│   ├── pillar-c-ai-security.md     └── pillar-d-architecture.md
├── tracks/                         ← Background tracks (feed the Pillars)
│   ├── appsec.md                   ← Threat modeling, API security, PortSwigger
│   └── platform-engineering.md     ← Paved roads, GitOps, multi-tenancy
├── electives/                      ← Trigger-gated: nothing here is default work
│   ├── README.md                   ← The trigger table
│   ├── aws-security-specialty.md   ← Dormant v1.x AWS track (USD-remote trigger)
│   └── cissp-contingency.md        ← 16-week sprint (posting-filter trigger)
├── architect/                      ← Architecture library — Pillar D curriculum
├── projects/                       ← v1.x briefs + v2.0 migration map
├── progress/quarterly-tracker.md   ← THE tracking file (weekly log now optional)
├── tools/ · resources/ · install.sh
```

---

## 🚀 Quick Start

1. **Book the Terraform Associate exam** for ~month 3. Yes, now — execution rule #1.
2. Self-assess [`phases/phase-0-foundation.md`](phases/phase-0-foundation.md) in parallel with starting [Phase 1](phases/phase-1-terraform.md).
3. Run `bash install.sh --phase 1.5` for the IaC toolchain (installer still uses v1.x phase numbers — see CHANGELOG).
4. Copy the Q1 template into [`progress/quarterly-tracker.md`](progress/quarterly-tracker.md) and put the artifact + exam date in it.
5. Ship the Q1 artifact: hardened Terraform module + Checkov policy set on the Azure landing zone.

> 💸 **Cost note:** Azure labs cost real money (AKS, Defender plans, Sentinel ingestion). Use the free tier + trial credits where possible, set a **budget alert in week 1**, `terraform destroy` after every session, and prefer `kind` locally for anything that doesn't strictly need AKS. Defender plans have 30-day free trials — time the Phase 4 labs around them.

---

_Last updated: 2026-07-03 (v2.0 — technical expertise track) | Azure-primary · quarterly artifacts · 8–10 hrs/week_
