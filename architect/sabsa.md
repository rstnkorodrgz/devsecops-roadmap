# SABSA — Business-Driven Security Architecture

> **Why it matters for the architect role:** SABSA is the most widely recognized *security architecture* framework. It forces every control to trace back to a business requirement — which is exactly the reasoning a hiring panel probes for an architect.

---

## The core idea

Security architecture is not a pile of controls. It is a **traceable chain** from *why the business exists* down to *which knob is set on which box*. SABSA models that chain as six layers, each answering the question of a different stakeholder.

## The SABSA Matrix (layers × questions)

| Layer | View | Asks |
|---|---|---|
| Contextual | Business | *What* business are we protecting? |
| Conceptual | Architect | *Why* — risk, attributes, objectives |
| Logical | Designer | *How* — services, control logic |
| Physical | Builder | *With what* — mechanisms, products |
| Component | Tradesman | *Which* specific tools/configs |
| Operational | Facilities Mgr | *Run-time* — monitoring, response |

Each layer is also examined through six questions: **What (assets), Why (motivation), How (process), Who (people), Where (location), When (time).**

## Business Attributes — the SABSA superpower

Instead of starting from controls, SABSA starts from **business attributes** — measurable qualities the business needs (e.g. *Available*, *Confidential*, *Traceable*, *Recoverable*, *Compliant*). Each attribute gets a **metric** and a **target**, and controls are justified by which attributes they satisfy.

> This is the single most useful SABSA habit to bring into interviews and design reviews: "This control exists because the *Traceable* and *Compliant* attributes require X, measured by Y."

---

## Study checklist
- [ ] Memorize the 6 layers and the 6 questions (the matrix)
- [ ] Build a business attributes profile for a sample company (10–15 attributes with metrics)
- [ ] Map one real control set (e.g. your Phase 1.5 pipeline) up the layers to a business driver
- [ ] Understand SABSA vs TOGAF (enterprise architecture) — SABSA plugs into TOGAF's ADM
- [ ] Compare SABSA vs NIST CSF vs ISO 27001 — when to reach for each

## Deliverable
- [ ] A one-page **Business Attributes Profile** + a single control traced through all 6 layers, committed here as `sabsa-example.md`

## Resources
- *Enterprise Security Architecture: A Business-Driven Approach* — Sherwood, Clark, Lynas
- SABSA Institute whitepapers (free with registration)
- Certs: **SCF** (Foundation) → **SCP** (Practitioner)

---

_← [Architect Track](README.md)_
