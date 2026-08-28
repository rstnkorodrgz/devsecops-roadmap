# 🛡️ DevSecOps Roadmap v2.3 — Technical Expertise Track

> **Goal:** hands-on **Cloud Security Engineer** → Senior DevSecOps → **Staff/Principal (deep technical IC)** — not the management ladder
> **Duration:** **9 months of foundations** + 18 months of certification phases + an open-ended technical ladder (the Pillars)
> **Starting point:** DevSecOps Lead by title, risk-and-assurance in practice. The [Foundations track](foundations/README.md) converts reviewing into building.
> **Strategy:** **Azure-primary** (daily work + Chilean regulated market), AWS preserved as a dormant elective, multi-cloud at the *design* level
> **Philosophy:** past senior level, certifications stop differentiating — **public artifacts do**. One artifact ships every quarter, no exceptions.
> **Budget:** 8–10 hrs/week (two weeknights + one weekend block)

![Status](https://img.shields.io/badge/Status-Active%20Development-2E7D32?style=flat-square)
![Focus](https://img.shields.io/badge/Focus-Defensive%20Security-1565C0?style=flat-square)
![Cloud](https://img.shields.io/badge/Cloud-Azure--Primary-0078D4?style=flat-square)
![Cadence](https://img.shields.io/badge/Cadence-8%E2%80%9310%20hrs%2Fweek-E95420?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-0277BD?style=flat-square)

---

## 🆕 What's new in v2.3 (2026-08-28) — the Foundations on-ramp

The roadmap was written for a senior engineer who already builds daily. That was the wrong starting point: the real position is a **DevSecOps Lead title doing risk-analyst review work** — strong judgement, no build reps, cannot yet write code from a blank file. Every phase here asks you to *build* something, so the ladder had no bottom rung.

- **[`foundations/`](foundations/README.md)** — a 9-month **conversion track**: from reviewing systems to building them. Not a beginner path; it assumes the DevSecOps concepts are already there and only the hands are missing.
  - **[F1 — Code you can write](foundations/f1-code.md)** (M1–3) · Python and Bash, project-driven, no copy-paste. Ends in the **ASPM ranker**: automating the manual vulnerability prioritisation already done at work.
  - **[F2 — Systems you can operate](foundations/f2-linux-containers.md)** (M3–5) · Linux and Docker, with deliberate break/fix. Ends in a deployed app, a runbook, and a post-mortem.
  - **[F3 — Cloud you can build in](foundations/f3-azure.md) ★** (M5–8) · **AZ-104** as the forcing function — the credential that says you *operate* Azure rather than assess it. **Job applications start here, at month 8.**
  - **[F4 — Your first pipeline](foundations/f4-first-pipeline.md)** (M8–9) · Build the thing you have spent years reviewing, then over-tune it until it hurts and write down why you tuned it back.
- **Monthly artifacts during foundations**, not quarterly — the quarterly cadence assumes an existing body of work.
- **A sequencing rule**: no hands-on technical screens before F3. The title opens doors the hands cannot yet walk through, and that is worth managing deliberately.

> **On AZ-104 over another security cert:** the gap is not security knowledge — Security+ is active, the Lead title is real, cloud security decisions are daily work. AZ-104 proves the thing that cannot currently be claimed: building and operating cloud infrastructure. SC-500 stays where it was, in [Phase 4](phases/phase-4-sc500.md), and will be far easier afterwards.

## 🆕 What's new in v2.2 (2026-08-28) — CDP gap closure

A gap analysis against the [Practical DevSecOps **CDP** syllabus](https://www.practical-devsecops.com/certified-devsecops-professional/) found this roadmap covers **~50%** of it. Where the two overlap the roadmap goes *deeper* than CDP — supply chain, Kubernetes, cloud, threat modelling. The gaps all sat in one place: CDP still teaches the **configuration-management era** of DevSecOps and this roadmap jumped straight past it.

- **[The gap-closing sequence](tracks/README.md#-the-cdp-gap-closing-sequence)** — 7 steps, ~34–40 hrs, ordered by risk. Tracked as one quarterly artifact in [`progress/quarterly-tracker.md`](progress/quarterly-tracker.md).
- **[`tracks/config-management.md`](tracks/config-management.md)** — Ansible and golden images from zero. Phase 1 teaches *provisioning*; this teaches *configuration management*, which is a different tool category and a standing interview question.
- **[`tracks/compliance-as-code.md`](tracks/compliance-as-code.md)** — Inspec/CINC and OpenSCAP. Turns "we hardened the fleet" into evidence an auditor can read — the most transferable skill on this roadmap for the Chilean regulated market.
- **[`tracks/README.md`](tracks/README.md)** — new track index and the start-here sequence.
- **[Project 01](projects/project-01-secure-cicd.md) substantially expanded** — DAST promoted from stretch goal to a **required gate** (authenticated scanning, tuned baseline, documented cadence); a **DefectDojo** aggregation layer so findings stop vanishing into build logs; and the whole pipeline shipped in **two CI dialects** (`.gitlab-ci.yml` alongside GitHub Actions).
- **DSOMM added** to [`architect/secure-sdlc.md`](architect/secure-sdlc.md) beside SAMM, BSIMM and SSDF, plus the DevOps vocabulary (CAMS, DORA) this repo had never written down.
- **Polyglot scanner lab** in [`tools/lab-environments.md`](tools/lab-environments.md) — Java, JavaScript and Ruby targets, because your codebases are Python/Go/containers and half the market's are not.

> **On sitting the exam:** optional, and it should stay that way. This roadmap's own thesis is that past senior level certifications stop differentiating and artifacts do — and the seven steps above produce the artifacts. Sit CDP only if a client, employer or tender names it.

## 🆕 What's new in v2.1 (2026-07-04 · updated 2026-07-10)

- **Interactive progress dashboard** — **[live on GitHub Pages](https://rstnkorodrgz.github.io/devsecops-roadmap/)** ([`docs/index.html`](docs/index.html)): cert ladder, phase tasks, pillars, API track, projects, and the homelab build — progress saves in-browser.
- **Homelab added** — [`homelab/`](homelab/): hybrid multi-arch lab (Proxmox + OPNsense on a ThinkCentre M720q, dual Pi 5 k3s cluster, Pi 3B sentinel → Microsoft Sentinel) with BOM and Day-1 runbook.
- **API track added** — [`api-track/`](api-track/): a hands-on Build → Secure → Test → Break path with a runnable FastAPI scaffold. Companion to [tracks/appsec.md](tracks/appsec.md). Curated resource guide: [live on GitHub Pages](https://rstnkorodrgz.github.io/devsecops-roadmap/api-track.html).
- **Credential presentation cleaned for recruiters** — the baseline now lists active credentials only; older networking / firewall certs are reframed as a *foundation to refresh* in [Phase 0](phases/phase-0-foundation.md), with modern refresher training added.

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
| CompTIA Security+ | ✅ Active | Theory foundation across the roadmap |
| Microsoft AZ-104 | 🎯 Target — month 8 | The pivot credential: proves you *operate* Azure, not just assess it ([F3](foundations/f3-azure.md)) |

> Backed by hands-on **networking and network-security** experience — routing & segmentation, firewall and IDS/IPS administration — now being **refreshed to its cloud-native equivalents** in [Phase 0](phases/phase-0-foundation.md). Only current, active certifications are listed above.

---

## 🗺️ Certification Ladder

```
FOUNDATIONS (foundations/) — the on-ramp, months 1–9
F1  Code you can write       ──► Python & Bash, 3 shipped tools   months 1–3
F2  Systems you can operate  ──► Linux + Docker, deploy & operate months 3–5
F3  Cloud you can build in   ──► AZ-104 ★ apply for jobs here     months 5–8
F4  Your first pipeline      ──► build it, don't review it        months 8–9
════════════════════════════════════════════════════════════════
THE MAIN LADDER — months restart at 1 below
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
| Writing code | [F1](foundations/f1-code.md) | Three shipped tools, incl. the ASPM ranker |
| Operating systems & containers | [F2](foundations/f2-linux-containers.md) | Deployed app + runbook + post-mortem |
| Cloud engineering | [F3](foundations/f3-azure.md) | AZ-104 + a built Azure environment |
| Pipeline construction | [F4](foundations/f4-first-pipeline.md) | A pipeline you built, with planted failures |
| Infrastructure as Code | [Phase 1](phases/phase-1-terraform.md) | Hardened module + Checkov policy set |
| Kubernetes operations | [Phase 2](phases/phase-2-cka.md) | Cluster build & troubleshooting runbook |
| Kubernetes & supply chain security | [Phase 3](phases/phase-3-cks.md) | Hardening playbook (CIS-mapped) + signed pipeline |
| Cloud & AI security (Azure) | [Phase 4](phases/phase-4-sc500.md) | Azure security baseline |
| Cloud security architecture | [Phase 5](phases/phase-5-ccsp.md) | Multi-cloud reference architecture |
| Configuration management & golden images | [Track](tracks/config-management.md) | Idempotent hardening role + scanned golden image |
| Compliance as code | [Track](tracks/compliance-as-code.md) | Executable profile + auditor-readable evidence |
| Open-source credibility | [Pillar A](pillars/pillar-a-open-source.md) | Merged PRs in one CNCF security project |
| Public technical voice | [Pillar B](pillars/pillar-b-research-speaking.md) | 2 talks/year + written versions |
| AI security | [Pillar C](pillars/pillar-c-ai-security.md) | LLM testing harness + secure RAG architecture |
| Staff-level design | [Pillar D](pillars/pillar-d-architecture.md) | Reference architectures + quarterly design docs |

---

## 📁 Repo Structure

```
devsecops-roadmap/
├── README.md                       ← You are here
├── foundations/                    ← START HERE — the 9-month conversion track (v2.3)
│   ├── README.md                   ← The honest diagnosis + how it connects
│   ├── f1-code.md                  ← Python & Bash          months 1–3
│   ├── f2-linux-containers.md      ← Linux & Docker         months 3–5
│   ├── f3-azure.md                 ← AZ-104 ★ apply for jobs months 5–8
│   └── f4-first-pipeline.md        ← Build one, don't review it  months 8–9
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
├── tracks/                         ← Background + gap-closing tracks
│   ├── README.md                   ← Track index + the CDP gap-closing sequence
│   ├── appsec.md                   ← Threat modeling, API security, PortSwigger
│   ├── platform-engineering.md     ← Paved roads, GitOps, multi-tenancy
│   ├── config-management.md        ← Ansible, golden images        (v2.2)
│   └── compliance-as-code.md       ← Inspec / CINC, OpenSCAP       (v2.2)
├── api-track/                      ← Hands-on: build → secure → test → break an API
│   ├── README.md                   ← The 12-week API DevSecOps path
│   └── fastapi-scaffold/           ← Runnable FastAPI service (Phase 1 start)
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

> **Start with [`foundations/`](foundations/README.md), not Phase 1.** The certification ladder assumes you already build daily. Foundations is what makes that true.

### If you are starting from here (months 1–9)
1. Read [`foundations/README.md`](foundations/README.md) — the diagnosis, the risk, and the conversion strategy.
2. Start [F1](foundations/f1-code.md) this week. Type, do not copy-paste.
3. Ship something public **every month**, however small.
4. Convert your day job: every system you review this week is a thing you can build a minimal version of this weekend.
5. Book **AZ-104** at the start of month 6 — execution rule #1 applies to foundations too.

### Once foundations are done (the main ladder)
1. **Book the Terraform Associate exam** for ~month 3. Yes, now — execution rule #1.
2. Self-assess [`phases/phase-0-foundation.md`](phases/phase-0-foundation.md) — after foundations this is a genuine checklist rather than a wall.
3. Run `bash install.sh --phase 1.5` for the IaC toolchain (installer still uses v1.x phase numbers — see CHANGELOG).
4. Copy the Q1 template into [`progress/quarterly-tracker.md`](progress/quarterly-tracker.md) and put the artifact + exam date in it.
5. Ship the Q1 artifact: hardened Terraform module + Checkov policy set on the Azure landing zone.
6. **In parallel**, start [step 1 of the CDP gap sequence](tracks/README.md#-the-cdp-gap-closing-sequence) — a `.gitlab-ci.yml` for [project-01](projects/project-01-secure-cicd.md). It is one weekend and it removes a common screening-call disqualifier.

> 💸 **Cost note:** Azure labs cost real money (AKS, Defender plans, Sentinel ingestion). Use the free tier + trial credits where possible, set a **budget alert in week 1**, `terraform destroy` after every session, and prefer `kind` locally for anything that doesn't strictly need AKS. Defender plans have 30-day free trials — time the Phase 4 labs around them.

---

_Last updated: 2026-08-28 (v2.3 — Foundations on-ramp) | Azure-primary · monthly artifacts in foundations, quarterly after · 8–10 hrs/week_
