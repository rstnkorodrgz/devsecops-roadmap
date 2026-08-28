# F4 — Your First Pipeline

> **Months 8–9 · ~40 hrs · the handover to the main roadmap**
> **Exit signal:** a pipeline you **built**, not one you reviewed — with one gate that demonstrably fails a bad commit.
> **After this:** you join [Phase 1 — Terraform](../phases/phase-1-terraform.md) and the [18-month ladder](../README.md#-certification-ladder) with the hands to execute it.

---

## 🎯 The point of this track

You have spent years assessing pipelines. You know what the gates should be, where they get bypassed, and which findings teams quietly ignore. What you have never done is **build one from an empty `.github/workflows/` directory** and feel where the difficulty actually lives.

The difficulty is never the scanner. It is the twenty minutes of YAML indentation errors, the secret that is not available to a fork's pull request, the gate that fails the build for a reason nobody can action, and the moment you realise your policy would have blocked every deploy for a week.

That last realisation is the one that changes how you write findings for the rest of your career.

---

## 🗓️ Week 1–2 — A pipeline that runs

Start from the app you already deployed in [F2](f2-linux-containers.md) — the [api-track scaffold](../api-track/fastapi-scaffold/).

### Concepts
- [ ] What CI/CD actually is — the trigger, the runner, the workspace, the artifact
- [ ] **GitHub Actions anatomy** — workflow → job → step; `on:`, `runs-on:`, `uses:` vs `run:`
- [ ] Secrets and variables, and why a secret is not available to a fork's PR
- [ ] Caching, artifacts, and why your build is slow
- [ ] Job dependencies with `needs:`, and matrix builds
- [ ] **Failing the build** — exit codes, `continue-on-error`, and what "gating" actually means mechanically

### Hands-on
- [ ] Write a workflow that runs `pytest` on every push. **Watch it fail. Fix it.** Expect to spend real time on YAML
- [ ] Add a linting step (`ruff` or `flake8`)
- [ ] Add a build step that produces a Docker image
- [ ] Break a test on purpose and confirm the build goes red
- [ ] Add a status badge to the README — a small thing that makes the repo look maintained

---

## 🗓️ Week 3–4 — A pipeline that gates

Now add the security layer. You already know what each of these tools does — that is the easy half for you. The work is wiring them so they *act*.

- [ ] **Secret scanning** — `gitleaks`, as a pre-commit hook **and** a CI job
- [ ] **SAST** — `semgrep`, failing on HIGH
- [ ] **SCA** — `trivy fs`, failing on HIGH/CRITICAL
- [ ] **Image scanning** — `trivy image` on the image you just built
- [ ] **IaC scanning** — `checkov` against the Bicep template from [F3](f3-azure.md)
- [ ] Pin every action to a **commit SHA**, not a tag — the supply-chain control you have written findings about
- [ ] Scope `GITHUB_TOKEN` to least privilege

### 🔥 Prove each gate works
- [ ] Commit a fake AWS key on a branch → gitleaks blocks it
- [ ] Add a deliberate SQL injection → semgrep catches it
- [ ] Pin a dependency to a version with a known CVE → trivy fails the build
- [ ] Make the Bicep template allow public blob access → checkov fails
- [ ] **Screenshot every one of these**. The planted-failure evidence is what makes the artifact credible — anyone can show a green pipeline

---

## 🗓️ Week 5–6 — The lesson only you will learn

Here is the exercise that makes this track worth more to you than to anyone else doing it.

- [ ] **Turn every gate up to maximum.** Fail on MEDIUM. Fail on every finding. No suppressions
- [ ] Try to ship three small changes through it
- [ ] Record how long it takes and how many were blocked for something you could not action
- [ ] Now **tune it back** to something a real team would tolerate, and write down every threshold you changed and why
- [ ] Write a short `SECURITY.md` documenting the gates, the thresholds, the suppressions, and the **residual risk you accepted**

> 🎯 **This is the artifact.** Not the pipeline — the *reasoning about the pipeline*. You have professional judgement about risk acceptance that almost nobody building their first pipeline has. Use it. A README that says *"I set this gate to HIGH rather than MEDIUM because at MEDIUM it blocked 40% of changes for findings with no available fix, and a gate people switch off protects nothing"* is a senior-sounding sentence backed by your own data.

---

## 🗓️ Deploy it (optional, ~1 week)

- [ ] Add a deploy job that pushes the image to Azure Container Registry
- [ ] Authenticate with **OIDC federated credentials** — no stored secrets ([Phase 1](../phases/phase-1-terraform.md) goes deeper)
- [ ] Deploy to Container Instances or the VM from [F3](f3-azure.md)
- [ ] Require a manual approval before the deploy job runs

---

## 📄 Exit criteria

- [ ] A public repo with a working pipeline: test → lint → SAST → SCA → secrets → build → image scan
- [ ] **Five planted failures**, each screenshotted in the README
- [ ] `SECURITY.md` with gates, thresholds, suppressions and accepted residual risk
- [ ] Every action pinned to a SHA; `GITHUB_TOKEN` least-privilege
- [ ] You can explain, from experience, why an over-tuned gate is worse than no gate

> 🎯 **What this proves in an interview:** the complete reversal of your starting position. You began as someone who reviews pipelines and cannot build one. You now build them **and** reason about them at programme level — which is rarer than either skill alone, and is precisely what a Cloud Security Engineer is hired to do.

---

## 🎓 You are now on the main roadmap

Everything from here is the existing 18-month ladder, and you have the hands for it:

| Next | What changed |
|---|---|
| [Phase 1 — Terraform](../phases/phase-1-terraform.md) | You know Azure resources and Bicep. Terraform is now a syntax change, not a new concept |
| [Project 01](../projects/project-01-secure-cicd.md) | Your F4 pipeline **is** the first draft. Project 01 is the grown-up version |
| [CDP gap sequence](../tracks/README.md#-the-cdp-gap-closing-sequence) | Step 1 (GitLab CI) is now genuinely a weekend, because you have written a pipeline |
| [api-track](../api-track/) | You built and deployed the scaffold in F2 — go break it |

> **Recalibrate the timeline.** The main roadmap's "18 months" starts *now*, at month 9. Total is roughly 27 months to CCSP — but you will be in a Cloud Security Engineer role somewhere around month 10–14, and the rest happens with an employer's support and a job that generates the reps for you.

---

## 📚 Resources

| Resource | Type | Priority |
|---|---|---|
| [GitHub Actions documentation](https://docs.github.com/en/actions) (free, official) | Docs | ⭐⭐⭐ |
| [Security hardening for GitHub Actions](https://docs.github.com/en/actions/security-for-github-actions) | Docs | ⭐⭐⭐ |
| [Semgrep](https://semgrep.dev/docs/) · [Trivy](https://trivy.dev/) · [Gitleaks](https://github.com/gitleaks/gitleaks) — quickstarts | Docs | ⭐⭐⭐ |
| [OWASP DSOMM](https://dsomm.owasp.org) — score your own pipeline | Reference | ⭐⭐ |
| [act](https://github.com/nektos/act) — run Actions locally, saves a lot of push-and-pray | Tool | ⭐⭐ |

---

_← [F3 — Cloud you can build in](f3-azure.md) · [Foundations](README.md) | [Phase 1 — Terraform →](../phases/phase-1-terraform.md)_
