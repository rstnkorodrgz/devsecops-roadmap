# Phase 0 — Foundations & Assessment

> **Two parts:** (1) a *starting-advantage map* of credentials you already hold, and (2) a short **foundations track** to solidify the practitioner skills every Senior DevSecOps role assumes. Don't skip Part 2 because it "looks basic" — these are the skills interviewers probe when certifications run out.
> **Duration:** Weeks 1–4 (run in parallel with the start of Phase 1; skip what you already own).

---

# Part 1 — Your Existing Foundation (Leverage Map)

## ✅ Completed Credentials

### CompTIA Security+ (Active)
Covers the theory layer for the entire roadmap. Key areas that carry forward:

- **Threat, attack & vulnerability concepts** → directly accelerates Phase 3 threat modeling
- **Architecture & design** → supports AWS security design in Phase 1
- **Identity & access management** → foundational for IAM deep-dives in Phase 1
- **Cryptography & PKI** → applies to mTLS (Phase 3) and CISSP Domain 3 (Phase 4)
- **CISSP credit:** Security+ CPE hours count toward CISSP annual maintenance

---

### CCNA — Cisco Certified Network Associate (Expired)
Knowledge is intact even if certification is lapsed. Key areas that carry forward:

| CCNA Domain | DevSecOps Application | Phase |
|---|---|---|
| Subnetting & VLANs | VPC design, subnet isolation, NACLs | Phase 1 |
| Routing protocols | Transit Gateway, route table security | Phase 1 |
| ACLs & firewalling | Security Groups, NACLs, WAF rules | Phase 1 |
| VPN & tunneling | AWS VPN, Site-to-Site, PrivateLink | Phase 1 |
| Network troubleshooting | CloudWatch VPC Flow Logs analysis | Phase 1 |
| Port security | Kubernetes NetworkPolicy, CNI | Phase 2 |
| Network segmentation | Zero-trust, micro-segmentation | Phase 3 |
| OSI model depth | mTLS, service mesh (Istio) concepts | Phase 3 |
| TCP/IP fundamentals | CISSP Domain 4 (13% of exam) | Phase 4 |

> 💡 **CISSP note:** Domain 4 (Communication & Network Security) is essentially your CCNA at a conceptual security lens. You enter Phase 4 with ~13% of the exam already mastered.

---

### SonicWall Administrator (Expired)
Hands-on firewall administration experience that maps to modern cloud-native security:

| SonicWall Skill | Modern Equivalent | Phase |
|---|---|---|
| Stateful firewall rules | AWS Security Groups + NACLs | Phase 1 |
| IDS/IPS management | GuardDuty, Security Hub findings | Phase 1 |
| VPN configuration | AWS Client VPN, Site-to-Site VPN | Phase 1 |
| Content filtering policies | WAF rules, SCPs | Phase 1 |
| Log monitoring & alerting | CloudTrail + CloudWatch alarms | Phase 1 |
| Threat signatures | Falco rules, runtime detection | Phase 2 |
| Network segmentation | Kubernetes NetworkPolicy | Phase 2 |
| DPI (Deep Packet Inspection) | Service mesh observability | Phase 3 |

---

## 🧭 Your Accelerated Advantages

Based on your background, expect to move **~30–40% faster** than a typical learner in these areas:

- ✅ VPC architecture and network security configuration
- ✅ Firewall rules, WAF, and access control design
- ✅ VPN and secure connectivity patterns
- ✅ IDS/IPS and log-based detection concepts
- ✅ CISSP Domain 4 (Network Security)
- ✅ Kubernetes network policies and CNI security

Areas that will require full study time (no shortcut):

- 🔶 Container image security and supply chain (new domain)
- 🔶 CI/CD pipeline security (SAST/DAST/SCA tooling)
- 🔶 Threat modeling frameworks (STRIDE, PASTA, LINDDUN)
- 🔶 Cloud-native AppSec (OWASP API Top 10, service mesh mTLS)
- 🔶 CISSP Domains 1–3, 5–8

---

# Part 2 — Foundations Track (skills to solidify)

> Self-assess each area honestly. If you can already do everything in a section, check it off and move on. If not, spend a few evenings closing the gap before Phase 1 gets demanding.

## 🐧 Linux
- [ ] `systemd` — units, `systemctl`, enabling/masking services, dependencies
- [ ] `journald` / `journalctl` — querying logs, filtering by unit/time/priority
- [ ] Networking — `ip`, `ss`, `dig`, `curl -v`, routing tables, `/etc/resolv.conf`
- [ ] Permissions — users/groups, `chmod`/`chown`, SUID/SGID, capabilities
- [ ] Processes & namespaces — `ps`, `top`, cgroups/namespaces (the basis of containers)
- [ ] **Bash** — variables, conditionals, loops, functions, `set -euo pipefail`, traps

## 🐍 Python (DevSecOps automation)
- [ ] Core: virtualenvs, `pip`, type hints, exceptions, f-strings
- [ ] `requests` — calling APIs, handling auth headers, pagination, retries
- [ ] `subprocess` — running tools safely (no `shell=True` with user input)
- [ ] `boto3` — basic AWS automation (list resources, assume roles)
- [ ] `argparse` + logging — making a real CLI tool
- [ ] **Mini-project:** a script that audits something (e.g. lists public S3 buckets or IAM keys older than 90 days)

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

_← [Back to README](../README.md) | [Phase 1 →](phase-1-cloud.md)_
