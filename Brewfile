# DevSecOps Engineer — MacBook Pro 2020 Brewfile
# Run: brew bundle install --file=Brewfile

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
# iamlive — removed from Homebrew; install.sh uses: go install github.com/iann0036/iamlive@latest
# prowler — removed from Homebrew; install.sh uses: pip3 install prowler
tap  "turbot/tap"
brew "steampipe"
brew "trufflehog"

# --- Phase 1.5: IaC & Policy as Code ---
tap  "hashicorp/tap"
brew "hashicorp/tap/terraform"
brew "terragrunt"
brew "conftest"
brew "infracost"

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
# tfsec — merged into Trivy (installed above); use `trivy config <dir>`
brew "terrascan"
cask "google-cloud-sdk"
brew "azure-cli"

# --- Phase 3.5: Platform Engineering ---
brew "kustomize"
brew "argocd"
brew "kyverno"
brew "vcluster"

# --- Phase 3 & 4: Python toolchain ---
brew "python@3.11"
