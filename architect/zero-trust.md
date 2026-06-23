# Zero Trust Architecture

> **Reference:** NIST SP 800-207. **Why it matters:** "Design me a zero-trust architecture" is one of the most common senior/architect whiteboard prompts. You need the vocabulary and the failure modes, not the marketing.

---

## The one-sentence definition

Zero trust removes implicit trust based on **network location** and instead makes every access an **explicit, per-request, policy-based decision** using identity, device posture, and context.

## The NIST 800-207 logical model

```
        ┌─────────────────────────────┐
        │  Policy Decision Point (PDP) │  ← Policy Engine + Policy Administrator
        └──────────────┬──────────────┘
                       │ decision
   Subject ──request──►│
 (user +    Policy Enforcement Point (PEP) ──► Resource
  device)              │
                       └─ fed by: identity, device posture,
                          threat intel, SIEM, data sensitivity
```

- **PDP** = Policy Engine (decides) + Policy Administrator (executes the decision)
- **PEP** = where the decision is enforced (proxy, gateway, sidecar, mesh)
- Decisions are continuous, not one-time-at-login

## The tenets (know all seven)
1. All data sources and compute services are resources
2. All communication is secured regardless of network location
3. Access is granted per-session
4. Access is determined by dynamic policy (identity, device, behavior, environment)
5. The enterprise monitors and measures integrity/posture of all assets
6. Authentication and authorization are dynamic and strictly enforced *before* access
7. The enterprise collects telemetry to improve its security posture

## How it maps to what you'll build

| ZT concept | Concrete control in this roadmap |
|---|---|
| Identity as the perimeter | AWS IAM / OIDC, IRSA, SSO |
| Per-request authz | OPA / Kyverno admission, API gateway authz |
| Microsegmentation | K8s NetworkPolicy, service mesh mTLS ([Phase 3](../phases/phase-3-appsec.md)) |
| Device/workload posture | Falco runtime, image signing (Cosign) |
| Continuous monitoring | CloudTrail, GuardDuty, SIEM |

---

## Study checklist
- [ ] Read NIST SP 800-207 (it's short and readable)
- [ ] Distinguish ZTA from "ZTNA product" marketing
- [ ] Understand the three deployment approaches: enhanced identity governance, micro-segmentation, network infrastructure/SDP
- [ ] Know the failure modes: PDP availability, policy sprawl, "zero trust" that's really just a VPN replacement
- [ ] Map BeyondCorp (Google) as a real-world implementation

## Deliverable
- [ ] A zero-trust reference diagram for your capstone app, labeling every PEP/PDP, committed to [`reference-architectures.md`](reference-architectures.md)

---

_← [Architect Track](README.md)_
