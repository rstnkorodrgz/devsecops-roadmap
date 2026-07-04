# Pillar C — AI Security Specialization

> **The bet:** fastest-appreciating niche, no dominant certification yet → judged on artifacts, which favors first movers. In LATAM the field is nearly empty — a working portfolio here is a category-of-one position.
> **Cert tie-in:** [SC-500](../phases/phase-4-sc500.md) covers AI security on Azure — the cert study and these artifacts feed each other.

## Foundations
- [ ] OWASP Top 10 for LLM/GenAI Applications — ✅ done in v1.x; keep current with new revisions
- [ ] Prompt injection classes — direct, indirect, multi-modal; defense layering (input filtering, output validation, tool allow-listing, human-in-the-loop)
- [ ] Model & data supply chain — provenance, model signing, training-data poisoning, registry access control (Phase 3 supply-chain thinking applied to models)
- [ ] NIST AI RMF — governance vocabulary for design reviews

## Project 1 — LLM security testing harness (public repo)
- [ ] Automated probe suite: injection payloads, jailbreak corpus, data-exfil canaries, tool-abuse scenarios
- [ ] Pluggable targets (OpenAI-compatible endpoints, Azure OpenAI); CI-runnable with a pass/fail report
- [ ] `THREATMODEL.md` for the harness itself

## Project 2 — Secure RAG reference architecture (public, with threat model)
- [ ] Full design: ingestion, retrieval, generation — trust boundaries drawn explicitly
- [ ] Threats: retrieval poisoning, context injection, tenant isolation of embeddings, secrets in prompts
- [ ] Controls matrix + residual-risk acceptance; deployable sample on the Phase 1 Azure landing zone

## Integration — AI security gates in CI/CD
- [ ] Extend the Phase 3 pipeline: harness probes as a gate for LLM-app changes, model/artifact signing, prompt-template scanning

## Output
- [ ] 1 talk + 1 written deep-dive from the above ([Pillar B](pillar-b-research-speaking.md))

## Feeder
[`tracks/appsec.md`](../tracks/appsec.md) — API security and testing methodology underpin the harness work.

---

_← [Pillars](README.md)_
