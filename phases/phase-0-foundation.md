# Phase 0 — Your Existing Foundation

> These are your earned credentials and the skills they unlock across the roadmap.  
> Nothing to complete here — this is your **starting advantage map**.

---

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

_← [Back to README](../README.md) | [Phase 1 →](phase-1-cloud.md)_
