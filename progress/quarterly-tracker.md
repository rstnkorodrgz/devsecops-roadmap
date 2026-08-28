# 📊 Quarterly Tracker

> The v2.0 unit of accountability is the **quarter**, not the week. One public artifact per quarter — no exceptions, no banking.

---

## The 18-month plan at a glance

| Quarter | Months | Phase | Exam (book at phase start) | Quarterly artifact |
|---|---|---|---|---|
| Q1 | 1–3 | [Phase 1 — Terraform](../phases/phase-1-terraform.md) | Terraform Associate (003) | Hardened IaC module + Checkov policy set |
| Q2 | 4–6 | [Phase 2 — CKA](../phases/phase-2-cka.md) | CKA | Cluster build & troubleshooting runbook |
| Q3 | 7–9 | [Phase 3 — CKS](../phases/phase-3-cks.md) | CKS ★ | K8s hardening playbook (CIS-mapped) |
| Q4 | 10–12 | [Phase 4 — SC-500](../phases/phase-4-sc500.md) | — (exam lands Q5) | Azure security baseline |
| Q5 | 13–15 | Phase 4 close → [Phase 5 — CCSP](../phases/phase-5-ccsp.md) | SC-500 (M13) | First OSS PR or sanitized design doc ([Pillars A](../pillars/pillar-a-open-source.md)/[D](../pillars/pillar-d-architecture.md) ramp) |
| Q6 | 16–18 | Phase 5 — CCSP | CCSP | Multi-cloud security reference architecture |
| Q7+ | ongoing | [Pillars A–D](../pillars/README.md) | electives by trigger | Pillar cadence: PRs, talks, posts, architectures |

## 🏅 Certification milestones

| Cert | Target | Booked date | Result |
|---|---|---|---|
| Terraform Associate (003) | Month 3 | _book in Week 1_ | — |
| CKA | Month 6 | _book at phase start_ | — |
| CKS | Month 9 | _book at phase start_ | — |
| SC-500 | Month 13 | _book at phase start_ | — |
| CCSP | Month 18 | _book at phase start_ | — |

---

## 🎯 CDP gap-closing sequence (v2.2 · parallel block)

> **~34–40 hrs ≈ 4–5 weeks** at 8–10 hrs/week. Closes the [~50% gap](../tracks/README.md#-the-cdp-gap-closing-sequence) against the Practical DevSecOps CDP syllabus. Runs **in parallel** with whatever phase is active — it is a different tool category, so it does not compete for the same mental context as exam prep.
>
> **Where to slot it:** step 1 alone is worth doing before the next round of job conversations. The full block fits cleanly as a **Q2 artifact** if Q1 is already committed to the Terraform module. Ship it as one public artifact: *"CDP gap closure"*.

| # | Step | Hrs | Done | Artifact |
|---|---|---|---|---|
| 1 | GitLab CI parity for [project-01](../projects/project-01-secure-cicd.md) | ~6 | ☐ | `.gitlab-ci.yml` + platform mapping table |
| 2 | [Ansible & golden images](../tracks/config-management.md) | ~8 | ☐ | `ansible-hardening` repo, Molecule green |
| 3 | [Inspec & OpenSCAP](../tracks/compliance-as-code.md) | ~8 | ☐ | `compliance-baseline` repo + before/after evidence |
| 4 | DefectDojo aggregation layer | ~5 | ☐ | Trend graph screenshot + SLA config |
| 5 | DAST promoted to a required gate | ~6 | ☐ | Authenticated ZAP scan + cadence doc |
| 6 | [Polyglot scanners](../tools/lab-environments.md) — Java / JS / Ruby | ~4 | ☐ | Four scanner reports in DefectDojo |
| 7 | DSOMM + DevOps vocabulary | ~3 | ☐ | DSOMM scorecard in [secure-sdlc.md](../architect/secure-sdlc.md) |

**Exit criteria:** all seven done, and you can walk someone through a pipeline that runs on two CI platforms, hardens its own base image, proves that hardening with an executable profile, and lands every finding in one place with an SLA against it.

**Then decide on the exam.** Sitting CDP is optional and should stay that way unless a client, employer, or tender names it. The artifacts above are the point.

---

## 📅 Quarter template (copy per quarter)

```
## Q[N] — [months] — [phase]

### KPIs
- [ ] 1 public artifact shipped (PR / talk / post / architecture): ___________
- [ ] Next exam has a booked date: ___________
- [ ] GitHub graph shows sustained activity (no cert-cramming gaps)
- [ ] LinkedIn updated (certs + artifacts)

### Elective trigger review
- [ ] CISSP trigger (≥2 postings/quarter require it): fired? Y/N
- [ ] AWS trigger (USD-remote pivot): fired? Y/N

### Shipped this quarter
-

### Slipped / carried over
-

### Notes for next quarter
-
```

---

## 📝 Actual entries (most recent on top)

---

_← [Back to README](../README.md)_
