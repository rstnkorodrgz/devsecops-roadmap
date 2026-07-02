# 🛡️ DevSecOps Engineer → Architect — Capability Roadmap

> **Goal:** Senior DevOps → **Senior DevSecOps → DevSecOps/Security Architect**
> **Duration:** 52 weeks (~12 months) core track + a parallel Architect track
> **Philosophy:** **Capability-centric, not certification-centric.** Certs get you past the résumé filter; demonstrated capability and a public portfolio get you hired and promoted.
> **MacBook Pro:** 2020 13" (Apple M1 / Intel — tool instructions cover both)
> **Start date:** _Fill in your start date_

---

## ⭐ What's new in v1.3

A content-currency and consistency pass (2026-07-02). Full details in [`CHANGELOG.md`](CHANGELOG.md).

| # | Change | Where |
|---|---|---|
| 1 | **CKA block added to Phase 2** — a passed, active CKA is a registration prerequisite for CKS; Phase 2 is now 16 weeks | [`phases/phase-2-cicd.md`](phases/phase-2-cicd.md) |
| 2 | **Timeline renumbered** to one global week scheme; honest total of 52 weeks (was "~10 months" that summed to 48+) | all phase files |
| 3 | **AI/LLM security module** (OWASP LLM Top 10, prompt injection, AI pipeline security) | [`phases/phase-3-appsec.md`](phases/phase-3-appsec.md) |
| 4 | **Standards currency:** CIS AWS Benchmark v5.0, SLSA v1.0 (Build L0–L3), CISSP CAT 3h/100–150Q, CVSS v3.1+v4.0, Pod Security Admission (PSP removed), NIST SP 800-88 | phases 1–4 |
| 5 | **tfsec → Trivy** (`trivy config`) as the default IaC scanner; `kube-hunter` dropped (unmaintained) | phases 1.5/2/3, projects |
| 6 | **Terraform Associate exam milestone** added to Phase 1.5 | [`phases/phase-1.5-iac.md`](phases/phase-1.5-iac.md) |
| 7 | **Certification ladder matches phase order** (AWS SCS before Terraform Associate) | [below](#certification-ladder) |
| 8 | **Weekly log, Phase 4 checklist, and resources** synced to the v1.2 structure (GWEB removed, Phases 0/1.5/3.5 + architect resources added) | `progress/`, `resources/` |
| 9 | **AWS cost note** — budget expectations and teardown discipline | [Quick Start](#-quick-start) |

---

## ⭐ What's new in v1.2

This branch restructures the roadmap from *cert progression* to *capability building*, based on a senior-hiring-manager review. Each change below is independently reviewable in the diff.

| # | Change | Where |
|---|---|---|
| 1 | **Real Phase 0 foundations** (Linux, Python, Git, Networking) added to the existing leverage map | [`phases/phase-0-foundation.md`](phases/phase-0-foundation.md) |
| 2 | **New Phase 1.5 — Infrastructure as Code** (Terraform, Terragrunt, Checkov, tfsec, OPA) | [`phases/phase-1.5-iac.md`](phases/phase-1.5-iac.md) |
| 3 | **Supply chain deep-dive** (provenance, keyless signing, verify-at-deploy) | [`phases/phase-2-cicd.md`](phases/phase-2-cicd.md) |
| 4 | **New Phase 3.5 — Platform Engineering** (IDP, Backstage, golden paths, K8s multi-tenancy) | [`phases/phase-3.5-platform-engineering.md`](phases/phase-3.5-platform-engineering.md) |
| 5 | **Expanded threat modeling** (STRIDE + MITRE ATT&CK + attack trees + Threat Model Report deliverable) | [`phases/phase-3-appsec.md`](phases/phase-3-appsec.md) |
| 6 | **GWEB demoted to optional**, PortSwigger practical path made primary | [`phases/phase-3-appsec.md`](phases/phase-3-appsec.md#-note-on-gweb) |
| 7 | **New Architect track** (SABSA, Zero Trust, Secure SDLC, Platform Eng, Reference Architectures) | [`architect/`](architect/) |
| 8 | **New Portfolio projects** (5 standalone repos, the capstone included) | [`projects/`](projects/) |
| 9 | **Reordered certification ladder** (Terraform + CKA + SABSA in, GWEB out of the critical path) | [below](#certification-ladder) |

> These are *proposals on a branch* — accept or revert any of them via the diff against `main`.

---

## 📋 My Credential Baseline

| Credential | Status | Notes |
|---|---|---|
| CompTIA Security+ | ✅ Active | Theory foundation covered |
| CCNA | ⚠️ Expired | Networking knowledge intact — accelerates Phases 1–3 |
| SonicWall Administrator | ⚠️ Expired | IDS/IPS + VPN experience applies to runtime security |

---

## 🗺️ Roadmap Overview

```
Weeks 1–4    Phase 0    Foundations & Assessment (parallel with Phase 1 start)
Weeks 1–8    Phase 1    Cloud Security Foundations (AWS SCS-C02)
Weeks 9–12   Phase 1.5  Infrastructure & Policy as Code (Terraform Associate)
Weeks 13–28  Phase 2    CI/CD, Containers & Kubernetes (CKA → CKS)
Weeks 29–40  Phase 3    Advanced AppSec, Threat Modeling & AI Security
Weeks 41–44  Phase 3.5  Platform Engineering & Paved Roads
Weeks 45–52  Phase 4    Expert Capstone & CISSP
   ║                    Total: 52 weeks (~12 months)
   ╚═ parallel ═►  Architect Track  (SABSA · Zero Trust · Secure SDLC · Reference Architectures)
                   Portfolio Projects  (01 → 05, building toward the Capstone)
```

### Certification Ladder

Ordered to match the phase sequence, front-loading the skills senior roles actually screen for (Terraform, Kubernetes) and dropping GWEB from the critical path.

```
[Done]   CompTIA Security+
  └─►  AWS Security Specialty (SCS-C02)      ← Phase 1, Week 8
        └─►  Terraform Associate (003)        ← Phase 1.5, Week 12 — near-universal Senior DevSecOps requirement
              └─►  CKA                        ← Phase 2, Week 22 — required before you can register for CKS
                    └─►  CKS — Certified Kubernetes Security Specialist  ← Phase 2, Week 28
                          └─►  CISSP          ← Phase 4, Week 52
                                └─►  SABSA (SCF → SCP)  ← Architect track: the architecture credential
```

> **GWEB** and **GCP Pro Cloud Security Engineer** remain valuable but **optional** — pursue if employer-funded. See [Phase 3](phases/phase-3-appsec.md#-note-on-gweb).

---

## 🎯 Capability Matrix

What a hiring panel actually evaluates — and where you build it.

| Capability | Built in | Proven by |
|---|---|---|
| Pipeline security design | Phase 2 | [Project 01](projects/project-01-secure-cicd.md) |
| Infrastructure as Code | Phase 1.5 | [Project 03](projects/project-03-cloud-security.md) |
| Kubernetes security | Phase 2 | [Project 02](projects/project-02-kubernetes-security.md) |
| Cloud security architecture | Phase 1 / 1.5 | [Project 03](projects/project-03-cloud-security.md) + [architect/cloud-security.md](architect/cloud-security.md) |
| Supply chain security | Phase 2 | [Project 01](projects/project-01-secure-cicd.md) |
| Threat modeling | Phase 3 | Threat Model Report (Capstone) |
| Platform engineering | Phase 3.5 | [Project 04](projects/project-04-platform-engineering.md) |
| Security architecture | Architect track | [architect/reference-architectures.md](architect/reference-architectures.md) |

---

## 📁 Repo Structure

```
devsecops-roadmap/
├── README.md                        ← You are here
├── phases/
│   ├── phase-0-foundation.md        ← Leverage map + foundations track (Linux/Python/Git/Net)
│   ├── phase-1-cloud.md             ← Cloud Security (AWS)
│   ├── phase-1.5-iac.md             ← NEW: Infrastructure & Policy as Code (Terraform)
│   ├── phase-2-cicd.md              ← CI/CD, Containers & Supply Chain
│   ├── phase-3-appsec.md            ← AppSec & Threat Modeling
│   ├── phase-3.5-platform-engineering.md  ← NEW: Platform Engineering
│   └── phase-4-cissp.md             ← Capstone & CISSP
├── architect/                       ← NEW: Architect track
│   ├── README.md
│   ├── sabsa.md
│   ├── zero-trust.md
│   ├── cloud-security.md
│   ├── secure-sdlc.md
│   ├── platform-engineering.md
│   └── reference-architectures.md
├── projects/                        ← NEW: Portfolio projects (5 standalone repos)
│   ├── README.md
│   ├── project-01-secure-cicd.md
│   ├── project-02-kubernetes-security.md
│   ├── project-03-cloud-security.md
│   ├── project-04-platform-engineering.md
│   └── project-05-devsecops-capstone.md
├── tools/                           ← Tool installation guides (macOS 2020 MBP)
├── resources/                       ← Books, courses, labs
└── progress/                        ← Weekly study log
```

---

## 📊 Overall Progress

> Update the checkboxes in each phase file as you complete topics.

| Phase | Progress | Status |
|---|---|---|
| Phase 0 — Foundations | `░░░░░░░░░░` 0% | 🔜 Not started |
| Phase 1 — Cloud Security | `░░░░░░░░░░` 0% | 🔒 Locked |
| Phase 1.5 — IaC & Policy | `░░░░░░░░░░` 0% | 🔒 Locked |
| Phase 2 — CI/CD, Containers & K8s (CKA→CKS) | `░░░░░░░░░░` 0% | 🔒 Locked |
| Phase 3 — AppSec & Threat Modeling | `░░░░░░░░░░` 0% | 🔒 Locked |
| Phase 3.5 — Platform Engineering | `░░░░░░░░░░` 0% | 🔒 Locked |
| Phase 4 — CISSP Capstone | `░░░░░░░░░░` 0% | 🔒 Locked |
| Architect Track | `░░░░░░░░░░` 0% | 🔜 Parallel |
| Portfolio Projects | `0 / 5` | 🔜 Parallel |

---

## 🚀 Quick Start

1. **Clone this repo** and start with [`tools/macos-setup.md`](tools/macos-setup.md)
2. **Self-assess** [`phases/phase-0-foundation.md`](phases/phase-0-foundation.md) — close any foundation gaps first
3. **Install Phase 1 tools** from the setup guide, then work [`phases/phase-1-cloud.md`](phases/phase-1-cloud.md)
4. **Start a portfolio project early** — pick up [`projects/`](projects/) as soon as Phase 1.5 gives you infrastructure
5. **Run the Architect track in parallel** once you reach Phase 3
6. **Log your weekly progress** in [`progress/weekly-log.md`](progress/weekly-log.md)

> 💸 **Cost note:** the AWS labs (multi-account org, EKS, GuardDuty, Security Hub, Macie) cost real money — expect **$50–150/month while lab resources are up**. Set an AWS Budget alert in Week 1, `terraform destroy` after every session, and prefer `kind`/`k3s` locally wherever a lab doesn't strictly need EKS.

---

_Last updated: 2026-07-02 (v1.3 currency pass) | Built for macOS 13" MBP 2020_
