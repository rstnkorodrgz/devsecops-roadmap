#!/usr/bin/env bash
# =============================================================================
#  PATH 2 DEVSECOPS — Automated Tool Installer v1.0
#  MacBook Pro 2020 13" (Intel & Apple Silicon)
#
#  Usage:
#    bash install.sh              # install all phases
#    bash install.sh --phase 1   # install Phase 1 tools only
#    bash install.sh --phase 2   # install Phase 2 tools only
#    bash install.sh --phase 3   # install Phase 3 tools only
#    bash install.sh --phase 4   # install Phase 4 tools only
#    bash install.sh --verify    # verify all tools without installing
#    bash install.sh --help      # show this help
#
#  Log file: ~/devsecops-install.log
# =============================================================================

set -euo pipefail

# ── Colours ──────────────────────────────────────────────────────────────────
RED='\033[0;31m';  GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m';  BOLD='\033[1m';  RESET='\033[0m'
DIM='\033[2m';     WHITE='\033[0;37m'

# ── Log file ─────────────────────────────────────────────────────────────────
LOG="$HOME/devsecops-install.log"
> "$LOG"   # clear on each run

log() { echo "[$(date '+%H:%M:%S')] $*" >> "$LOG"; }

# ── Counters ─────────────────────────────────────────────────────────────────
PASS=0; FAIL=0; SKIP=0

# ── Helpers ──────────────────────────────────────────────────────────────────
spinner() {
  local pid=$1 msg=$2
  local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
  local i=0
  while kill -0 "$pid" 2>/dev/null; do
    printf "\r  ${CYAN}%s${RESET} ${WHITE}%s${RESET}  " "${frames[$((i++ % 10))]}" "$msg"
    sleep 0.08
  done
  printf "\r%-70s\r" " "
}

status_ok()   { printf "  ${GREEN}✔${RESET}  %-42s ${GREEN}[  OK  ]${RESET}\n" "$1"; log "OK      $1"; ((PASS++)); }
status_fail() { printf "  ${RED}✘${RESET}  %-42s ${RED}[FAILED]${RESET}\n" "$1"; log "FAILED  $1 — $2"; ((FAIL++)); }
status_skip() { printf "  ${YELLOW}–${RESET}  %-42s ${YELLOW}[ SKIP ]${RESET}\n" "$1"; log "SKIP    $1 — $2"; ((SKIP++)); }
status_prog() { printf "  ${CYAN}…${RESET}  %-42s ${CYAN}[  ..  ]${RESET}\n" "$1"; }

section() {
  echo ""
  echo -e "  ${BOLD}${BLUE}══════════════════════════════════════════════════${RESET}"
  printf   "  ${BOLD}${BLUE}  %-46s${RESET}\n" "$1"
  echo -e "  ${BOLD}${BLUE}══════════════════════════════════════════════════${RESET}"
  log "=== $1 ==="
}

# ── Banner ────────────────────────────────────────────────────────────────────
print_banner() {
  clear
  echo ""
  echo -e "${GREEN}${BOLD}"
  echo '  ██████╗  █████╗ ████████╗██╗  ██╗    ██████╗'
  echo '  ██╔══██╗██╔══██╗╚══██╔══╝██║  ██║    ╚════██╗'
  echo '  ██████╔╝███████║   ██║   ███████║      ███╔═╝'
  echo '  ██╔═══╝ ██╔══██║   ██║   ██╔══██║     ██╔══╝'
  echo '  ██║     ██║  ██║   ██║   ██║  ██║     ███████╗'
  echo '  ╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝     ╚══════╝'
  echo -e "${RESET}"
  echo -e "  ${BOLD}${WHITE}╔══════════════════════════════════════════════════╗${RESET}"
  echo -e "  ${BOLD}${WHITE}║${RESET}  ${CYAN}${BOLD}PATH 2 DEVSECOPS${RESET}${WHITE} — Automated Installer v1.0   ${BOLD}${WHITE}║${RESET}"
  echo -e "  ${BOLD}${WHITE}║${RESET}  ${DIM}MacBook Pro 2020 · Intel & Apple Silicon        ${RESET}${BOLD}${WHITE}║${RESET}"
  echo -e "  ${BOLD}${WHITE}╚══════════════════════════════════════════════════╝${RESET}"
  echo ""
  echo -e "  ${DIM}Certifications: AWS SCS-C02 → CKS → GWEB → CISSP${RESET}"
  echo -e "  ${DIM}Log file: ${LOG}${RESET}"
  echo ""
}

# ── Arch detection ────────────────────────────────────────────────────────────
detect_arch() {
  ARCH=$(uname -m)
  if [[ "$ARCH" == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"
    ARCH_LABEL="Apple Silicon (M1)"
  else
    BREW_PREFIX="/usr/local"
    ARCH_LABEL="Intel x86_64"
  fi
  echo -e "  ${DIM}Detected: ${WHITE}${ARCH_LABEL}${RESET}  |  Homebrew: ${WHITE}${BREW_PREFIX}${RESET}"
  echo ""
  log "Architecture: $ARCH_LABEL"
}

# ── Install a single brew formula ─────────────────────────────────────────────
brew_install() {
  local formula="$1"
  local display="${2:-$formula}"

  if brew list --formula 2>/dev/null | grep -q "^${formula}$"; then
    status_skip "$display" "already installed via Homebrew"
    return 0
  fi

  local tmp_out
  tmp_out=$(mktemp)

  (brew install "$formula" >> "$tmp_out" 2>&1) &
  local pid=$!
  spinner $pid "Installing $display"
  wait $pid
  local exit_code=$?

  if [[ $exit_code -eq 0 ]]; then
    status_ok "$display"
  else
    local reason
    reason=$(grep -i "error\|not found\|failed\|permission" "$tmp_out" 2>/dev/null | head -1 || echo "unknown error — check $LOG")
    status_fail "$display" "$reason"
    cat "$tmp_out" >> "$LOG"
  fi
  rm -f "$tmp_out"
}

# ── Install a brew cask ───────────────────────────────────────────────────────
cask_install() {
  local cask="$1"
  local display="${2:-$cask}"

  if brew list --cask 2>/dev/null | grep -q "^${cask}$"; then
    status_skip "$display" "already installed via Homebrew Cask"
    return 0
  fi

  local tmp_out
  tmp_out=$(mktemp)

  (brew install --cask "$cask" >> "$tmp_out" 2>&1) &
  local pid=$!
  spinner $pid "Installing $display (cask)"
  wait $pid
  local exit_code=$?

  if [[ $exit_code -eq 0 ]]; then
    status_ok "$display"
  else
    local reason
    reason=$(grep -i "error\|not found\|failed\|permission\|already" "$tmp_out" 2>/dev/null | head -1 || echo "check $LOG")
    status_fail "$display" "$reason"
    cat "$tmp_out" >> "$LOG"
  fi
  rm -f "$tmp_out"
}

# ── Install a brew tap ────────────────────────────────────────────────────────
brew_tap() {
  local tap="$1"
  if brew tap 2>/dev/null | grep -q "^${tap}$"; then
    log "Tap already added: $tap"
    return 0
  fi
  (brew tap "$tap" >> "$LOG" 2>&1) &
  local pid=$!
  spinner $pid "Adding tap $tap"
  wait $pid
}

# ── Install a pip package ─────────────────────────────────────────────────────
pip_install() {
  local pkg="$1"
  local display="${2:-$pkg}"

  if pip3 show "$pkg" &>/dev/null; then
    status_skip "$display" "already installed via pip3"
    return 0
  fi

  local tmp_out
  tmp_out=$(mktemp)

  (pip3 install --quiet "$pkg" >> "$tmp_out" 2>&1) &
  local pid=$!
  spinner $pid "Installing $display (pip3)"
  wait $pid
  local exit_code=$?

  if [[ $exit_code -eq 0 ]]; then
    status_ok "$display"
  else
    local reason
    reason=$(grep -i "error\|not found\|failed\|requires\|conflict" "$tmp_out" 2>/dev/null | head -1 || echo "pip3 failed — check $LOG")
    status_fail "$display" "$reason"
    cat "$tmp_out" >> "$LOG"
  fi
  rm -f "$tmp_out"
}

# ── Download a binary from GitHub ─────────────────────────────────────────────
gh_binary() {
  local name="$1"
  local url="$2"
  local dest="${3:-/usr/local/bin/$name}"
  local display="${4:-$name}"

  if command -v "$name" &>/dev/null; then
    status_skip "$display" "binary already in PATH"
    return 0
  fi

  local tmp
  tmp=$(mktemp)

  (curl -sSL "$url" -o "$tmp" >> "$LOG" 2>&1) &
  local pid=$!
  spinner $pid "Downloading $display"
  wait $pid
  local exit_code=$?

  if [[ $exit_code -ne 0 ]]; then
    status_fail "$display" "download failed — check internet connection or URL: $url"
    rm -f "$tmp"; return 1
  fi

  if [[ "$url" == *.zip ]]; then
    local tmpdir; tmpdir=$(mktemp -d)
    unzip -q "$tmp" -d "$tmpdir" >> "$LOG" 2>&1
    local binary; binary=$(find "$tmpdir" -name "$name" -type f | head -1)
    if [[ -n "$binary" ]]; then
      install -m 755 "$binary" "$dest" >> "$LOG" 2>&1 && status_ok "$display" || status_fail "$display" "could not move binary to $dest — try: sudo install"
    else
      status_fail "$display" "binary '$name' not found inside zip archive"
    fi
    rm -rf "$tmpdir"
  else
    install -m 755 "$tmp" "$dest" >> "$LOG" 2>&1 && status_ok "$display" || status_fail "$display" "could not move binary to $dest — try running with sudo"
  fi
  rm -f "$tmp"
}

# ── Verify a command exists ───────────────────────────────────────────────────
verify_cmd() {
  local cmd="$1"
  local display="${2:-$cmd}"
  if command -v "$cmd" &>/dev/null; then
    local ver; ver=$($cmd --version 2>/dev/null | head -1 || echo "installed")
    status_ok "$display  ${DIM}(${ver})${RESET}"
  else
    status_fail "$display" "not found in PATH — run: bash install.sh"
  fi
}

# =============================================================================
#  PHASE 0 — Prerequisites
# =============================================================================
phase0() {
  section "PHASE 0 — Prerequisites & Core Shell"

  echo -e "  ${DIM}Checking for Xcode Command Line Tools...${RESET}"
  if ! xcode-select -p &>/dev/null; then
    echo -e "  ${YELLOW}⚠  Xcode CLT not found — installing (you may see a GUI prompt)...${RESET}"
    xcode-select --install 2>/dev/null || true
    echo -e "  ${YELLOW}   Complete the Xcode install prompt, then re-run this script.${RESET}"
    exit 1
  else
    status_ok "Xcode Command Line Tools"
  fi

  if ! command -v brew &>/dev/null; then
    echo -e "  ${YELLOW}⚠  Homebrew not found — installing...${RESET}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >> "$LOG" 2>&1
    if [[ "$ARCH" == "arm64" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    fi
    status_ok "Homebrew (fresh install)"
  else
    status_ok "Homebrew  ${DIM}($(brew --version | head -1))${RESET}"
  fi

  echo -e "\n  ${DIM}Updating Homebrew...${RESET}"
  brew update --quiet >> "$LOG" 2>&1 && log "Homebrew updated" || log "Homebrew update had warnings (non-fatal)"

  brew_install jq        "jq (JSON processor)"
  brew_install yq        "yq (YAML processor)"
  brew_install tree      "tree"
  brew_install wget      "wget"
  brew_install python@3.11 "Python 3.11"
  brew_install go        "Go language"
}

# =============================================================================
#  PHASE 1 — Cloud Security Tools
# =============================================================================
phase1() {
  section "PHASE 1 — Cloud Security Tools"

  brew_install awscli    "AWS CLI v2"
  brew_install aws-vault "aws-vault (credential manager)"
  brew_install iamlive   "iamlive (IAM policy generator)"

  echo -e "\n  ${DIM}Adding Turbot tap for steampipe...${RESET}"
  brew_tap "turbot/tap"
  brew_install steampipe "steampipe (cloud SQL queries)"

  brew_install prowler   "prowler (cloud security auditor)"
  brew_install trufflehog "trufflehog (secret scanner)"
  pip_install  "detect-secrets" "detect-secrets (pre-commit hook)"

  echo -e "\n  ${DIM}Installing steampipe AWS plugin...${RESET}"
  if command -v steampipe &>/dev/null; then
    (steampipe plugin install aws >> "$LOG" 2>&1) &
    local pid=$!
    spinner $pid "steampipe AWS plugin"
    wait $pid && status_ok "steampipe AWS plugin" || status_fail "steampipe AWS plugin" "plugin install failed — run: steampipe plugin install aws"
  else
    status_fail "steampipe AWS plugin" "steampipe not installed — install it first"
  fi
}

# =============================================================================
#  PHASE 2 — CI/CD Pipeline & Container Security Tools
# =============================================================================
phase2() {
  section "PHASE 2 — CI/CD Pipeline & Container Tools"

  cask_install docker        "Docker Desktop"
  brew_install semgrep       "semgrep (SAST scanner)"
  brew_install trivy         "trivy (vuln & container scanner)"
  brew_install grype         "grype (vulnerability scanner)"
  brew_install syft          "syft (SBOM generator)"
  brew_install dive          "dive (image layer inspector)"
  brew_install hadolint      "hadolint (Dockerfile linter)"

  echo -e "\n  ${DIM}Adding goodwithtech tap for dockle...${RESET}"
  brew_tap "goodwithtech/r"
  brew_install goodwithtech/r/dockle "dockle (container linter)"

  brew_install gitleaks     "gitleaks (git secret scanner)"
  brew_install cosign       "cosign (artifact signing)"
  brew_install pre-commit   "pre-commit (git hooks)"

  section "PHASE 2 — Kubernetes Security Tools"

  brew_install kubectl      "kubectl (Kubernetes CLI)"
  brew_install kind         "kind (local K8s clusters)"
  brew_install helm         "helm (K8s package manager)"
  brew_install kube-bench   "kube-bench (CIS K8s auditor)"
  brew_install kubescape    "kubescape (K8s security scanner)"
  brew_install opa          "opa (Open Policy Agent CLI)"
  brew_install kubectx      "kubectx + kubens"
  brew_install k9s          "k9s (K8s terminal UI)"
  pip_install  "kube-hunter" "kube-hunter (K8s pen test)"
}

# =============================================================================
#  PHASE 3 — AppSec & Threat Modeling Tools
# =============================================================================
phase3() {
  section "PHASE 3 — AppSec & Threat Modeling Tools"

  cask_install drawio       "Draw.io (architecture diagrams)"
  cask_install owasp-zap    "OWASP ZAP (web app scanner)"

  brew_install ffuf         "ffuf (web fuzzer)"
  brew_install nuclei       "nuclei (vuln scanner)"
  brew_install httpie       "httpie (API testing CLI)"
  brew_install istioctl     "istioctl (Istio service mesh)"

  pip_install  "jwt_tool"   "jwt_tool (JWT security testing)"

  echo -e "\n  ${DIM}Updating nuclei templates...${RESET}"
  if command -v nuclei &>/dev/null; then
    (nuclei -update-templates >> "$LOG" 2>&1) &
    local pid=$!
    spinner $pid "nuclei template update"
    wait $pid && status_ok "nuclei templates updated" || status_fail "nuclei templates" "update failed — run: nuclei -update-templates"
  fi

  echo -e "\n  ${DIM}Installing katana (web crawler via go install)...${RESET}"
  if command -v katana &>/dev/null; then
    status_skip "katana (web crawler)" "already installed"
  else
    (go install github.com/projectdiscovery/katana/cmd/katana@latest >> "$LOG" 2>&1) &
    local pid=$!
    spinner $pid "katana (web crawler)"
    wait $pid && status_ok "katana (web crawler)" || status_fail "katana" "go install failed — ensure Go is installed and GOPATH/bin is in PATH"
  fi

  section "PHASE 3 — IaC Security & Multi-Cloud Tools"

  brew_install terraform    "Terraform (IaC)"
  brew_install tfsec        "tfsec (Terraform scanner)"
  brew_install terrascan    "terrascan (multi-cloud IaC)"
  pip_install  "checkov"    "checkov (IaC security scanner)"
  cask_install google-cloud-sdk "gcloud CLI (GCP)"
  brew_install azure-cli    "Azure CLI"

  echo -e "\n  ${DIM}Installing Threagile binary (threat modeling as code)...${RESET}"
  local threagile_url
  if [[ "$ARCH" == "arm64" ]]; then
    threagile_url="https://github.com/Threagile/threagile/releases/latest/download/threagile-macos-arm64.zip"
  else
    threagile_url="https://github.com/Threagile/threagile/releases/latest/download/threagile-macos-amd64.zip"
  fi
  gh_binary "threagile" "$threagile_url" "/usr/local/bin/threagile" "threagile (threat modeling)"
}

# =============================================================================
#  PHASE 4 — Expert & Emerging Tools
# =============================================================================
phase4() {
  section "PHASE 4 — Expert & Emerging Tools"

  pip_install  "bandit"     "bandit (Python SAST)"
  pip_install  "safety"     "safety (Python dep scanner)"
  pip_install  "scoutsuite" "ScoutSuite (multi-cloud audit)"
  pip_install  "cloudmapper" "cloudmapper (AWS visualizer)"

  echo ""
  echo -e "  ${YELLOW}ℹ  Tetragon (eBPF runtime security) and Falco require a running${RESET}"
  echo -e "  ${YELLOW}   Kubernetes cluster. Install them via Helm after running:${RESET}"
  echo -e "  ${DIM}   kind create cluster --name devsecops-lab${RESET}"
  echo -e "  ${DIM}   helm repo add falcosecurity https://falcosecurity.github.io/charts${RESET}"
  echo -e "  ${DIM}   helm install falco falcosecurity/falco -n falco-system --create-namespace${RESET}"
  echo -e "  ${DIM}   helm repo add cilium https://helm.cilium.io${RESET}"
  echo -e "  ${DIM}   helm install tetragon cilium/tetragon -n kube-system${RESET}"
  log "INFO: Falco and Tetragon skipped — require a running cluster"
}

# =============================================================================
#  VERIFY MODE — check all tools without installing
# =============================================================================
verify_all() {
  section "Verification — Phase 0 (Prerequisites)"
  verify_cmd brew        "Homebrew"
  verify_cmd jq          "jq"
  verify_cmd yq          "yq"
  verify_cmd python3     "Python 3"
  verify_cmd go          "Go"

  section "Verification — Phase 1 (Cloud Security)"
  verify_cmd aws         "AWS CLI v2"
  verify_cmd aws-vault   "aws-vault"
  verify_cmd iamlive     "iamlive"
  verify_cmd steampipe   "steampipe"
  verify_cmd prowler     "prowler"
  verify_cmd trufflehog  "trufflehog"
  verify_cmd detect-secrets "detect-secrets"

  section "Verification — Phase 2 (CI/CD & Containers)"
  verify_cmd docker      "Docker"
  verify_cmd semgrep     "semgrep"
  verify_cmd trivy       "trivy"
  verify_cmd grype       "grype"
  verify_cmd syft        "syft"
  verify_cmd dive        "dive"
  verify_cmd hadolint    "hadolint"
  verify_cmd dockle      "dockle"
  verify_cmd gitleaks    "gitleaks"
  verify_cmd cosign      "cosign"
  verify_cmd pre-commit  "pre-commit"
  verify_cmd kubectl     "kubectl"
  verify_cmd kind        "kind"
  verify_cmd helm        "helm"
  verify_cmd kube-bench  "kube-bench"
  verify_cmd kubescape   "kubescape"
  verify_cmd opa         "opa"
  verify_cmd kubectx     "kubectx"
  verify_cmd k9s         "k9s"

  section "Verification — Phase 3 (AppSec & IaC)"
  verify_cmd ffuf        "ffuf"
  verify_cmd nuclei      "nuclei"
  verify_cmd http        "httpie"
  verify_cmd istioctl    "istioctl"
  verify_cmd threagile   "threagile"
  verify_cmd terraform   "Terraform"
  verify_cmd tfsec       "tfsec"
  verify_cmd terrascan   "terrascan"
  verify_cmd checkov     "checkov"
  verify_cmd gcloud      "gcloud CLI"
  verify_cmd az          "Azure CLI"

  section "Verification — Phase 4 (Expert Tools)"
  verify_cmd bandit      "bandit"
  verify_cmd safety      "safety"
  verify_cmd scout       "ScoutSuite"
}

# =============================================================================
#  SUMMARY
# =============================================================================
print_summary() {
  local total=$((PASS + FAIL + SKIP))
  echo ""
  echo -e "  ${BOLD}${WHITE}╔══════════════════════════════════════════════════╗${RESET}"
  echo -e "  ${BOLD}${WHITE}║           INSTALLATION SUMMARY                   ║${RESET}"
  echo -e "  ${BOLD}${WHITE}╠══════════════════════════════════════════════════╣${RESET}"
  printf  "  ${BOLD}${WHITE}║${RESET}  ${GREEN}%-6s Successful${RESET}                               ${BOLD}${WHITE}║${RESET}\n" "$PASS"
  printf  "  ${BOLD}${WHITE}║${RESET}  ${RED}%-6s Failed${RESET}                                   ${BOLD}${WHITE}║${RESET}\n"    "$FAIL"
  printf  "  ${BOLD}${WHITE}║${RESET}  ${YELLOW}%-6s Skipped (already installed)${RESET}             ${BOLD}${WHITE}║${RESET}\n" "$SKIP"
  printf  "  ${BOLD}${WHITE}║${RESET}  ${DIM}%-6s Total tools processed${RESET}                 ${BOLD}${WHITE}║${RESET}\n"     "$total"
  echo -e "  ${BOLD}${WHITE}╚══════════════════════════════════════════════════╝${RESET}"
  echo ""

  if [[ $FAIL -gt 0 ]]; then
    echo -e "  ${RED}${BOLD}⚠  $FAIL tool(s) failed to install.${RESET}"
    echo -e "  ${DIM}Full details in: ${LOG}${RESET}"
    echo -e "  ${DIM}Failed tools:${RESET}"
    grep "^.*FAILED" "$LOG" | while IFS= read -r line; do
      echo -e "  ${RED}  • ${line#*FAILED  }${RESET}"
    done
    echo ""
  fi

  if [[ $FAIL -eq 0 ]]; then
    echo -e "  ${GREEN}${BOLD}All tools installed successfully!${RESET}"
    echo -e "  ${DIM}Run ${WHITE}bash install.sh --verify${RESET}${DIM} to confirm everything is in PATH.${RESET}"
    echo -e "  ${DIM}Next step: open ${WHITE}phases/phase-1-cloud.md${RESET}${DIM} and start checking boxes.${RESET}"
  fi
  echo ""
  log "Summary: $PASS OK | $FAIL FAILED | $SKIP SKIPPED"
}

# =============================================================================
#  ARGUMENT PARSING & ENTRY POINT
# =============================================================================
usage() {
  echo ""
  echo -e "  ${BOLD}Usage:${RESET}"
  echo -e "    bash install.sh              ${DIM}# install all phases${RESET}"
  echo -e "    bash install.sh --phase 1   ${DIM}# Phase 1 only (cloud security)${RESET}"
  echo -e "    bash install.sh --phase 2   ${DIM}# Phase 2 only (CI/CD + containers)${RESET}"
  echo -e "    bash install.sh --phase 3   ${DIM}# Phase 3 only (AppSec + IaC)${RESET}"
  echo -e "    bash install.sh --phase 4   ${DIM}# Phase 4 only (expert tools)${RESET}"
  echo -e "    bash install.sh --verify    ${DIM}# verify all tools, no installation${RESET}"
  echo -e "    bash install.sh --help      ${DIM}# show this message${RESET}"
  echo ""
}

main() {
  print_banner
  detect_arch

  local mode="all"
  local target_phase=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --phase) shift; target_phase="$1"; mode="phase" ;;
      --verify) mode="verify" ;;
      --help|-h) usage; exit 0 ;;
      *) echo -e "  ${RED}Unknown argument: $1${RESET}"; usage; exit 1 ;;
    esac
    shift
  done

  case "$mode" in
    verify)
      verify_all
      ;;
    phase)
      phase0
      case "$target_phase" in
        1) phase1 ;;
        2) phase1; phase2 ;;
        3) phase1; phase2; phase3 ;;
        4) phase1; phase2; phase3; phase4 ;;
        *) echo -e "  ${RED}Invalid phase: $target_phase (use 1–4)${RESET}"; usage; exit 1 ;;
      esac
      ;;
    all)
      phase0
      phase1
      phase2
      phase3
      phase4
      ;;
  esac

  print_summary
}

main "$@"
