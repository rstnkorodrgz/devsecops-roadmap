# Homebrew Packages Reference

> Install everything at once using the `Brewfile` below,  
> or install tools phase-by-phase as you progress.

---

## 🚀 One-Shot Installation (All Phases)

Save the `Brewfile` below to the root of this repo, then run:

```bash
# From the repo root
brew bundle install --file=Brewfile
```

---

## 📄 Brewfile

```ruby
# =============================================================
# DevSecOps Engineer — MacBook Pro 2020 Brewfile
# Run: brew bundle install --file=Brewfile
# =============================================================

# --- Core Shell & Terminal ---
cask "iterm2"
brew "fzf"
brew "bat"
brew "eza"
brew "jq"
brew "yq"
brew "tree"
brew "htop"
brew "wget"

# --- Phase 1: Cloud Security ---
brew "awscli"
brew "aws-vault"
brew "iamlive"
brew "prowler"
tap  "turbot/tap"
brew "steampipe"
brew "trufflehog"

# --- Phase 2: CI/CD & Container Security ---
cask "docker"
brew "trivy"
brew "grype"
brew "syft"
brew "dive"
brew "hadolint"
tap  "goodwithtech/r"
brew "goodwithtech/r/dockle"
brew "gitleaks"
brew "cosign"
brew "semgrep"
brew "pre-commit"

# --- Phase 2: Kubernetes ---
brew "kubectl"
brew "kind"
brew "helm"
brew "kube-bench"
brew "kubescape"
brew "opa"
brew "kubectx"
brew "k9s"

# --- Phase 3: AppSec & Threat Modeling ---
cask "drawio"
cask "owasp-zap"
brew "ffuf"
brew "nuclei"
brew "httpie"
brew "go"
brew "istioctl"
# brew "tfsec"  # DEPRECATED — merged into trivy; use `trivy config`
brew "terrascan"
brew "terraform"
cask "google-cloud-sdk"
brew "azure-cli"

# --- Phase 3 & 4: Python toolchain ---
brew "python@3.11"
```

---

## 📦 Manual Installs (not in Homebrew)

These tools require manual download or pip install:

| Tool | Install Method | Phase |
|---|---|---|
| OWASP Threat Dragon | [GitHub Releases](https://github.com/OWASP/threat-dragon/releases) `.dmg` | 3 |
| Threagile | [GitHub Releases](https://github.com/Threagile/threagile/releases) binary | 3 |
| ~~kube-hunter~~ | unmaintained — use kubescape / `trivy k8s` | 2 |
| jwt_tool | `pip3 install jwt_tool` | 3 |
| detect-secrets | `pip3 install detect-secrets` | 1 |
| checkov | `pip3 install checkov` | 3 |
| bandit | `pip3 install bandit` | 4 |
| safety | `pip3 install safety` | 4 |
| scoutsuite | `pip3 install scoutsuite` | 4 |
| katana | `go install github.com/projectdiscovery/katana/...` | 3 |
| cloudmapper | `pip3 install cloudmapper` | 1 |
| Tetragon | `helm install` into cluster | 4 |
| Falco | `helm install` into cluster | 2 |

---

## 🐍 Python Tools — Batch Install

```bash
pip3 install --upgrade pip
pip3 install \
  jwt_tool \
  detect-secrets \
  checkov \
  bandit \
  safety \
  scoutsuite \
  cloudmapper
```

---

## 🔍 Verify All Installations

Run this script to check which tools are installed:

```bash
#!/bin/bash
# save as: tools/verify-tools.sh
# run: bash tools/verify-tools.sh

tools=(
  "aws --version"
  "aws-vault --version"
  "prowler --version"
  "steampipe --version"
  "trufflehog --version"
  "detect-secrets --version"
  "docker --version"
  "trivy --version"
  "grype version"
  "syft version"
  "dive --version"
  "hadolint --version"
  "gitleaks version"
  "cosign version"
  "semgrep --version"
  "pre-commit --version"
  "kubectl version --client"
  "kind version"
  "helm version"
  "kubescape version"
  "opa version"
  "k9s version"
  "ffuf -V"
  "nuclei -version"
  "http --version"
  "terraform version"
  "gcloud --version"
  "az --version"
  "checkov --version"
  "bandit --version"
  "jq --version"
  "yq --version"
)

echo "=============================="
echo " DevSecOps Tool Verification"
echo "=============================="
echo ""

pass=0
fail=0

for cmd in "${tools[@]}"; do
  tool_name=$(echo "$cmd" | awk '{print $1}')
  if eval "$cmd" &>/dev/null; then
    echo "✅ $tool_name"
    ((pass++))
  else
    echo "❌ $tool_name — NOT FOUND"
    ((fail++))
  fi
done

echo ""
echo "=============================="
echo "  Installed: $pass | Missing: $fail"
echo "=============================="
```

- [ ] Brewfile saved to repo root
- [ ] `brew bundle install` completed without errors
- [ ] `bash tools/verify-tools.sh` shows all green

---

_← [macOS Setup](macos-setup.md) | [Back to README](../README.md) | [Lab Environments →](lab-environments.md)_
