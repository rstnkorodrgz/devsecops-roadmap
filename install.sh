#!/usr/bin/env bash
# =============================================================================
#  PATH 2 DEVSECOPS — Automated Tool Installer v1.3
#  macOS · Intel & Apple Silicon
#
#  Usage:
#    bash install.sh              # install all phases + VS Code extensions
#    bash install.sh --phase 1   # install Phase 1 tools only
#    bash install.sh --phase 2   # install Phase 2 tools only
#    bash install.sh --phase 3   # install Phase 3 tools only
#    bash install.sh --phase 4   # install Phase 4 tools only
#    bash install.sh --vscode    # install VS Code extensions only
#    bash install.sh --verify    # verify all tools without installing
#    bash install.sh --help      # show this help
#
#  Log file: ~/devsecops-install.log
# =============================================================================

# FIX 1 — Remove set -e. Bash arithmetic (( n++ )) returns exit code 1 when n=0,
#          which killed the entire script on the very first status_ok call.
#          Failures are now tracked manually via the FAIL counter instead.
set -uo pipefail

# ── Colours ───────────────────────────────────────────────────────────────────
RED='\033[0;31m';  GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m';  BOLD='\033[1m';  RESET='\033[0m'
DIM='\033[2m';     WHITE='\033[0;37m'

# ── Log file ──────────────────────────────────────────────────────────────────
LOG="$HOME/devsecops-install.log"
> "$LOG"
log() { echo "[$(date '+%H:%M:%S')] $*" >> "$LOG"; }

# ── Counters — FIX 1 (cont.) ─────────────────────────────────────────────────
# Use $(( n + 1 )) instead of (( n++ )) — arithmetic substitution never
# returns a non-zero exit code, so set -e (if re-enabled) won't fire.
PASS=0; FAIL=0; SKIP=0

status_ok() {
  printf "  ${GREEN}✔${RESET}  %-44s ${GREEN}[  OK  ]${RESET}\n" "$1"
  log "OK      $1"
  PASS=$(( PASS + 1 ))
}
status_fail() {
  printf "  ${RED}✘${RESET}  %-44s ${RED}[FAILED]${RESET}\n" "$1"
  log "FAILED  $1 — $2"
  FAIL=$(( FAIL + 1 ))
}
status_skip() {
  printf "  ${YELLOW}–${RESET}  %-44s ${YELLOW}[ SKIP ]${RESET}\n" "$1"
  log "SKIP    $1 — $2"
  SKIP=$(( SKIP + 1 ))
}

section() {
  echo ""
  echo -e "  ${BOLD}${BLUE}══════════════════════════════════════════════════${RESET}"
  printf   "  ${BOLD}${BLUE}  %-46s${RESET}\n" "$1"
  echo -e "  ${BOLD}${BLUE}══════════════════════════════════════════════════${RESET}"
  log "=== $1 ==="
}

spinner() {
  local pid=$1 msg=$2
  local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
  local i=0
  while kill -0 "$pid" 2>/dev/null; do
    printf "\r  ${CYAN}%s${RESET} ${WHITE}%s${RESET}  " "${frames[$(( i % 10 ))]}" "$msg"
    i=$(( i + 1 ))
    sleep 0.08
  done
  printf "\r%-70s\r" " "
}

# ── Banner ────────────────────────────────────────────────────────────────────
print_banner() {
  clear
  echo ""
  echo -e "${GREEN}${BOLD}"
  echo '        ██████╗  █████╗ ████████╗██╗  ██╗    ██████╗ '
  echo '        ██╔══██╗██╔══██╗╚══██╔══╝██║  ██║    ╚════██╗'
  echo '        ██████╔╝███████║   ██║   ███████║      ███╔═╝'
  echo '        ██╔═══╝ ██╔══██║   ██║   ██╔══██║     ██╔══╝ '
  echo '        ██║     ██║  ██║   ██║   ██║  ██║     ███████╗'
  echo '        ╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝     ╚══════╝'
  echo ""
  echo '      ██████╗ ███████╗██╗   ██╗███████╗███████╗ ██████╗ ██████╗ ███████╗'
  echo '      ██╔══██╗██╔════╝██║   ██║██╔════╝██╔════╝██╔════╝██╔═══██╗██╔════╝'
  echo '      ██║  ██║█████╗  ██║   ██║███████╗█████╗  ██║     ██║   ██║███████╗'
  echo '      ██║  ██║██╔══╝  ╚██╗ ██╔╝╚════██║██╔══╝  ██║     ██║   ██║╚════██║'
  echo '      ██████╔╝███████╗ ╚████╔╝ ███████║███████╗╚██████╗╚██████╔╝███████║'
  echo '      ╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝'
  echo -e "${RESET}"
  local os_ver arch_label
  os_ver=$(sw_vers -productVersion 2>/dev/null || echo "macOS")
  arch_label="${ARCH_LABEL:-$(uname -m)}"
  echo -e "  ${BOLD}${WHITE}╔══════════════════════════════════════════════════════╗${RESET}"
  echo -e "  ${BOLD}${WHITE}║${RESET}  ${CYAN}${BOLD}PATH 2 DEVSECOPS${RESET}  ${WHITE}— Automated Installer v1.3${BOLD}${WHITE}║${RESET}"
  printf  "  ${BOLD}${WHITE}║${RESET}  ${DIM}%-52s${RESET}${BOLD}${WHITE}║${RESET}\n" "macOS ${os_ver} · ${arch_label}"
  echo -e "  ${BOLD}${WHITE}╠══════════════════════════════════════════════════════╣${RESET}"
  echo -e "  ${BOLD}${WHITE}║${RESET}  ${GREEN}AWS SCS-C02${RESET}  ${WHITE}→${RESET}  ${CYAN}CKS${RESET}  ${WHITE}→${RESET}  ${BLUE}GWEB${RESET}  ${WHITE}→${RESET}  ${YELLOW}CISSP${RESET}               ${BOLD}${WHITE}║${RESET}"
  echo -e "  ${BOLD}${WHITE}║${RESET}  ${DIM}65 tools · 4 phases · 10 months · 4 certifications${RESET}  ${BOLD}${WHITE}║${RESET}"
  echo -e "  ${BOLD}${WHITE}╚══════════════════════════════════════════════════════╝${RESET}"
  echo ""
  echo -e "  ${DIM}Log file → ${WHITE}${LOG}${RESET}"
  echo ""
}

detect_arch() {
  ARCH=$(uname -m)
  if [[ "$ARCH" == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"
    ARCH_LABEL="Apple Silicon (M1/M2/M3)"
  else
    BREW_PREFIX="/usr/local"
    ARCH_LABEL="Intel x86_64"
  fi
  echo -e "  ${DIM}Detected: ${WHITE}${ARCH_LABEL}${RESET}  |  Homebrew: ${WHITE}${BREW_PREFIX}${RESET}"
  echo ""
  log "Architecture: $ARCH_LABEL"
}

# =============================================================================
#  INSTALL HELPERS
# =============================================================================

# FIX 5 — brew_install: extract leaf name for the already-installed check so
#          tap-qualified names like "goodwithtech/r/dockle" are handled correctly.
brew_install() {
  local formula="$1"
  local display="${2:-$formula}"
  local leaf="${formula##*/}"   # e.g. goodwithtech/r/dockle → dockle

  # Check both brew list (catches tap-qualified names via leaf) and command -v
  # (catches tap-installed formulas that brew list may return as tap/leaf).
  if brew list --formula 2>/dev/null | grep -qE "(^|/)${leaf}$" \
     || command -v "$leaf" &>/dev/null; then
    status_skip "$display" "already installed"
    return 0
  fi

  local tmp; tmp=$(mktemp)
  ( brew install "$formula" >> "$tmp" 2>&1 ) &
  local pid=$!
  spinner $pid "Installing $display"
  wait $pid
  local rc=$?

  if [[ $rc -eq 0 ]]; then
    status_ok "$display"
  else
    local reason
    reason=$(grep -i "error\|not found\|failed\|permission\|no formulae" \
      "$tmp" 2>/dev/null | head -1 || echo "unknown error — see $LOG")
    status_fail "$display" "$reason"
    cat "$tmp" >> "$LOG"
  fi
  rm -f "$tmp"
}

cask_install() {
  local cask="$1"
  local display="${2:-$cask}"

  if brew list --cask 2>/dev/null | grep -q "^${cask}$"; then
    status_skip "$display" "already installed via Homebrew Cask"
    return 0
  fi

  local tmp; tmp=$(mktemp)
  ( brew install --cask "$cask" >> "$tmp" 2>&1 ) &
  local pid=$!
  spinner $pid "Installing $display (cask)"
  wait $pid
  local rc=$?

  if [[ $rc -eq 0 ]]; then
    status_ok "$display"
  else
    local reason
    reason=$(grep -i "error\|not found\|failed\|permission\|already" \
      "$tmp" 2>/dev/null | head -1 || echo "see $LOG")
    status_fail "$display" "$reason"
    cat "$tmp" >> "$LOG"
  fi
  rm -f "$tmp"
}

# FIX 9 — brew_tap: capture exit code and surface failure so dependent
#          formulas know not to proceed.
brew_tap() {
  local tap="$1"
  if brew tap 2>/dev/null | grep -q "^${tap}$"; then
    log "Tap already present: $tap"
    return 0
  fi

  local tmp; tmp=$(mktemp)
  ( brew tap "$tap" >> "$tmp" 2>&1 ) &
  local pid=$!
  spinner $pid "Adding tap: $tap"
  wait $pid
  local rc=$?

  if [[ $rc -ne 0 ]]; then
    local reason
    reason=$(grep -i "error\|failed\|not found" "$tmp" 2>/dev/null | head -1 \
      || echo "brew tap failed — see $LOG")
    status_fail "brew tap $tap" "$reason"
    cat "$tmp" >> "$LOG"
    rm -f "$tmp"
    return 1
  fi

  log "Tap added: $tap"
  rm -f "$tmp"
  return 0
}

# FIX 4 — pip_install: use PYTHONUSERBASE + --user + --ignore-installed so pip
#          always installs to ~/.local (user-writable), never touching Homebrew's
#          /usr/local prefix where permission errors arise. Scripts land in
#          ~/.local/bin which is already in PATH via .zshrc.
pip_install() {
  local pkg="$1"
  local display="${2:-$pkg}"
  local show_name="${3:-$pkg}"   # pip show name can differ from install name

  # Ensure ~/.local/bin is in PATH so installed scripts are found immediately
  local dest="$HOME/.local/bin"
  mkdir -p "$dest"
  if [[ ":$PATH:" != *":${dest}:"* ]]; then export PATH="$PATH:$dest"; fi

  if PYTHONUSERBASE="$HOME/.local" pip3 show "$show_name" &>/dev/null 2>&1 \
     || pip3 show "$show_name" &>/dev/null 2>&1; then
    status_skip "$display" "already installed via pip3"
    return 0
  fi

  local tmp; tmp=$(mktemp)
  ( PYTHONUSERBASE="$HOME/.local" pip3 install --quiet --user --break-system-packages --ignore-installed "$pkg" >> "$tmp" 2>&1 ) &
  local pid=$!
  spinner $pid "Installing $display (pip3)"
  wait $pid
  local rc=$?

  if [[ $rc -eq 0 ]]; then
    status_ok "$display"
  else
    local reason
    reason=$(grep -i "error\|not found\|failed\|requires\|conflict\|externally" \
      "$tmp" 2>/dev/null | head -1 || echo "pip3 failed — see $LOG")
    status_fail "$display" "$reason"
    cat "$tmp" >> "$LOG"
  fi
  rm -f "$tmp"
}

# FIX 7 — ensure_gopath: export ~/go/bin so tools installed with
#          "go install" are immediately findable in the same session.
ensure_gopath() {
  local gobin
  gobin="$(go env GOPATH 2>/dev/null)/bin"
  if [[ ":$PATH:" != *":${gobin}:"* ]]; then
    export PATH="$PATH:$gobin"
    local rc="$HOME/.zprofile"
    if ! grep -q 'go env GOPATH' "$rc" 2>/dev/null; then
      echo 'export PATH="$PATH:$(go env GOPATH)/bin"' >> "$rc"
      log "Appended GOPATH/bin to $rc"
    fi
  fi
}

# FIX 8 — gh_binary: install to ~/.local/bin (user-writable, no sudo needed)
#          instead of /usr/local/bin which requires sudo on macOS Sonoma.
gh_binary() {
  local name="$1"
  local url="$2"
  local display="${3:-$name}"
  local dest="$HOME/.local/bin"

  mkdir -p "$dest"

  # Ensure ~/.local/bin is in PATH for this session and future shells
  if [[ ":$PATH:" != *":${dest}:"* ]]; then
    export PATH="$PATH:$dest"
    local rc="$HOME/.zprofile"
    if ! grep -q '\.local/bin' "$rc" 2>/dev/null; then
      echo 'export PATH="$PATH:$HOME/.local/bin"' >> "$rc"
      log "Appended ~/.local/bin to $rc"
    fi
  fi

  if command -v "$name" &>/dev/null; then
    status_skip "$display" "already in PATH"
    return 0
  fi

  local tmp; tmp=$(mktemp)
  ( curl -sSL "$url" -o "$tmp" 2>> "$LOG" ) &
  local pid=$!
  spinner $pid "Downloading $display"
  wait $pid
  local rc=$?

  if [[ $rc -ne 0 ]]; then
    status_fail "$display" "download failed — check internet and URL: $url"
    rm -f "$tmp"; return 1
  fi

  if [[ "$url" == *.zip ]]; then
    local tmpdir; tmpdir=$(mktemp -d)
    unzip -q "$tmp" -d "$tmpdir" >> "$LOG" 2>&1
    local binary; binary=$(find "$tmpdir" -name "$name" -type f | head -1)
    if [[ -n "$binary" ]]; then
      cp "$binary" "$dest/$name" && chmod +x "$dest/$name"
      status_ok "$display  ${DIM}(→ $dest/$name)${RESET}"
    else
      status_fail "$display" "binary '$name' not found in zip — see $LOG"
    fi
    rm -rf "$tmpdir"
  else
    cp "$tmp" "$dest/$name" && chmod +x "$dest/$name"
    status_ok "$display  ${DIM}(→ $dest/$name)${RESET}"
  fi
  rm -f "$tmp"
}

# FIX 2 — vscode_install: always return 0 so a missing VS Code CLI
#          or failed extension never aborts the rest of the script.
vscode_install() {
  local ext_id="$1"
  local display="${2:-$ext_id}"

  if ! command -v code &>/dev/null; then
    status_fail "$display" "code CLI not in PATH — VS Code → ⌘⇧P → 'Shell Command: Install code in PATH'"
    return 0
  fi

  if code --list-extensions 2>/dev/null | grep -qi "^${ext_id}$"; then
    status_skip "$display" "already installed"
    return 0
  fi

  local tmp; tmp=$(mktemp)
  ( code --install-extension "$ext_id" --force >> "$tmp" 2>&1 ) &
  local pid=$!
  spinner $pid "VS Code ext: $display"
  wait $pid
  local rc=$?

  if [[ $rc -eq 0 ]]; then
    status_ok "$display"
  else
    local reason
    reason=$(grep -i "error\|not found\|failed\|unable" "$tmp" 2>/dev/null | head -1 \
      || echo "try: code --install-extension $ext_id")
    status_fail "$display" "$reason"
    cat "$tmp" >> "$LOG"
  fi
  rm -f "$tmp"
  return 0
}

verify_cmd() {
  local cmd="$1"
  local display="${2:-$cmd}"
  if command -v "$cmd" &>/dev/null; then
    local ver; ver=$( "$cmd" --version 2>/dev/null | head -1 || echo "installed" )
    status_ok "$display  ${DIM}($ver)${RESET}"
  else
    status_fail "$display" "not found in PATH"
  fi
}

# =============================================================================
#  PHASE 0 — Prerequisites
# =============================================================================
phase0() {
  section "PHASE 0 — Prerequisites & Core Shell"

  echo -e "  ${DIM}Checking Xcode Command Line Tools...${RESET}"
  if ! xcode-select -p &>/dev/null; then
    echo -e "  ${YELLOW}⚠  Xcode CLT missing — launching installer dialog...${RESET}"
    echo -e "  ${YELLOW}   Click Install in the dialog, wait for it to finish,${RESET}"
    echo -e "  ${YELLOW}   then re-run: bash install.sh${RESET}"
    xcode-select --install 2>/dev/null || true
    exit 1
  else
    status_ok "Xcode Command Line Tools"
  fi

  # FIX 3 — Don't redirect Homebrew installer to LOG. The installer needs an
  #          interactive TTY to display the sudo password prompt and progress.
  if ! command -v brew &>/dev/null; then
    echo ""
    echo -e "  ${YELLOW}⚠  Homebrew not found — installing now.${RESET}"
    echo -e "  ${DIM}  Your macOS password may be required below.${RESET}"
    echo ""
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    local brew_rc=$?
    if [[ $brew_rc -ne 0 ]]; then
      status_fail "Homebrew" "installer exited $brew_rc — visit https://brew.sh"
      return 1
    fi
    if [[ "$ARCH" == "arm64" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
      grep -qF 'brew shellenv' "$HOME/.zprofile" 2>/dev/null \
        || echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    fi
    status_ok "Homebrew (fresh install)"
  else
    status_ok "Homebrew  ${DIM}($(brew --version | head -1))${RESET}"
  fi

  echo -e "\n  ${DIM}Updating Homebrew...${RESET}"
  brew update --quiet >> "$LOG" 2>&1 \
    && log "brew update OK" \
    || log "brew update had non-fatal warnings"

  brew_install jq          "jq (JSON processor)"
  brew_install yq          "yq (YAML processor)"
  brew_install tree        "tree"
  brew_install wget        "wget"
  brew_install python@3.11 "Python 3.11"
  brew_install go          "Go language"
}

# =============================================================================
#  PHASE 1 — Cloud Security
# =============================================================================
phase1() {
  section "PHASE 1 — Cloud Security Tools"

  brew_install awscli    "AWS CLI v2"
  brew_install aws-vault "aws-vault (credential manager)"

  # FIX 12 — iamlive: brew formula removed upstream; use go install instead.
  echo -e "\n  ${DIM}Installing iamlive via go install...${RESET}"
  ensure_gopath
  if command -v iamlive &>/dev/null; then
    status_skip "iamlive (IAM policy generator)" "already installed"
  else
    local tmp_il; tmp_il=$(mktemp)
    ( go install github.com/iann0036/iamlive@latest >> "$tmp_il" 2>&1 ) &
    local pid=$!
    spinner $pid "iamlive (IAM policy generator)"
    wait $pid
    local rc=$?
    ensure_gopath
    if [[ $rc -eq 0 ]] && command -v iamlive &>/dev/null; then
      status_ok "iamlive (IAM policy generator)"
    else
      status_fail "iamlive" "go install failed — run: go install github.com/iann0036/iamlive@latest"
      cat "$tmp_il" >> "$LOG"
    fi
    rm -f "$tmp_il"
  fi

  echo -e "\n  ${DIM}Adding Turbot tap for steampipe...${RESET}"
  if brew_tap "turbot/tap"; then
    brew_install steampipe "steampipe (cloud SQL queries)"

    # FIX 11 — steampipe plugin: --agree-tos flag was removed in steampipe v0.21+;
    #           the plugin installer no longer prompts interactively.
    echo -e "\n  ${DIM}Installing steampipe AWS plugin...${RESET}"
    if command -v steampipe &>/dev/null; then
      local tmp_sp; tmp_sp=$(mktemp)
      ( steampipe plugin install aws >> "$tmp_sp" 2>&1 ) &
      local pid=$!
      spinner $pid "steampipe AWS plugin"
      wait $pid
      local rc=$?
      if [[ $rc -eq 0 ]]; then
        status_ok "steampipe AWS plugin"
      else
        local reason; reason=$(grep -i "error\|failed" "$tmp_sp" 2>/dev/null | head -1 \
          || echo "run: steampipe plugin install aws")
        status_fail "steampipe AWS plugin" "$reason"
        cat "$tmp_sp" >> "$LOG"
      fi
      rm -f "$tmp_sp"
    else
      status_fail "steampipe AWS plugin" "steampipe binary not found after install"
    fi
  else
    status_fail "steampipe" "turbot/tap failed — steampipe and its plugin skipped"
  fi

  # FIX 6 — prowler: brew formula was removed upstream; pip3 is the correct
  #          install method as of prowler v3+.
  pip_install "prowler" "prowler (cloud security auditor)"

  brew_install trufflehog    "trufflehog (secret scanner)"
  pip_install  "detect-secrets" "detect-secrets (pre-commit secret hook)"
}

# =============================================================================
#  PHASE 2 — CI/CD Pipeline & Container Security
# =============================================================================
phase2() {
  section "PHASE 2 — CI/CD Pipeline & Container Tools"

  cask_install docker       "Docker Desktop"
  brew_install semgrep      "semgrep (SAST scanner)"
  brew_install trivy        "trivy (vuln & container scanner)"
  brew_install grype        "grype (vulnerability scanner)"
  brew_install syft         "syft (SBOM generator)"
  brew_install dive         "dive (image layer inspector)"
  brew_install hadolint     "hadolint (Dockerfile linter)"

  echo -e "\n  ${DIM}Adding goodwithtech tap for dockle...${RESET}"
  if brew_tap "goodwithtech/r"; then
    brew_install "goodwithtech/r/dockle" "dockle (container image linter)"
  else
    status_fail "dockle" "goodwithtech/r tap failed — skipping dockle"
  fi

  brew_install gitleaks   "gitleaks (git secret scanner)"
  brew_install cosign     "cosign (artifact signing)"
  brew_install pre-commit "pre-commit (git hooks)"

  section "PHASE 2 — Kubernetes Security Tools"

  brew_install kubectl    "kubectl (Kubernetes CLI)"
  brew_install kind       "kind (local K8s clusters)"
  brew_install helm       "helm (K8s package manager)"
  brew_install kube-bench "kube-bench (CIS K8s benchmark)"
  brew_install kubescape  "kubescape (K8s security scanner)"
  brew_install opa        "opa (Open Policy Agent CLI)"
  brew_install kubectx    "kubectx + kubens"
  brew_install k9s        "k9s (K8s terminal UI)"
  pip_install  "kube-hunter" "kube-hunter (K8s penetration testing)"
}

# =============================================================================
#  PHASE 3 — AppSec & Threat Modeling
# =============================================================================
phase3() {
  section "PHASE 3 — AppSec & Threat Modeling Tools"

  cask_install drawio    "Draw.io (architecture diagrams)"
  cask_install owasp-zap "OWASP ZAP (web app scanner)"

  brew_install ffuf     "ffuf (web fuzzer)"
  brew_install nuclei   "nuclei (template-based vuln scanner)"
  brew_install httpie   "httpie (API testing CLI)"
  brew_install istioctl "istioctl (Istio service mesh CLI)"

  # FIX 13 — jwt_tool: not on PyPI and the GitHub repo has no setup.py/pyproject.toml.
  #           Download the standalone script + install its requirements into ~/.local.
  echo -e "\n  ${DIM}Installing jwt_tool (JWT security testing)...${RESET}"
  local dest="$HOME/.local/bin"
  mkdir -p "$dest"
  if [[ ":$PATH:" != *":${dest}:"* ]]; then export PATH="$PATH:$dest"; fi
  if command -v jwt_tool &>/dev/null; then
    status_skip "jwt_tool (JWT security testing)" "already installed"
  else
    local tmp_jwt; tmp_jwt=$(mktemp)
    (
      PYTHONUSERBASE="$HOME/.local" pip3 install --quiet --user --break-system-packages --ignore-installed \
        termcolor pycryptodomex requests ratelimit cprint >> "$tmp_jwt" 2>&1 \
      && curl -sSL \
          "https://raw.githubusercontent.com/ticarpi/jwt_tool/master/jwt_tool.py" \
          -o "$dest/jwt_tool" >> "$tmp_jwt" 2>&1 \
      && chmod +x "$dest/jwt_tool"
    ) &
    local pid=$!
    spinner $pid "jwt_tool (JWT security testing)"
    wait $pid
    local rc=$?
    if [[ $rc -eq 0 ]] && command -v jwt_tool &>/dev/null; then
      status_ok "jwt_tool (JWT security testing)  ${DIM}(→ $dest/jwt_tool)${RESET}"
    else
      status_fail "jwt_tool" "install failed — see $LOG"
      cat "$tmp_jwt" >> "$LOG"
    fi
    rm -f "$tmp_jwt"
  fi

  # FIX 10 — nuclei: use -ut short flag which works across all recent
  #           versions (-update-templates was renamed in newer releases).
  echo -e "\n  ${DIM}Updating nuclei templates...${RESET}"
  if command -v nuclei &>/dev/null; then
    local tmp_nu; tmp_nu=$(mktemp)
    ( nuclei -ut >> "$tmp_nu" 2>&1 ) &
    local pid=$!
    spinner $pid "nuclei template update"
    wait $pid
    local rc=$?
    if [[ $rc -eq 0 ]]; then
      status_ok "nuclei templates updated"
    else
      status_fail "nuclei templates" "run manually: nuclei -ut"
      cat "$tmp_nu" >> "$LOG"
    fi
    rm -f "$tmp_nu"
  fi

  # FIX 7 — katana: call ensure_gopath before and after go install so the
  #          binary is immediately findable in the current shell session.
  echo -e "\n  ${DIM}Installing katana via go install...${RESET}"
  ensure_gopath
  if command -v katana &>/dev/null; then
    status_skip "katana (web crawler)" "already installed"
  else
    local tmp_kt; tmp_kt=$(mktemp)
    ( go install github.com/projectdiscovery/katana/cmd/katana@latest \
        >> "$tmp_kt" 2>&1 ) &
    local pid=$!
    spinner $pid "katana (web crawler)"
    wait $pid
    local rc=$?
    ensure_gopath
    if [[ $rc -eq 0 ]] && command -v katana &>/dev/null; then
      status_ok "katana (web crawler)"
    else
      status_fail "katana" \
        "go install failed — ensure Go is installed and run: go install github.com/projectdiscovery/katana/cmd/katana@latest"
      cat "$tmp_kt" >> "$LOG"
    fi
    rm -f "$tmp_kt"
  fi

  section "PHASE 3 — IaC Security & Multi-Cloud Tools"

  # FIX 14 — terraform: formula moved from core to hashicorp/tap in 2023.
  if ! brew_tap "hashicorp/tap"; then
    status_fail "Terraform (IaC)" "hashicorp/tap failed — cannot install terraform"
  else
    brew_install "hashicorp/tap/terraform" "Terraform (IaC)"
  fi
  brew_install tfsec     "tfsec (Terraform security scanner)"
  brew_install terrascan "terrascan (multi-cloud IaC scanner)"
  pip_install  "checkov" "checkov (IaC security scanner)"
  cask_install google-cloud-sdk "gcloud CLI (GCP)"
  brew_install azure-cli "Azure CLI"

  # FIX 8 / FIX 15 — Threagile: GitHub releases no longer ship binary assets
  #                   (all releases have empty assets as of v0.9.x). Install via
  #                   Docker and wrap with a shell shim in ~/.local/bin.
  echo -e "\n  ${DIM}Installing Threagile via Docker wrapper...${RESET}"
  local dest="$HOME/.local/bin"
  mkdir -p "$dest"
  if [[ ":$PATH:" != *":${dest}:"* ]]; then export PATH="$PATH:$dest"; fi
  if command -v threagile &>/dev/null; then
    status_skip "threagile (threat modeling as code)" "already installed"
  elif ! command -v docker &>/dev/null; then
    status_fail "threagile" "Docker not found — install Docker Desktop first"
  elif ! docker info &>/dev/null 2>&1; then
    status_fail "threagile" "Docker daemon not running — start Docker Desktop, then re-run installer"
  else
    local tmp_th; tmp_th=$(mktemp)
    ( docker pull threagile/threagile:latest >> "$tmp_th" 2>&1 ) &
    local pid=$!
    spinner $pid "threagile (pulling Docker image)"
    wait $pid
    local rc=$?
    if [[ $rc -eq 0 ]]; then
      cat > "$dest/threagile" <<'SHIM'
#!/bin/bash
docker run --rm -v "$(pwd)":/app/work threagile/threagile:latest "$@"
SHIM
      chmod +x "$dest/threagile"
      status_ok "threagile (threat modeling as code)  ${DIM}(Docker wrapper → $dest/threagile)${RESET}"
    else
      status_fail "threagile" "docker pull failed — run: docker pull threagile/threagile:latest"
      cat "$tmp_th" >> "$LOG"
    fi
    rm -f "$tmp_th"
  fi
}

# =============================================================================
#  PHASE 4 — Expert & Emerging Tools
# =============================================================================
phase4() {
  section "PHASE 4 — Expert & Emerging Tools"

  pip_install "bandit"      "bandit (Python SAST)"
  pip_install "safety"      "safety (Python dependency scanner)"
  pip_install "scoutsuite"  "ScoutSuite (multi-cloud security audit)"
  # FIX 16 — cloudmapper: removed from PyPI; project is unmaintained (last release 2022).
  echo -e "  ${YELLOW}ℹ  cloudmapper removed from PyPI — project unmaintained; skipping.${RESET}"
  log "INFO: cloudmapper skipped — removed from PyPI"

  echo ""
  echo -e "  ${YELLOW}ℹ  Falco & Tetragon need a running cluster — install after:${RESET}"
  echo -e "  ${DIM}  kind create cluster --name devsecops-lab${RESET}"
  echo ""
  echo -e "  ${DIM}  # Falco${RESET}"
  echo -e "  ${DIM}  helm repo add falcosecurity https://falcosecurity.github.io/charts && helm repo update${RESET}"
  echo -e "  ${DIM}  helm install falco falcosecurity/falco -n falco-system --create-namespace${RESET}"
  echo ""
  echo -e "  ${DIM}  # Tetragon${RESET}"
  echo -e "  ${DIM}  helm repo add cilium https://helm.cilium.io${RESET}"
  echo -e "  ${DIM}  helm install tetragon cilium/tetragon -n kube-system${RESET}"
  log "INFO: Falco and Tetragon require a running cluster — skipped"
}

# =============================================================================
#  VS CODE EXTENSIONS
# =============================================================================
vscode_extensions() {
  section "VS CODE — Core IDE Extensions"

  # FIX 2 — If code CLI is missing, warn and return 0 (not 1) so the calling
  #          context is never aborted by a non-zero exit code.
  if ! command -v code &>/dev/null; then
    echo ""
    echo -e "  ${YELLOW}⚠  VS Code 'code' CLI not found in PATH.${RESET}"
    echo -e "  ${DIM}  Fix: VS Code → ⌘⇧P → 'Shell Command: Install code in PATH' → Enter${RESET}"
    echo -e "  ${DIM}  Then re-run: bash install.sh --vscode${RESET}"
    echo ""
    log "WARN: VS Code CLI not in PATH — all extensions skipped"
    return 0
  fi

  echo -e "  ${DIM}VS Code: $(code --version 2>/dev/null | head -1)${RESET}\n"

  vscode_install "esbenp.prettier-vscode"      "Prettier (YAML, JSON, Markdown)"
  vscode_install "eamodio.gitlens"             "GitLens (inline blame, history)"
  vscode_install "timonwong.shellcheck"        "ShellCheck (bash linter)"
  vscode_install "remisa.shellman"             "Shell Script (bash IntelliSense)"
  vscode_install "yzhang.markdown-all-in-one" "Markdown All in One"

  section "VS CODE — Phase 1: Cloud Security"
  vscode_install "amazonwebservices.aws-toolkit-vscode" "AWS Toolkit"
  vscode_install "hashicorp.terraform"                  "HashiCorp Terraform"
  vscode_install "redhat.vscode-yaml"                   "YAML"
  vscode_install "mikestead.dotenv"                     "DotENV"

  section "VS CODE — Phase 2: CI/CD, Containers & Kubernetes"
  vscode_install "ms-azuretools.vscode-docker"                 "Docker"
  vscode_install "ms-kubernetes-tools.vscode-kubernetes-tools" "Kubernetes"
  vscode_install "github.vscode-github-actions"                "GitHub Actions"
  vscode_install "semgrep.semgrep"                             "Semgrep"
  vscode_install "exiasr.hadolint"                             "hadolint"
  vscode_install "tsandall.opa"                                "OPA (Rego)"

  section "VS CODE — Phase 3: AppSec & Threat Modeling"
  vscode_install "humao.rest-client"                         "REST Client"
  vscode_install "jflbr.jwt-decoder"                         "JWT Decoder"
  vscode_install "sonarsource.sonarlint-vscode"              "SonarLint"
  vscode_install "snyk-security.snyk-vulnerability-scanner"  "Snyk Security"
  # FIX 17 — GitGuardian: correct extension ID is gitguardian-secret-security.gitguardian
  vscode_install "gitguardian-secret-security.gitguardian"   "GitGuardian"

  section "VS CODE — Phase 4: Expert & Multi-Cloud"
  vscode_install "ms-python.python"                 "Python"
  vscode_install "ms-vscode.vscode-node-azure-pack" "Azure Tools"
}

# =============================================================================
#  VERIFY MODE
# =============================================================================
verify_all() {
  section "Verify — Phase 0 (Prerequisites)"
  verify_cmd brew    "Homebrew"
  verify_cmd jq      "jq"
  verify_cmd yq      "yq"
  verify_cmd python3 "Python 3"
  verify_cmd go      "Go"

  section "Verify — Phase 1 (Cloud Security)"
  verify_cmd aws            "AWS CLI v2"
  verify_cmd aws-vault      "aws-vault"
  verify_cmd iamlive        "iamlive"
  verify_cmd steampipe      "steampipe"
  verify_cmd prowler        "prowler"
  verify_cmd trufflehog     "trufflehog"
  verify_cmd detect-secrets "detect-secrets"

  section "Verify — Phase 2 (CI/CD & Containers)"
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

  section "Verify — Phase 3 (AppSec & IaC)"
  verify_cmd ffuf      "ffuf"
  verify_cmd nuclei    "nuclei"
  verify_cmd http      "httpie"
  verify_cmd istioctl  "istioctl"
  verify_cmd threagile "threagile"
  verify_cmd katana    "katana"
  verify_cmd terraform "Terraform"
  verify_cmd tfsec     "tfsec"
  verify_cmd terrascan "terrascan"
  verify_cmd checkov   "checkov"
  verify_cmd gcloud    "gcloud CLI"
  verify_cmd az        "Azure CLI"

  section "Verify — Phase 4 (Expert Tools)"
  verify_cmd bandit "bandit"
  verify_cmd safety "safety"
  verify_cmd scout  "ScoutSuite"

  section "Verify — VS Code Extensions"
  if ! command -v code &>/dev/null; then
    echo -e "  ${YELLOW}–${RESET}  code CLI not in PATH — cannot verify extensions"
    echo -e "  ${DIM}  VS Code → ⌘⇧P → 'Shell Command: Install code in PATH'${RESET}"
  else
    local installed_exts
    installed_exts=$(code --list-extensions 2>/dev/null | tr '[:upper:]' '[:lower:]')

    verify_ext() {
      local id="$1" display="$2"
      if echo "$installed_exts" | grep -q "^$(echo "$id" | tr '[:upper:]' '[:lower:]')$"; then
        status_ok "$display"
      else
        status_fail "$display" "run: code --install-extension $id"
      fi
    }

    verify_ext "esbenp.prettier-vscode"                      "Prettier"
    verify_ext "eamodio.gitlens"                             "GitLens"
    verify_ext "timonwong.shellcheck"                        "ShellCheck"
    verify_ext "remisa.shellman"                             "Shell Script"
    verify_ext "yzhang.markdown-all-in-one"                  "Markdown All in One"
    verify_ext "amazonwebservices.aws-toolkit-vscode"         "AWS Toolkit"
    verify_ext "hashicorp.terraform"                         "HashiCorp Terraform"
    verify_ext "redhat.vscode-yaml"                          "YAML"
    verify_ext "mikestead.dotenv"                            "DotENV"
    verify_ext "ms-azuretools.vscode-docker"                 "Docker"
    verify_ext "ms-kubernetes-tools.vscode-kubernetes-tools" "Kubernetes"
    verify_ext "github.vscode-github-actions"                "GitHub Actions"
    verify_ext "semgrep.semgrep"                             "Semgrep"
    verify_ext "exiasr.hadolint"                             "hadolint"
    verify_ext "tsandall.opa"                                "OPA"
    verify_ext "humao.rest-client"                           "REST Client"
    verify_ext "jflbr.jwt-decoder"                           "JWT Decoder"
    verify_ext "sonarsource.sonarlint-vscode"                "SonarLint"
    verify_ext "snyk-security.snyk-vulnerability-scanner"    "Snyk Security"
    verify_ext "gitguardian-secret-security.gitguardian"     "GitGuardian"
    verify_ext "ms-python.python"                            "Python"
    verify_ext "ms-vscode.vscode-node-azure-pack"            "Azure Tools"
  fi
}

# =============================================================================
#  SUMMARY
# =============================================================================
print_summary() {
  local total=$(( PASS + FAIL + SKIP ))
  echo ""
  echo -e "  ${BOLD}${WHITE}╔══════════════════════════════════════════════════╗${RESET}"
  echo -e "  ${BOLD}${WHITE}║             INSTALLATION SUMMARY                 ║${RESET}"
  echo -e "  ${BOLD}${WHITE}╠══════════════════════════════════════════════════╣${RESET}"
  printf  "  ${BOLD}${WHITE}║${RESET}  ${GREEN}%-6s Successful${RESET}                               ${BOLD}${WHITE}║${RESET}\n" "$PASS"
  printf  "  ${BOLD}${WHITE}║${RESET}  ${RED}%-6s Failed${RESET}                                   ${BOLD}${WHITE}║${RESET}\n"    "$FAIL"
  printf  "  ${BOLD}${WHITE}║${RESET}  ${YELLOW}%-6s Skipped (already installed)${RESET}             ${BOLD}${WHITE}║${RESET}\n" "$SKIP"
  printf  "  ${BOLD}${WHITE}║${RESET}  ${DIM}%-6s Total processed${RESET}                       ${BOLD}${WHITE}║${RESET}\n"     "$total"
  echo -e "  ${BOLD}${WHITE}╚══════════════════════════════════════════════════╝${RESET}"
  echo ""

  if [[ $FAIL -gt 0 ]]; then
    echo -e "  ${RED}${BOLD}⚠  $FAIL item(s) failed:${RESET}"
    grep "FAILED" "$LOG" | sed 's/.*FAILED  //' | while IFS= read -r line; do
      echo -e "  ${RED}  •${RESET}  $line"
    done
    echo ""
    echo -e "  ${DIM}Full log → ${WHITE}${LOG}${RESET}"
    echo ""
  fi

  if [[ $FAIL -eq 0 ]]; then
    echo -e "  ${GREEN}${BOLD}All items installed successfully!${RESET}"
    echo ""
  fi

  echo -e "  ${DIM}Next → run ${WHITE}bash install.sh --verify${DIM} to confirm PATH.${RESET}"
  echo -e "  ${DIM}Then  → open ${WHITE}phases/phase-1-cloud.md${DIM} and start checking boxes.${RESET}"
  echo ""
  log "DONE — $PASS OK | $FAIL FAILED | $SKIP SKIPPED"
}

# =============================================================================
#  ENTRY POINT
# =============================================================================
usage() {
  echo ""
  echo -e "  ${BOLD}Usage:${RESET}"
  echo -e "    bash install.sh              ${DIM}# all phases + VS Code extensions${RESET}"
  echo -e "    bash install.sh --phase 1   ${DIM}# Phase 1 — cloud security${RESET}"
  echo -e "    bash install.sh --phase 2   ${DIM}# Phase 2 — CI/CD + containers${RESET}"
  echo -e "    bash install.sh --phase 3   ${DIM}# Phase 3 — AppSec + IaC${RESET}"
  echo -e "    bash install.sh --phase 4   ${DIM}# Phase 4 — expert tools${RESET}"
  echo -e "    bash install.sh --vscode    ${DIM}# VS Code extensions only${RESET}"
  echo -e "    bash install.sh --verify    ${DIM}# verify tools, no install${RESET}"
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
      --phase)   shift; target_phase="$1"; mode="phase" ;;
      --vscode)  mode="vscode" ;;
      --verify)  mode="verify" ;;
      --help|-h) usage; exit 0 ;;
      *)
        echo -e "  ${RED}Unknown argument: $1${RESET}"
        usage; exit 1 ;;
    esac
    shift
  done

  case "$mode" in
    verify) verify_all ;;
    vscode) vscode_extensions ;;
    phase)
      phase0
      case "$target_phase" in
        1) phase1 ;;
        2) phase1; phase2 ;;
        3) phase1; phase2; phase3 ;;
        4) phase1; phase2; phase3; phase4 ;;
        *)
          echo -e "  ${RED}Invalid phase '$target_phase' — use 1, 2, 3 or 4${RESET}"
          usage; exit 1 ;;
      esac
      ;;
    all)
      phase0; phase1; phase2; phase3; phase4
      vscode_extensions
      ;;
  esac

  print_summary
}

main "$@"
