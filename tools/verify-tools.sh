#!/bin/bash
# DevSecOps Tool Verification Script
# Run: bash tools/verify-tools.sh

echo "=============================="
echo " DevSecOps Tool Verification"
echo " MacBook Pro 2020 13\""
echo "=============================="
echo ""

pass=0
fail=0

check() {
  local name="$1"
  local cmd="$2"
  if eval "$cmd" &>/dev/null 2>&1; then
    echo "  ✅  $name"
    ((pass++))
  else
    echo "  ❌  $name  — not found or not working"
    ((fail++))
  fi
}

echo "── Phase 1: Cloud Security ──────────────────"
check "AWS CLI v2"         "aws --version"
check "aws-vault"          "aws-vault --version"
check "iamlive"            "iamlive --help"
check "prowler"            "prowler --version"
check "steampipe"          "steampipe --version"
check "trufflehog"         "trufflehog --version"
check "detect-secrets"     "detect-secrets --version"
check "jq"                 "jq --version"
check "yq"                 "yq --version"

echo ""
echo "── Phase 2: CI/CD & Container Security ──────"
check "Docker"             "docker --version"
check "trivy"              "trivy --version"
check "grype"              "grype version"
check "syft"               "syft version"
check "dive"               "dive --version"
check "hadolint"           "hadolint --version"
check "dockle"             "dockle --version"
check "gitleaks"           "gitleaks version"
check "cosign"             "cosign version"
check "semgrep"            "semgrep --version"
check "pre-commit"         "pre-commit --version"

echo ""
echo "── Phase 2: Kubernetes ───────────────────────"
check "kubectl"            "kubectl version --client"
check "kind"               "kind version"
check "helm"               "helm version"
check "kube-bench"         "kube-bench version"
check "kubescape"          "kubescape version"
check "opa"                "opa version"
check "kubectx"            "kubectx --help"
check "k9s"                "k9s version"

echo ""
echo "── Phase 3: AppSec & Threat Modeling ────────"
check "ffuf"               "ffuf -V"
check "nuclei"             "nuclei -version"
check "httpie"             "http --version"
check "threagile"          "threagile --help"
# tfsec deprecated -> covered by trivy (checked above)
check "terrascan"          "terrascan version"
check "checkov"            "checkov --version"
check "terraform"          "terraform version"
check "istioctl"           "istioctl version --remote=false"
check "gcloud"             "gcloud --version"
check "azure-cli"          "az --version"

echo ""
echo "── Phase 4: Expert Tools ─────────────────────"
check "bandit"             "bandit --version"
check "safety"             "safety --version"
check "go"                 "go version"

echo ""
echo "══════════════════════════════"
echo "  Installed : $pass"
echo "  Missing   : $fail"
echo "  Total     : $((pass + fail))"
echo "══════════════════════════════"

if [ "$fail" -eq 0 ]; then
  echo ""
  echo "  All tools installed! Ready to start the roadmap."
else
  echo ""
  echo "  Run: brew bundle install --file=Brewfile"
  echo "  Then check tools/macos-setup.md for manual installs."
fi
