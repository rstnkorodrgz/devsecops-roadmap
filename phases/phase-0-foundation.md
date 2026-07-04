# Phase 0 — Foundations & Assessment

> **Two parts:** (1) a *starting-advantage map* of credentials you already hold, and (2) a short **foundations track** to solidify the practitioner skills every Senior DevSecOps role assumes. Don't skip Part 2 because it "looks basic" — these are the skills interviewers probe when certifications run out.
> **Duration:** first month, in parallel with the start of [Phase 1 (Terraform)](phase-1-terraform.md); skip what you already own.

---

# Part 1 — Your Existing Foundation (Leverage Map)

## ✅ Completed Credentials

### CompTIA Security+ (Active)
Covers the theory layer for the entire roadmap. Key areas that carry forward:

- **Threat, attack & vulnerability concepts** → directly accelerates threat modeling ([tracks/appsec.md](../tracks/appsec.md), Pillar D)
- **Architecture & design** → supports cloud security design in Phases 1 & 4
- **Identity & access management** → foundational for the Entra ID deep-dives in Phase 4
- **Cryptography & PKI** → applies to mTLS, Key Vault work (Phase 4) and CCSP Domain 1 (Phase 5)
- **ISC2 credit:** Security+ CPE habits carry into CCSP annual maintenance (Phase 5)

---

### CCNA — Cisco Certified Network Associate (Expired)
Knowledge is intact even if certification is lapsed. Key areas that carry forward:

| CCNA Domain | DevSecOps Application | Phase |
|---|---|---|
| Subnetting & VLANs | VNet design, subnet isolation, NSGs | Phases 1 & 4 |
| Routing protocols | Hub-spoke routing, UDRs, Azure Firewall | Phase 4 |
| ACLs & firewalling | NSGs, Azure Firewall, WAF rules | Phase 4 |
| VPN & tunneling | VPN Gateway, Private Link / Private Endpoints | Phase 4 |
| Network troubleshooting | NSG flow logs, Network Watcher | Phase 4 |
| Port security | Kubernetes NetworkPolicy, CNI | Phases 2–3 |
| Network segmentation | Zero-trust, micro-segmentation | Pillar D |
| OSI model depth | mTLS, service mesh concepts | Track: AppSec |
| TCP/IP fundamentals | CCSP D3 / CISSP D4 (if triggered) | Phase 5 |

> 💡 **ISC2 note:** your CCNA maps directly onto CCSP Domain 3 infrastructure content (Phase 5) — and if the [CISSP contingency](../electives/cissp-contingency.md) ever fires, Domain 4 (~13% of that exam) is nearly free.

---

### SonicWall Administrator (Expired)
Hands-on firewall administration experience that maps to modern cloud-native security:

| SonicWall Skill | Modern Equivalent | Phase |
|---|---|---|
| Stateful firewall rules | NSGs + Azure Firewall | Phase 4 |
| IDS/IPS management | Defender for Cloud alerts, Sentinel analytics | Phase 4 |
| VPN configuration | VPN Gateway, Site-to-Site | Phase 4 |
| Content filtering policies | WAF rules, Azure Policy | Phase 4 |
| Log monitoring & alerting | Sentinel + KQL analytics rules | Phase 4 |
| Threat signatures | Falco rules, runtime detection | Phase 3 |
| Network segmentation | Kubernetes NetworkPolicy | Phase 3 |
| DPI (Deep Packet Inspection) | Service mesh observability | Track: AppSec |

---

## 🧭 Your Accelerated Advantages

Based on your background, expect to move **~30–40% faster** than a typical learner in these areas:

- ✅ VNet/VPC architecture and network security configuration
- ✅ Firewall rules, WAF, and access control design
- ✅ VPN and secure connectivity patterns
- ✅ IDS/IPS and log-based detection concepts (→ Sentinel analytics)
- ✅ CCSP infrastructure domain (and CISSP D4, if ever triggered)
- ✅ Kubernetes network policies and CNI security

Areas that will require full study time (no shortcut):

- 🔶 Container image security and supply chain (new domain)
- 🔶 KQL and Sentinel content engineering
- 🔶 Threat modeling frameworks (STRIDE, PASTA, LINDDUN)
- 🔶 AI security (Pillar C — the specialization bet)
- 🔶 CCSP Domain 6 (legal, risk & compliance)

---

# Part 2 — Foundations Track (skills to solidify)

> Self-assess each area honestly. If you can already do everything in a section, check it off and move on. If not, spend a few evenings closing the gap before Phase 1 gets demanding.

## 🐧 Linux
- [x] `systemd` — units, `systemctl`, enabling/masking services, dependencies
- [ ] `journald` / `journalctl` — querying logs, filtering by unit/time/priority
- [ ] Networking — `ip`, `ss`, `dig`, `curl -v`, routing tables, `/etc/resolv.conf`
- [ ] Permissions — users/groups, `chmod`/`chown`, SUID/SGID, capabilities
- [ ] Processes & namespaces — `ps`, `top`, cgroups/namespaces (the basis of containers)
- [ ] **Bash** — variables, conditionals, loops, functions, `set -euo pipefail`, traps

## 🐍 Python (DevSecOps automation)
- [ ] Core: virtualenvs, `pip`, type hints, exceptions, f-strings
- [ ] `requests` — calling APIs, handling auth headers, pagination, retries
- [ ] `subprocess` — running tools safely (no `shell=True` with user input)
- [ ] Cloud SDK — `azure-identity` + `azure-mgmt-*` basics (list resources, managed-identity auth); `boto3` if the AWS elective fires
- [ ] `argparse` + logging — making a real CLI tool
- [ ] **Mini-project:** a script that audits something (e.g. lists storage accounts with public blob access, or role assignments unused for 90 days)

## 🌿 Git & GitHub
- [ ] Branching, rebasing vs merging, resolving conflicts
- [ ] **PR workflow** — small PRs, reviews, conventional commits
- [ ] Branch protection & required status checks
- [ ] **GitHub Actions basics** — workflows, jobs, steps, secrets, `GITHUB_TOKEN` scoping, OIDC
- [ ] `.gitignore`, signed commits, never committing secrets (pre-commit + gitleaks)

## 🌐 Networking (applied)
- [ ] **DNS** — record types, resolution path, caching/TTL, common failures
- [ ] **TLS** — handshake, certificates/chains, SNI, mTLS, inspecting with `openssl s_client`
- [ ] **HTTP(S)** — methods, status codes, headers, cookies, CORS, caching
- [ ] **Load balancers** — L4 vs L7, health checks, TLS termination, sticky sessions
- [ ] Proxies & reverse proxies, WAF placement in the request path

### Foundations deliverable
- [ ] One small Python automation script + one GitHub Actions workflow that runs it on PR, committed to a public repo. This becomes warm-up material for [Project 01](../projects/project-01-secure-cicd.md).

## 📚 Resources
- *The Linux Command Line* — William Shotts (free PDF)
- *Automate the Boring Stuff with Python* — Al Sweigart (free online)
- Julia Evans' zines (networking, DNS, Bash) — wizardzines.com
- GitHub Actions docs — Security hardening for GitHub Actions

---

_← [Back to README](../README.md) | [Phase 1 (Terraform) →](phase-1-terraform.md)_
