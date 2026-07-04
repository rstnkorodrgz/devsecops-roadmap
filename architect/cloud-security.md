# Cloud Security Architecture

> **Why it matters:** The architect owns the *reference* cloud security design that every team inherits. This module is the organizational lens on the hands-on cloud work from [Phase 1](../phases/phase-1-terraform.md) and [Phase 4](../phases/phase-4-sc500.md) (AWS specifics: [dormant elective](../electives/aws-security-specialty.md)).

---

## Shared responsibility — get this exactly right

The boundary moves with the service model. An architect must state *who owns what* per layer:

| Layer | IaaS (EC2) | Containers (EKS) | Serverless (Lambda) |
|---|---|---|---|
| Data & access policy | **You** | **You** | **You** |
| App code | **You** | **You** | **You** |
| OS / runtime patching | **You** | Shared | Cloud |
| Cluster control plane | — | Cloud | — |
| Hardware/network | Cloud | Cloud | Cloud |

> Misstating this boundary is the fastest way to fail a cloud architecture interview.

## Reference building blocks

- **Account/organization structure** — landing zone, OU hierarchy, SCP guardrails, separate prod/security/log-archive accounts
- **Identity** — centralized SSO, federation, no long-lived keys, OIDC for CI, IRSA for workloads
- **Network** — segmented VPCs, private subnets, PrivateLink/endpoints, egress control, flow logs
- **Data** — encryption at rest (KMS, key hierarchy), in transit (TLS everywhere), classification-driven controls
- **Detection** — CloudTrail (org trail to log-archive account), GuardDuty, Security Hub, Config rules
- **Posture management** — **CSPM** (continuous misconfig detection) + **CWPP** (workload protection); know **CNAPP** as the converged category

## Multi-cloud / hybrid considerations
- [ ] Avoid lowest-common-denominator security; abstract *policy*, not *primitives*
- [ ] Centralize identity and logging across providers
- [ ] Understand control-plane blast radius per provider

---

## Study checklist
- [ ] Draw a full AWS landing zone from memory (accounts, OUs, SCPs, log archive)
- [ ] Map the shared responsibility table for IaaS/containers/serverless
- [ ] Know CSPM vs CWPP vs CNAPP vs CIEM and what each detects
- [ ] Map AWS controls to the **Well-Architected Security Pillar** and **CIS Benchmark**
- [ ] Understand landing-zone tooling (AWS Control Tower, org Terraform) at a design level

## Deliverable
- [ ] A cloud reference architecture diagram + controls matrix in [`reference-architectures.md`](reference-architectures.md)

## Resources
- AWS Well-Architected — Security Pillar (whitepaper)
- AWS Security Reference Architecture (AWS SRA)
- CSA Cloud Controls Matrix (CCM)

---

_← [Architect Track](README.md)_
