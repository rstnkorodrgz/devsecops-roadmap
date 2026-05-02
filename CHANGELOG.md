# Changelog

All notable changes to `install.sh` are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

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
