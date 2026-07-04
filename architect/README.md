# 🏛️ Architecture Library (Pillar D curriculum)

> **v2.0 role:** the reading library behind [Pillar D — Architecture Depth](../pillars/pillar-d-architecture.md). Worked as design questions arise, not on a schedule. SABSA is **optional reading** — the business-attribute habit matters; the SCF/SCP exams do not.

The engineer proves they can *build and secure* systems. The architect proves they can *design, justify, and govern* them at organizational scale. This track is about frameworks, trade-offs, and reference designs — the language of architecture interviews and design reviews.

---

## 📚 Modules

| Module | Focus | Read order |
|---|---|---|
| [`sabsa.md`](sabsa.md) | Business-driven security architecture (SABSA matrix, attributes) | 1 |
| [`zero-trust.md`](zero-trust.md) | NIST 800-207 zero trust architecture | 2 |
| [`cloud-security.md`](cloud-security.md) | Cloud reference security architecture, shared responsibility, CSPM | 3 |
| [`secure-sdlc.md`](secure-sdlc.md) | Secure SDLC, NIST SSDF, OWASP SAMM/BSIMM | 4 |
| [`platform-engineering.md`](platform-engineering.md) | Platform-as-product, golden paths, paved roads (architect lens) | 5 |
| [`reference-architectures.md`](reference-architectures.md) | Diagram library + controls matrices you can reuse | 6 |

---

## 🎯 What "architect-ready" looks like

By the end of this track you should be able to, on a whiteboard, in 45 minutes:

- [ ] Take an ambiguous business requirement and derive security requirements from it (SABSA)
- [ ] Draw a zero-trust reference architecture and name the policy decision/enforcement points
- [ ] Produce a security controls matrix mapped to a framework (NIST CSF / SSDF / CIS)
- [ ] Defend a build-vs-buy and a centralize-vs-federate decision with explicit trade-offs
- [ ] Threat-model a proposed design live and propose mitigations with residual-risk acceptance
- [ ] Explain how a paved road turns each control into a default rather than a review gate

---

## 🪜 Recommended certification ladder (architect-oriented)

See the [root README](../README.md#-certification-ladder) for the v2.0 rationale.

```
Terraform Associate → CKA → CKS ★ → SC-500 → CCSP
electives by trigger: AWS SCS · CISSP        (SABSA: reading only)
```

---

_← [Back to README](../README.md)_
