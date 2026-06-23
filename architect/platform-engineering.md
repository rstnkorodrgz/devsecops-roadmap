# Platform Engineering — The Architect Lens

> Hands-on platform work lives in [Phase 3.5](../phases/phase-3.5-platform-engineering.md). This module is the *architectural* framing: how a platform strategy is the highest-leverage security control an architect owns.

---

## The thesis

Every security control you add is either a **gate** (someone must pass it) or a **default** (it's already true). Gates create friction, get bypassed, and don't scale. **Platform engineering converts security gates into defaults** by baking them into golden paths developers *want* to use.

> "The secure way must be the easy way." If the secure path is slower than the insecure one, you have an architecture problem, not a developer-discipline problem.

## Core concepts (architect framing)

- **Paved road / golden path** — an opinionated, supported, secure-by-default way to ship a common workload. Off-road is allowed but unsupported.
- **Platform as a product** — developers are customers; adoption is the success metric, not mandate.
- **Guardrails over gates** — admission control, policy-as-code, and templates make the wrong thing *impossible* rather than *reviewed*.
- **Self-service** — teams provision compliant infrastructure without filing a ticket (Backstage scaffolder, Crossplane/Terraform modules, GitOps).
- **Thinnest viable platform** — start small; don't build a kingdom.

## Security controls that belong in the platform, not in each team

| Control | As a per-team task (gate) | As a platform default (paved road) |
|---|---|---|
| SAST/SCA | Each team wires up scanners | Generated CI template already includes them |
| Image provenance | Teams "should" sign images | Pipeline signs + admission rejects unsigned |
| Network isolation | Teams "should" add NetworkPolicy | Default-deny shipped with the namespace |
| Secrets | Teams "should" not hardcode | Secret injection wired into the template |
| Least-privilege IAM | Teams hand-write policies | Scoped role provisioned by the module |

## Measuring success
- [ ] Adoption rate of the paved road
- [ ] DORA metrics (lead time, deploy freq, MTTR, change-fail rate)
- [ ] % of services compliant *by default* vs by remediation
- [ ] Time-to-first-deploy for a new service

---

## Study checklist
- [ ] Read the CNCF Platforms White Paper
- [ ] Read *Team Topologies* (platform team / enabling team patterns)
- [ ] Be able to argue centralize-vs-federate for a platform capability
- [ ] Connect each [Phase 3.5](../phases/phase-3.5-platform-engineering.md) artifact to a security default it creates

## Deliverable
- [ ] A "paved road" design doc for one workload type that lists the security controls made automatic

---

_← [Architect Track](README.md)_
