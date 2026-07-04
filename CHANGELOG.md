# Changelog

All notable changes to this repo — roadmap content and `install.sh` — are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

---

## Roadmap [v2.1] — 2026-07-04 — API Track + Credential Refresh

Content pass: adds the hands-on API track and cleans the credential presentation for recruiters.

### Added
- **`api-track/`** — a hands-on Build → Secure → Test → Break API path with a runnable FastAPI "Findings API" scaffold (SQLModel + SQLite, Docker, pytest; verified 4/4 tests + live boot). Ships an intentional BOLA closed in Phase 2 / exploited in Phase 4. Companion to `tracks/appsec.md` Module B; feeds Pillars C and D.
- **Networking / network-security refresh training** — new Phase 0 section in `resources/courses.md` (John Savill Azure Networking Master Class, Practical Networking, Microsoft Learn network paths) and `**Refresh with:**` pointers in `phases/phase-0-foundation.md`.

### Changed
- **Credential Baseline (README) lists active credentials only** — expired CCNA and SonicWall Administrator removed from the recruiter-facing snapshot; replaced with a one-line note that the underlying networking/network-security foundation is being refreshed to cloud-native.
- **Phase 0 Leverage Map reframed** — "Completed Credentials" → "Active Credential" + a new "Prior Experience — Refresh to Cloud-Native" section; the legacy→modern tables are now refresh checklists rather than "certs you already hold."
- **CISSP-contingency D4 note** de-references the lapsed CCNA (now "networking foundation refreshed in Phase 0").

---

## Roadmap [v2.0] — 2026-07-03 — Technical Expertise Track

Strategy shift: deep technical IC track (senior → staff/principal). Azure-primary. Quarterly artifact rule.

### Changed
- **Identity:** target is Staff/Principal deep-technical IC, not the architect/management ladder
- **CCSP replaces CISSP as capstone** (Phase 5, months 14–18); CISSP demoted to a trigger-gated contingency (`electives/cissp-contingency.md`, ≥2 postings/quarter trigger, 16-week sprint plan). CCSP notes: CAT 100–150 Q/3 h since late 2025; **new outline effective 2026-08-01** — use post-refresh materials
- **SC-500 replaces the planned AZ-500** (Phase 4, months 10–13): research during implementation found **AZ-500 retired 2026-08-31**, before the phase window; SC-500 (Cloud and AI Security Engineer Associate) is Microsoft's direct replacement and adds AI security — compounds with Pillar C
- **Azure-primary labs**: Phase 1 landing zone rebuilt on azurerm (hub-spoke, AKS, Key Vault, GitHub OIDC federation); AWS SCS + the complete v1.x AWS track moved to `electives/aws-security-specialty.md` as a **dormant elective** (trigger: USD-remote/AWS-heavy pivot). Multi-cloud lives at design level in the Phase 5 capstone
- **Cert ladder:** Terraform (M1–3) → CKA (M4–6) → CKS ★ (M7–9) → SC-500 (M10–13) → CCSP (M14–18); exams booked at phase **start**
- Timeline unit is now **months/quarters** (18-month plan), replacing the v1.3 global 52-week scheme; `progress/quarterly-tracker.md` replaces the weekly table (weekly log kept as optional template)
- Phase files restructured: `phase-1.5-iac.md` → `phase-1-terraform.md`; `phase-2-cicd.md` → `phase-3-cks.md` (CKA block extracted to new `phase-2-cka.md`); `phase-3-appsec.md` → `tracks/appsec.md`; `phase-3.5-platform-engineering.md` → `tracks/platform-engineering.md`; `phase-1-cloud.md` → `electives/aws-security-specialty.md`; `phase-4-cissp.md` → `electives/cissp-contingency.md`
- `architect/` reframed as the Pillar D reading library; **SABSA demoted to optional reading** (no SCF/SCP)
- `projects/README.md` gains a v1.x→v2.0 migration map; the five briefs remain the working specs

### Added
- **`pillars/`** — Phase 6, the post-certification technical ladder: A open source (ONE CNCF project — Trivy recommended; tfsec explicitly not a target, it merged into Trivy), B research & speaking (2 talks/yr + written versions; Santiago → 8.8 → BSides/DragonJAR ladder), C AI security specialization (LLM testing harness, secure RAG reference architecture, CI/CD AI gates), D architecture depth (reference architectures, ADR habit, quarterly sanitized design doc)
- **Quarterly artifact rule** as roadmap-wide KPI + `progress/quarterly-tracker.md` with the 6-quarter plan, cert milestones, KPI checklist, and elective-trigger review
- New phase files: `phase-2-cka.md`, `phase-4-sc500.md`, `phase-5-ccsp.md`
- `electives/README.md` — explicit trigger table (AWS SCS, CISSP, GWEB/GCP)

### Known gaps
- `install.sh` still uses the v1.x phase layout (`--phase 1.5` = IaC tools etc.) — functional but numbering no longer matches; Azure-specific SC-500 tooling is minimal (az CLI already covered). Installer v1.5 when tool needs firm up
- `resources/courses.md` partially retagged; deep SC-500 third-party materials still thin (new exam) — Microsoft Learn is the canonical path

---

## Roadmap [v1.3] — 2026-07-02

Content-currency and consistency pass on the v1.2 capability-centric restructure.

### Added
- **CKA block in Phase 2 (Weeks 19–22)** — a passed, active CKA is a registration prerequisite for CKS; Phase 2 extended from 12 to 16 weeks
- **AI/LLM security module in Phase 3 (Weeks 38–40)** — OWASP LLM Top 10, prompt injection labs, AI pipeline security, NIST AI RMF awareness
- **Terraform Associate exam milestone** in Phase 1.5 Week 12
- **OpenTofu awareness note** in Phase 1.5 (post-IBM acquisition of HashiCorp)
- **AWS cost note** in the README Quick Start (budget alert + teardown discipline)
- Resources for Phases 0 / 1.5 / 3.5 and the architect track in `resources/courses.md`

### Changed
- **Global week numbering across all phases** — honest total of 52 weeks (~12 months); previously mixed local/global schemes summed to 48+ weeks against a "~10 months" claim, with Phase 3.5 colliding with Phase 4
- **Certification ladder reordered to match phase order** (AWS SCS → Terraform Associate → CKA → CKS → CISSP → SABSA)
- **CIS AWS Foundations Benchmark v1.5 → v5.0** (published March 2025; what Security Hub scores against)
- **SLSA references updated to v1.0** — Build track L0–L3; the draft-era "Level 4" no longer exists
- **CISSP exam facts corrected** — CAT format is 3 hours / 100–150 questions since April 2024 (was listed as 4 hours / 125–175)
- **CVSS coverage now v3.1 + v4.0** in Phase 3
- **Pod Security Admission replaces PodSecurityPolicy** in Phase 2 (PSP removed in K8s 1.25, off the CKS exam)
- **NIST SP 800-88 replaces DoD 5220.22-M** for media sanitization in Phase 4
- **tfsec → Trivy (`trivy config`)** as the default IaC scanner across phases, Project 03, and tools docs (tfsec merged into Trivy, no new checks)
- **Phase 4 Full Roadmap Completion Checklist rewritten** — all 7 phases + 5 certs + architect track + 5 projects (previously still listed GWEB and only 3 projects)
- **Weekly log regenerated** — 52-week table matching the new structure; cert milestones now AWS SCS / Terraform / CKA / CKS / CISSP (GWEB removed)
- SANS SEC542 / GWEB prep demoted to optional-priority in resources

### Removed
- **kube-hunter** from Phase 2 tools and tools docs (unmaintained; `kubescape` / `trivy k8s` cover it)

### Known gaps
- ~~`install.sh` still installs `tfsec` and `kube-hunter`~~ — resolved by installer v1.4.0 (below)

---

## [v1.4.0] — 2026-07-02

Aligns the installer with roadmap v1.3.

### Added
- **`--phase 1.5`** — IaC & policy-as-code tools: terraform (hashicorp/tap), terragrunt, conftest, infracost, trivy, opa, checkov
- **`--phase 3.5`** — platform engineering tools: kustomize, argocd, kyverno, vcluster
- Verify-mode sections for Phases 1.5 and 3.5
- Brewfile: `hashicorp/tap` terraform plus the Phase 1.5 / 3.5 formulas

### Removed
- **tfsec** — merged into Trivy; `trivy config <dir>` replaces it (informational message printed instead)
- **kube-hunter** — unmaintained upstream (last release 2022); kubescape / `trivy k8s` cover it
- Brewfile: stale `brew "tfsec"`, core `brew "terraform"` (moved to hashicorp/tap), and broken `brew "iamlive"` / `brew "prowler"` lines (both removed from Homebrew — install.sh installs them via `go install` / pip3)

### Changed
- terraform + checkov installation moved from Phase 3 into Phase 1.5 (phase installs are cumulative, so every path that needs them still gets them; Phase 3 keeps terrascan)
- tflint: no Homebrew formula available — prints a pointer to GitHub releases instead of failing
- Banner updated: v1.4, cert ladder now `SCS-C02 → TF Assoc → CKA → CKS → CISSP` (GWEB removed), "70+ tools · 7 phases · 12 months · 5 certifications"; fixed two banner lines that under-padded multi-byte glyphs (`·`, `—`) and broke the box border
- `--help` and error messages document the new phase arguments

---

## [v1.3.0] — 2026-05-02

### Fixed
- **iamlive** — Homebrew formula removed upstream; switched to `go install github.com/iann0036/iamlive@latest` (FIX 12)
- **steampipe AWS plugin** — removed `--agree-tos` flag deleted in steampipe v0.21+ (FIX 11 update)
- **jwt_tool** — not on PyPI and GitHub repo has no `setup.py`/`pyproject.toml`; switched to downloading standalone script + `pip install` of requirements (FIX 13)
- **terraform** — formula moved from Homebrew core to `hashicorp/tap`; installer now taps `hashicorp/tap` first (FIX 14)
- **threagile** — GitHub releases v0.9.x have no binary assets; switched to Docker image `threagile/threagile:latest` with a `~/.local/bin/threagile` shell wrapper (FIX 15); added daemon-running check with actionable error message (FIX 18)
- **cloudmapper** — removed from PyPI and unmaintained since 2022; replaced install attempt with an informational message (FIX 16)
- **GitGuardian VS Code extension** — wrong extension ID `gitguardian.gitguardian`; corrected to `gitguardian-secret-security.gitguardian` (FIX 17)
- **pip_install** — `--break-system-packages --ignore-installed` still hit `Permission denied: /usr/local/LICENSE` on Homebrew-managed deps (pydantic, cryptography); switched to `PYTHONUSERBASE=$HOME/.local pip3 install --user --break-system-packages --ignore-installed` so all pip CLI tools land in `~/.local/bin` (FIX 4 update)
- **pip_install skip check** — `pip3 show` used default sys path and missed `~/.local` installs; check now also probes with `PYTHONUSERBASE=$HOME/.local`
- **brew_install skip check** — tap-installed formulas (e.g. `aquasecurity/trivy/trivy`) weren't caught by the `brew list` leaf-name grep; added `command -v "$leaf"` fallback

### Changed
- `~/.zshrc` updated to export `GOPATH`, `~/go/bin`, and `~/.local/bin` in every shell session (previously only in `~/.zprofile`, which is login-only and missed by scripts/non-login shells)
- Version bumped from v1.1 → v1.3 (v1.2 was released without a banner update)

---

## [v1.2.0] — 2026-04-27

### Fixed (12 bugs — commit `7d1eb07`)
- **set -e arithmetic** — bare `(( expr ))` returns 1 on zero result, killing the script under `set -e`; wrapped in `|| true`
- **pip break-system-packages** — added `--break-system-packages` flag required by macOS PEP 668 "externally managed" Python (FIX 4)
- **prowler pip** — brew formula removed; switched to `pip3 install prowler` (FIX 6)
- **GOPATH** — `~/go/bin` not exported before `go install` calls; added `ensure_gopath` helper (FIX 7)
- **~/.local/bin** — `gh_binary` destination not in PATH; `ensure_gopath` / `gh_binary` now append to `~/.zprofile` and export for current session (FIX 8)
- **tap exit codes** — `brew_tap` didn't propagate failure; dependent installs now skip when tap fails (FIX 9)
- **nuclei templates** — `-update-templates` flag renamed; switched to `-ut` short flag (FIX 10)
- **steampipe plugin** — non-TTY runs hung on license prompt; added `--agree-tos` flag (FIX 11, later superseded in v1.3)
- **dockle tap** — `goodwithtech/r` tap qualification added
- **kube-hunter** — brew formula removed; switched to pip3
- **brew_install leaf name** — tap-qualified names like `goodwithtech/r/dockle` now strip to leaf for `brew list` check (FIX 5)
- **vscode_install** — missing `code` CLI no longer aborts the run; returns 0 with a warning (FIX 2)

---

## [v1.1.0] — 2026-04-27

### Added (commit `c589903`)
- 22 VS Code extensions across all 4 phases:
  - Phase 0/1: Prettier, GitLens, ShellCheck, Shell Script, Markdown All in One, AWS Toolkit, HashiCorp Terraform, YAML, DotENV
  - Phase 2: Docker, Kubernetes, GitHub Actions, Semgrep, hadolint, OPA
  - Phase 3: REST Client, JWT Decoder, SonarLint, Snyk Security, GitGuardian
  - Phase 4: Python, Azure Tools
- `vscode_install` helper with skip-if-already-installed logic
- `verify_ext` function added to `--verify` mode for VS Code extension checks

---

## [v1.0.0] — 2026-04-27

### Added (commit `5da628e`)
- Initial installer covering 65 tools across 4 phases
- Phase 0: Homebrew, jq, yq, tree, wget, Python 3, Go
- Phase 1: AWS CLI v2, aws-vault, iamlive, steampipe, prowler, trufflehog, detect-secrets
- Phase 2: Docker, semgrep, trivy, grype, syft, dive, hadolint, dockle, gitleaks, cosign, pre-commit, kubectl, kind, helm, kube-bench, kubescape, opa, kubectx, k9s, kube-hunter
- Phase 3: Draw.io, OWASP ZAP, ffuf, nuclei, httpie, istioctl, jwt_tool, katana, terraform, tfsec, terrascan, checkov, gcloud CLI, Azure CLI, threagile
- Phase 4: bandit, safety, ScoutSuite, cloudmapper
- `--verify` mode to check all tools without installing
- Spinner, color output, and structured pass/fail/skip status lines
- Installation log at `~/devsecops-install.log`
