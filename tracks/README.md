# Tracks — Background & Gap-Closing

> Tracks run **in parallel** with the [certification phases](../README.md#-certification-ladder). They have no fixed exam date; they exist to build depth the cert ladder doesn't cover.

| Track | Status | Feeds |
|---|---|---|
| [appsec.md](appsec.md) | Background — no fixed schedule | Pillars C & D |
| [platform-engineering.md](platform-engineering.md) | Background — no fixed schedule | Pillar D |
| [config-management.md](config-management.md) | **Gap-closing — sequenced, ~8 hrs** | Compliance-as-code, Pillar D |
| [compliance-as-code.md](compliance-as-code.md) | **Gap-closing — sequenced, ~8 hrs** | secure-sdlc, Phase 5 capstone |

The hands-on [`api-track/`](../api-track/) is a separate sequenced track with its own runnable scaffold.

---

# 🎯 The CDP gap-closing sequence

**Added in v2.2.** A gap analysis against the [Practical DevSecOps CDP syllabus](https://www.practical-devsecops.com/certified-devsecops-professional/) found this roadmap covers **~50%** of it. The overlap is *deeper* than CDP everywhere it exists — supply chain, Kubernetes, cloud, threat modelling. The gaps cluster in one place: CDP still teaches the **configuration-management era** of DevSecOps, and this roadmap jumped straight past it.

None of the gap is conceptually hard. It is **unfamiliar tooling, not unfamiliar thinking**.

## Why do this even if you never sit CDP

Every step below ends in a **public artifact**. That is the roadmap's actual thesis — past senior level, certifications stop differentiating and artifacts do. These seven steps produce a dual-CI pipeline, a hardened golden image with a matching compliance profile, and a real vulnerability-aggregation layer. Sit the exam afterwards only if a client, employer, or tender actually asks for the acronym.

## The sequence

Ordered by **risk**, not by syllabus order. **~34–40 hrs ≈ 4–5 weeks** at the roadmap's 8–10 hrs/week budget. Do them in order — steps 2 and 3 are one continuous lab, and step 4 depends on having findings to aggregate.

| # | Step | Hrs | Lands in | Closes |
|---|---|---|---|---|
| 1 | **GitLab CI parity** — mirror the project-01 pipeline as `.gitlab-ci.yml` | ~6 | [project-01](../projects/project-01-secure-cicd.md) | CDP Ch2 |
| 2 | **Ansible & golden images** — harden a host, bake an image, scan it | ~8 | [config-management.md](config-management.md) | CDP Ch7 |
| 3 | **Inspec & OpenSCAP** — prove the hardening held, produce auditor evidence | ~8 | [compliance-as-code.md](compliance-as-code.md) | CDP Ch8 |
| 4 | **DefectDojo** — an aggregation layer so findings stop vanishing | ~5 | [project-01](../projects/project-01-secure-cicd.md) · [project-05](../projects/project-05-devsecops-capstone.md) | CDP Ch9 |
| 5 | **DAST from stretch to gate** — authenticated ZAP, scan cadence | ~6 | [project-01](../projects/project-01-secure-cicd.md) | CDP Ch6 |
| 6 | **Polyglot scanners** — Java, JS and Ruby scanning once through | ~4 | [tools/lab-environments.md](../tools/lab-environments.md) | CDP Ch4–5 |
| 7 | **DSOMM & DevOps vocabulary** — reading only, no lab | ~3 | [architect/secure-sdlc.md](../architect/secure-sdlc.md) | CDP Ch1, Ch3 |

### Start here

> **Step 1 is the highest-value hour on this list.** The CDP exam environment is GitLab-centric, and more importantly, roughly half the DevSecOps roles in the market are GitLab shops. You have never written a `.gitlab-ci.yml`. That is a one-line disqualifier in a screening call and a weekend's work to fix.

Progress on all seven is tracked in [`progress/quarterly-tracker.md`](../progress/quarterly-tracker.md) as a single quarterly artifact: **"CDP gap closure"**.

## What the gap analysis did *not* find

Worth knowing before spending money on the certification — on all of these the roadmap is already past CDP:

- **Supply chain** — SLSA v1.0 build levels, Cosign keyless signing, in-toto attestations, verify-at-deploy. CDP stops at scanning.
- **Kubernetes** — an entire [CKS phase](../phases/phase-3-cks.md). CDP has no Kubernetes chapter at all.
- **Cloud** — Azure landing zone, Defender for Cloud, Sentinel. CDP is cloud-agnostic to the point of absence.
- **Threat modelling** — STRIDE, PASTA, LINDDUN, ATT&CK mapping. CDP names it as one SDLC activity and moves on.
- **Report craft** — the 24-hour exam report is where candidates lose marks. Controls matrices and residual-risk statements are already the house style here.

---

_← [Back to README](../README.md) | [Pillars](../pillars/README.md) · [Architect library](../architect/README.md)_
