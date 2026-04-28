# macOS Tool Setup — MacBook Pro 2020 13"

> **System:** MacBook Pro 2020 13" — supports both Intel and Apple Silicon (M1)  
> **OS target:** macOS Ventura / Sonoma  
> All commands are tested for both architectures unless noted.

---

## 📋 Pre-Installation Checklist

- [ ] macOS is up to date (`System Settings → General → Software Update`)
- [ ] At least 20 GB free disk space available
- [ ] Xcode Command Line Tools installed (see Step 1)
- [ ] Terminal app ready (recommend installing iTerm2)

---

## 🍺 Step 1 — Homebrew & Core Prerequisites

Homebrew is the package manager for everything that follows.

```bash
# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Apple Silicon only — add Homebrew to PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Intel Mac — Homebrew installs to /usr/local (already in PATH)

# Verify installation
brew --version
brew doctor
```

- [ ] Homebrew installed and `brew doctor` returns "Your system is ready to brew"
- [ ] `brew --version` outputs a version number

---

## 🔧 Step 2 — Shell & Terminal Setup

```bash
# Install iTerm2 (better terminal)
brew install --cask iterm2

# Install Oh My Zsh (optional but recommended)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install useful shell tools
brew install zsh-autosuggestions zsh-syntax-highlighting
brew install fzf       # fuzzy finder
brew install bat       # better cat
brew install eza       # better ls
brew install jq        # JSON processor (critical for AWS/K8s work)
brew install yq        # YAML processor
brew install tree      # directory tree viewer
brew install htop      # system monitor
brew install wget curl # HTTP tools
```

- [ ] iTerm2 installed
- [ ] `jq --version` works
- [ ] `yq --version` works

---

## ☁️ Step 3 — Phase 1 Tools: Cloud Security

### AWS CLI & Credential Management

```bash
# AWS CLI v2
brew install awscli

# Verify
aws --version   # should show aws-cli/2.x.x

# aws-vault — secure credential storage using macOS Keychain
brew install aws-vault

# Configure aws-vault with a profile
aws-vault add my-aws-profile
# (prompts for Access Key ID and Secret Access Key)

# Use aws-vault to run commands
aws-vault exec my-aws-profile -- aws s3 ls
```

- [ ] `aws --version` returns v2.x.x
- [ ] `aws-vault --version` works
- [ ] AWS profile configured in aws-vault

```bash
# iamlive — generates IAM policies from live AWS API calls
brew install iamlive

# Usage: run iamlive in one terminal, AWS commands in another
# iamlive --set-ini --profile my-aws-profile
```

- [ ] `iamlive --help` works

### Cloud Assessment Tools

```bash
# prowler — AWS/GCP/Azure security assessment
brew install prowler
# OR via pip:
pip3 install prowler

# Verify
prowler --version

# steampipe — SQL queries against cloud APIs
brew tap turbot/tap
brew install steampipe

# Install AWS plugin
steampipe plugin install aws

# Verify
steampipe --version

# cloudmapper — AWS environment visualization
brew install python@3.11
pip3 install cloudmapper
```

- [ ] `prowler --version` works
- [ ] `steampipe --version` works
- [ ] `steampipe plugin list` shows aws plugin

### Secret Scanning

```bash
# trufflehog — secret scanning in git history and filesystems
brew install trufflehog

# detect-secrets — pre-commit secret detection
pip3 install detect-secrets

# Verify
trufflehog --version
detect-secrets --version
```

- [ ] `trufflehog --version` works
- [ ] `detect-secrets --version` works

---

## 🐳 Step 4 — Phase 2 Tools: CI/CD & Container Security

### Docker & Container Runtime

```bash
# Docker Desktop (includes Docker Engine, Compose, BuildKit)
brew install --cask docker

# Start Docker Desktop from Applications
# Then verify:
docker --version
docker compose version
docker run hello-world
```

- [ ] Docker Desktop installed and running
- [ ] `docker run hello-world` succeeds

### Container Scanning & Analysis

```bash
# trivy — comprehensive vulnerability scanner (images, repos, IaC, SBOMs)
brew install trivy

# grype — container and filesystem vulnerability scanner (Anchore)
brew install grype

# syft — SBOM generator
brew install syft

# dive — inspect Docker image layers
brew install dive

# hadolint — Dockerfile linter
brew install hadolint

# dockle — container image linter
brew install goodwithtech/r/dockle

# Verify all
trivy --version
grype version
syft version
dive --version
hadolint --version
dockle --version
```

- [ ] `trivy --version` works
- [ ] `grype version` works
- [ ] `syft version` works
- [ ] `dive --version` works
- [ ] `hadolint --version` works

### Secret & Supply Chain Tools

```bash
# gitleaks — secret scanner for git repos
brew install gitleaks

# cosign — container image signing (Sigstore)
brew install cosign

# semgrep — SAST scanner
brew install semgrep

# Verify
gitleaks version
cosign version
semgrep --version
```

- [ ] `gitleaks version` works
- [ ] `cosign version` works
- [ ] `semgrep --version` works

### Set up Gitleaks pre-commit hook

```bash
# Install pre-commit framework
brew install pre-commit

# In your git repo, create .pre-commit-config.yaml:
cat > ~/.pre-commit-config-template.yaml << 'EOF'
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.0
    hooks:
      - id: gitleaks
  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets
EOF

echo "Template saved to ~/.pre-commit-config-template.yaml"
echo "Copy to your repo root as .pre-commit-config.yaml and run: pre-commit install"
```

- [ ] `pre-commit --version` works
- [ ] Pre-commit config template created

### Kubernetes Tools

```bash
# kubectl — Kubernetes CLI
brew install kubectl

# kind — local Kubernetes clusters via Docker
brew install kind

# helm — Kubernetes package manager
brew install helm

# kube-bench — CIS Kubernetes Benchmark auditor
brew install kube-bench

# kube-hunter — Kubernetes penetration testing
pip3 install kube-hunter

# kubescape — Kubernetes security scanner (NSA/CISA guidelines)
brew install kubescape

# opa — Open Policy Agent CLI
brew install opa

# kubectx + kubens — context and namespace switcher
brew install kubectx

# k9s — terminal UI for Kubernetes
brew install k9s

# Verify all
kubectl version --client
kind version
helm version
kubescape version
opa version
k9s version
```

- [ ] `kubectl version --client` works
- [ ] `kind version` works
- [ ] `helm version` works
- [ ] `kubescape version` works
- [ ] `opa version` works
- [ ] `k9s version` works

### Create a local Kubernetes cluster

```bash
# Create a kind cluster for labs
kind create cluster --name devsecops-lab

# Verify cluster is running
kubectl cluster-info --context kind-devsecops-lab
kubectl get nodes
```

- [ ] `kind-devsecops-lab` cluster running
- [ ] `kubectl get nodes` shows a Ready node

---

## 🔍 Step 5 — Phase 3 Tools: AppSec & Threat Modeling

### Threat Modeling

```bash
# threagile — threat modeling as code
# Download binary from GitHub releases
THREAGILE_VERSION="1.0.0"
curl -L "https://github.com/Threagile/threagile/releases/latest/download/threagile-macos-amd64.zip" \
  -o /tmp/threagile.zip
# Apple Silicon: use threagile-macos-arm64.zip

unzip /tmp/threagile.zip -d /usr/local/bin/
chmod +x /usr/local/bin/threagile
threagile --help

# drawio — architecture diagramming
brew install --cask drawio

# OWASP Threat Dragon
# Download from: https://github.com/OWASP/threat-dragon/releases
# Install the .dmg for macOS
```

- [ ] `threagile --help` works
- [ ] Draw.io installed
- [ ] OWASP Threat Dragon installed

### Web AppSec Tools

```bash
# OWASP ZAP — web application scanner
brew install --cask owasp-zap

# ffuf — fast web fuzzer
brew install ffuf

# nuclei — template-based vulnerability scanner
brew install nuclei

# Update nuclei templates
nuclei -update-templates

# katana — web crawler for attack surface mapping
go install github.com/projectdiscovery/katana/cmd/katana@latest
# Requires Go — install first:
brew install go

# httpie — API testing CLI
brew install httpie

# jwt_tool — JWT testing and attacks (Python)
pip3 install jwt_tool

# Verify
ffuf -V
nuclei -version
http --version
```

- [ ] `ffuf -V` works
- [ ] `nuclei -version` works
- [ ] `http --version` works (httpie)
- [ ] OWASP ZAP installed

### Istio (Service Mesh)

```bash
# istioctl — Istio CLI
brew install istioctl

# Verify
istioctl version

# Install Istio into your kind cluster
istioctl install --set profile=demo -y

# Verify Istio pods running
kubectl get pods -n istio-system
```

- [ ] `istioctl version` works
- [ ] Istio running in `istio-system` namespace

### Multi-Cloud & IaC Security

```bash
# checkov — IaC security scanner (Terraform, CloudFormation, K8s manifests)
pip3 install checkov

# tfsec — Terraform security scanner
brew install tfsec

# terrascan — multi-cloud IaC scanner
brew install terrascan

# terraform — IaC tool
brew install terraform

# GCP CLI
brew install --cask google-cloud-sdk
gcloud init

# Azure CLI
brew install azure-cli
az login

# Verify
checkov --version
tfsec --version
terrascan version
terraform version
gcloud --version
az --version
```

- [ ] `checkov --version` works
- [ ] `tfsec --version` works
- [ ] `terraform version` works
- [ ] `gcloud --version` works
- [ ] `az --version` works

---

## 🧠 Step 6 — Phase 4 Tools: Expert & Emerging

```bash
# tetragon — eBPF-based runtime security (install via Helm into cluster)
helm repo add cilium https://helm.cilium.io
helm repo update

# Install Tetragon into your kind cluster
helm install tetragon cilium/tetragon \
  --namespace kube-system

# Verify
kubectl get pods -n kube-system | grep tetragon
```

- [ ] Tetragon running in cluster

---

## 🛡️ Step 7 — Python Security Libraries

```bash
# Ensure pip is up to date
pip3 install --upgrade pip

# Install all Python security tools at once
pip3 install \
  bandit \          # Python SAST
  safety \          # Python dependency vulnerability scanner
  semgrep \         # multi-language SAST
  checkov \         # IaC scanner
  detect-secrets \  # pre-commit secret detection
  scoutsuite \      # multi-cloud security auditing
  prowler           # AWS/GCP/Azure security assessment

# Verify key tools
bandit --version
safety --version
scoutsuite --version
```

- [ ] `bandit --version` works
- [ ] `safety --version` works

---

## ✅ Full Tool Installation Progress

### Phase 1 Tools
- [ ] AWS CLI v2
- [ ] aws-vault
- [ ] iamlive
- [ ] prowler
- [ ] steampipe + AWS plugin
- [ ] trufflehog
- [ ] detect-secrets

### Phase 2 Tools
- [ ] Docker Desktop
- [ ] trivy
- [ ] grype
- [ ] syft
- [ ] dive
- [ ] hadolint
- [ ] dockle
- [ ] gitleaks
- [ ] cosign
- [ ] semgrep
- [ ] pre-commit
- [ ] kubectl
- [ ] kind
- [ ] helm
- [ ] kube-bench
- [ ] kubescape
- [ ] opa
- [ ] kubectx
- [ ] k9s

### Phase 3 Tools
- [ ] threagile
- [ ] Draw.io
- [ ] OWASP Threat Dragon
- [ ] OWASP ZAP
- [ ] ffuf
- [ ] nuclei
- [ ] httpie
- [ ] jwt_tool
- [ ] istioctl
- [ ] checkov
- [ ] tfsec
- [ ] terrascan
- [ ] terraform
- [ ] gcloud CLI
- [ ] azure CLI

### Phase 4 Tools
- [ ] tetragon (in-cluster)
- [ ] bandit
- [ ] safety
- [ ] scoutsuite

---

_← [Back to README](../README.md) | [Homebrew Packages →](homebrew-packages.md)_
