# Project 01 — Secure CI/CD Pipeline

> **Pairs with:** [Phase 3](../phases/phase-3-cks.md) · **Proves:** you can design a pipeline where security is automated, gating, and supply-chain-aware.
> **v2.2:** expanded to close the [CDP gap](../tracks/README.md#-the-cdp-gap-closing-sequence) — DAST is now a **required gate** rather than a stretch goal, findings land in an **aggregation layer**, and the whole pipeline ships in **two CI dialects**.

---

## Brief

Take a small but real app (the [api-track FastAPI scaffold](../api-track/fastapi-scaffold/) is the intended target) and build a pipeline that enforces security at every stage — and *fails the build* when controls are violated.

## Architecture

```
commit ─► pre-commit (gitleaks)
       ─► CI:
            ├─ SAST            (Semgrep)
            ├─ SCA             (Trivy / Snyk — fail on HIGH/CRITICAL)
            ├─ Secret scan     (Gitleaks)
            ├─ IaC scan        (Checkov)
            ├─ Build image     (distroless / minimal base)
            ├─ Image scan      (Trivy)
            ├─ Compliance      (Inspec against the running container)
            ├─ DAST            (ZAP against an ephemeral deploy)
            ├─ SBOM            (Syft → CycloneDX)
            ├─ Sign            (Cosign, keyless/OIDC)
            └─ Provenance      (SLSA attestation)
       ─► all findings ──► DefectDojo  (dedupe · triage · SLA · trend)
       ─► deploy gate: admission rejects unsigned images
```

## Acceptance criteria
- [ ] Every stage above runs in CI and is visible in the pipeline log
- [ ] At least one stage **demonstrably fails** the build on a planted vuln (show it in the README)
- [ ] All GitHub Actions pinned to commit SHAs; `GITHUB_TOKEN` least-privilege
- [ ] No long-lived cloud credentials — OIDC only
- [ ] SBOM published as a build artifact; image signed and verifiable
- [ ] **Every scanner emits machine-readable output that lands in DefectDojo** — no finding exists only in a log
- [ ] `THREATMODEL.md` covering the pipeline itself (poisoned dependency, malicious PR, secret exfil)
- [ ] Controls matrix mapping each gate to NIST SSDF practices

---

## 🔁 Portability — the same pipeline in two CI dialects

> **Why this matters more than it looks.** Roughly half the DevSecOps market runs GitLab, and this roadmap has never touched it. Writing the same pipeline twice forces you to separate *the security design* from *the vendor syntax* — which is exactly the distinction a staff-level interview probes.

- [ ] Ship a `.gitlab-ci.yml` that reproduces the GitHub Actions pipeline stage for stage
- [ ] Learn the mapping, and be able to recite it:

| Concept | GitHub Actions | GitLab CI |
|---|---|---|
| Unit of work | `job` inside a `workflow` | `job` inside a `stage` |
| Ordering | `needs:` (DAG) | `stages:` (sequential) + `needs:` (DAG) |
| Reusable logic | composite / reusable workflows | `extends:`, `include:`, YAML anchors |
| Artifacts | `actions/upload-artifact` | `artifacts:paths:` |
| Non-blocking job | `continue-on-error:` | `allow_failure:` |
| Secrets | repo/org secrets, OIDC | CI/CD variables (masked, protected), OIDC |
| Findings surface | job summary / SARIF upload | **Security Dashboard** + `artifacts:reports:` |

- [ ] Use GitLab's native `artifacts:reports:sast` / `dependency_scanning` / `container_scanning` at least once — then note in your README why you might still prefer raw tool output plus DefectDojo (portability, dedupe across repos, no tier lock-in)
- [ ] Test locally without burning CI minutes: [`gitlab-ci-local`](https://github.com/firecow/gitlab-ci-local) runs `.gitlab-ci.yml` on your machine
- [ ] Document one thing each platform does **better** than the other. Have an opinion; defend it.

---

## 🕷️ DAST as a required gate

> Previously a stretch goal. Promoted in v2.2 — an unauthenticated baseline scan against a login-walled app finds almost nothing, and "we run ZAP" without session handling is the most common false-confidence in the industry.

- [ ] **Baseline vs full scan** — know what each does, and how long each takes. Baseline is the per-commit gate; full is not
- [ ] Deploy the app ephemerally in CI (docker compose or a `kind` deploy), scan it, tear it down
- [ ] Build and commit a **tuned baseline config** — the alert-filter file that suppresses known-accepted findings so the gate stays credible
- [ ] **Authenticated scanning** — configure session management so ZAP scans *past* the login page. This is the hard part and the part that matters
- [ ] Run the **AJAX spider** against the API/SPA and compare coverage against the traditional spider
- [ ] Test SSL/TLS and server misconfiguration, not just application findings
- [ ] Define and document a **scan cadence**, with the reasoning:

| Cadence | Scan | Gates the build? |
|---|---|---|
| Every commit | ZAP baseline (passive, minutes) | Yes — fail on new HIGH |
| Nightly | ZAP full active scan | No — report to DefectDojo |
| Monthly | Full scan + manual triage pass | No — feeds the risk review |

- [ ] Add **Burp Suite Dastardly** as a second opinion — it is CI-native and free, and comparing two DAST tools on the same target teaches you more about false positives than any amount of reading
- [ ] Prove it works: plant a vulnerability the SAST stage cannot see (a misconfigured CORS header, a missing auth check reachable only at runtime) and show DAST catching it

---

## 📊 Vulnerability aggregation — DefectDojo

> The architectural hole this project had until v2.2: every gate failed the build and the finding then **vanished**. No dedupe, no trend, no SLA, no answer to "is this getting better?"

- [ ] Stand it up locally:
```bash
git clone https://github.com/DefectDojo/django-DefectDojo ~/labs/defectdojo
cd ~/labs/defectdojo
docker compose up -d
# admin password is printed by the initializer container:
docker compose logs initializer | grep -i "admin password"
```
- [ ] Model it properly: **Product** → **Engagement** → **Test** → **Finding**. Getting this hierarchy right is most of the tool
- [ ] Import output from every scanner you run — Semgrep, Trivy, Checkov, Gitleaks, ZAP, Inspec. DefectDojo parses all of them natively
- [ ] Push results from CI via the API on every run, not by hand
- [ ] Configure **deduplication** and prove it: the same CVE from Trivy image scan and Trivy filesystem scan should be **one** finding, not two
- [ ] Set **SLAs by severity** and watch the overdue counter — this is the [SSDF "RV" practice](../architect/secure-sdlc.md) made real
- [ ] Triage a full backlog: mark false positives, accept a risk with a justification and an expiry, verify a fix
- [ ] Screenshot the **trend graph** after several runs — that graph is the single most persuasive artifact in this whole project

> 💾 **Resource note:** DefectDojo runs postgres + redis + celery + nginx + uwsgi (~2–3 GB). On an 8 GB Mac, run it **instead of** the kind cluster, not alongside. See [tools/lab-environments.md](../tools/lab-environments.md).

---

## Stretch
- [ ] Branch protection + required checks documented
- [ ] In-toto / SLSA provenance verified at deploy time
- [ ] DefectDojo deployed persistently (homelab Proxmox VM) so trend data survives across quarters
- [ ] A second app in a different language, through the same pipeline unchanged

## Tools
Semgrep · Trivy · Gitleaks · Checkov · Syft · Cosign · OWASP ZAP · Burp Dastardly · Inspec/CINC · DefectDojo · GitHub Actions OIDC · GitLab CI

> 🎯 **What this proves in an interview:** not that you can add scanners to a pipeline — anyone can. That you designed a system where findings are **deduplicated, owned, tracked against an SLA, and trending down**, and that the design survives a change of CI vendor. That is the difference between a pipeline and a programme.

---

_← [Projects](README.md) · [CDP gap sequence](../tracks/README.md#-the-cdp-gap-closing-sequence)_
