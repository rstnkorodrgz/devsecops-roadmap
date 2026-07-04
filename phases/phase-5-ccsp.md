# Phase 5 — Cloud Security Architecture Consolidation (CCSP)

> **Duration:** Months 14–18
> **Target Certification:** **CCSP — Certified Cloud Security Professional (ISC2).** **Book the exam at the start of the phase.**
> **Quarterly artifact:** Multi-cloud cloud security reference architecture (Azure primary, AWS at design level)
> **Why CCSP and not CISSP:** vendor-neutral cloud security architecture depth without the managerial framing — the ISC2 brand that regulated-market filters recognize, stacked on the technical proof of CKS + SC-500. CISSP lives in the [contingency appendix](../electives/cissp-contingency.md).

> ⚠️ **Exam currency:** CCSP moved to **CAT format (100–150 questions, 3 hours)** in late 2025, and a **new exam outline took effect August 1, 2026** — six domains kept, content refreshed. Use only post-refresh study materials.
> ✅ **Experience requirement met:** 5 years IT / 3 years security / 1 year in a CCSP domain — comfortably covered by your background. Endorsement follows the exam.

---

## 🗓️ Months 14–15 — Domains 1–3

### Domain 1 — Cloud Concepts, Architecture & Design
- [ ] Cloud reference architecture, shared responsibility across IaaS/PaaS/SaaS (you know this cold from [architect/cloud-security.md](../architect/cloud-security.md) — review through the ISC2 lens)
- [ ] Security design principles: secure-by-design, zero trust (NIST 800-207), defense in depth
- [ ] Cryptography in cloud contexts: envelope encryption, KMS/HSM models, key ownership (BYOK/HYOK)

### Domain 2 — Cloud Data Security
- [ ] Data lifecycle, classification, discovery; DLP strategies
- [ ] Encryption models per service tier; tokenization, masking
- [ ] Data residency & sovereignty — **know the Chilean/LATAM angle for regulated clients**

### Domain 3 — Cloud Platform & Infrastructure Security
- [ ] Virtualization/container/serverless security boundaries (Phases 2–3 made this hands-on; review conceptually)
- [ ] Identity federation, network isolation, workload protection at architecture level

---

## 🗓️ Month 16 — Domains 4–6

### Domain 4 — Cloud Application Security
- [ ] Secure SDLC, SSDF mapping (review [architect/secure-sdlc.md](../architect/secure-sdlc.md)), supply chain — largely review after Phase 3

### Domain 5 — Cloud Security Operations
- [ ] SOC operations, incident response, forensics in cloud, logging/monitoring — SC-500 Sentinel work covers the practice; learn the ISC2 vocabulary

### Domain 6 — Legal, Risk & Compliance
- [ ] **The genuinely new material — front-load it.** Privacy regimes (GDPR + LATAM equivalents), audit (SOC 2, ISO 27001/27017/27018), contracts & SLAs, risk frameworks
- [ ] eDiscovery, chain of custody, cross-border transfer mechanisms

---

## 🗓️ Months 17–18 — Exam & Capstone Artifact

### Exam Prep
- [ ] Post-August-2026-outline study guide (ISC2 official or Destination Certification)
- [ ] Two full practice exams at 80%+; drill Domain 6 hardest
- [ ] ✅ **PASS CCSP** → submit endorsement
- [ ] ISC2 AMF + CPE plan (shared with any future ISC2 cert)

### 📦 Quarterly artifact (Q6) — the capstone
- [ ] **Multi-cloud cloud security reference architecture** (public, in [architect/reference-architectures.md](../architect/reference-architectures.md)):
  - Azure as the worked, provable example (Phases 1 + 4 artifacts)
  - AWS mapped at **design level** — equivalent control per layer (Entra↔IAM, Defender↔GuardDuty/Security Hub, Policy↔SCP/Config…)
  - Controls matrix mapped to CCSP domains + CIS + MCSB
  - Threat model with trust boundaries and residual-risk acceptance
  - This is where "multi-cloud" lives in the Azure-primary strategy: **design fluency, not duplicated labs**

---

## 📚 Resources
- ISC2 Official CCSP Study Guide (post-2026-outline edition)
- Destination Certification CCSP MindMaps (YouTube — free)
- Pete Zerger CCSP Exam Cram (YouTube — free)
- LearnZapp CCSP (ISC2 official practice app)

---

_← [Phase 4](phase-4-sc500.md) | [Back to README](../README.md) | [Pillars →](../pillars/README.md)_
