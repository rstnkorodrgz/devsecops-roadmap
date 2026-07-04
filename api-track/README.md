# 🛠️🔓 API Track — Build → Secure → Test → Break

> **Status: hands-on track — self-paced (~12 weeks part-time).** The applied companion to
> the [AppSec & Threat Modeling track](../tracks/appsec.md): where that track is a *study
> checklist*, this one has you **ship a real API and then attack it**.
> **Primary outcome:** a running, documented, authenticated API you built yourself — plus the
> **APIsec CASA** cert and a portfolio-grade pentest write-up.
> **Feeds:** [Pillar C — AI/App Security](../pillars/pillar-c-ai-security.md) (API security, testing methodology) and [Pillar D — Architecture](../pillars/pillar-d-architecture.md) (API design).
> **Interactive version:** [the visual roadmap](https://claude.ai/code/artifact/bce73ea8-0fa5-47ef-bec3-1eeca13b06da).

The premise: you can't secure — or credibly break — what you've never built. This track runs
one API through the full DevSecOps loop, and the loop *is* the deliverable.

```
01 BUILD  ──►  02 SECURE  ──►  03 TEST  ──►  04 BREAK
design & ship   harden it      prove it      red-team it
     └──────────────── same API, all the way through ───────────────┘
```

> 🧰 **Start here:** the [`fastapi-scaffold/`](fastapi-scaffold/) is a runnable FastAPI service
> (a "Findings API") so Phase 1 begins with working code, not a blank editor. It ships an
> **intentional BOLA** you close in Phase 2 and exploit in Phase 4.

---

## 📖 Phase 01 — Build  → design & ship a REST API

> Learn the shape of an API before the framework, then pick **one** stack and ship CRUD + a DB.
> **Python / FastAPI is the default** for this roadmap — you already read Python, and its typed
> validation is your first security control.

### Concepts
- [ ] REST fundamentals — resources, HTTP verbs, status codes, idempotency, JSON
- [ ] Request/response validation with typed schemas (Pydantic)
- [ ] Persistence — an ORM, migrations, and a session-per-request pattern
- [ ] Auto-generated OpenAPI/Swagger docs (free with FastAPI)

### Hands-on
- [ ] Read every file in [`fastapi-scaffold/`](fastapi-scaffold/) and run it (`uvicorn app.main:app --reload`)
- [ ] Extend it: add a `created_at` field, a `?severity=high` filter, and a second resource
- [ ] Containerize and run it once (`docker build` → `docker run`)

### Resources
| Resource | Type | Priority |
|---|---|---|
| [Designing RESTful APIs — Udacity](https://www.udacity.com/course/designing-restful-apis--ud388) (free) | Course | ⭐⭐⭐ |
| [FastAPI courses — Class Central](https://www.classcentral.com/subject/fastapi) (free) | Hub | ⭐⭐⭐ |
| [.NET Web API Zero to Hero](https://codewithmukesh.com/courses/dotnet-webapi-zero-to-hero/) (free) | Course | ⭐⭐ _(if you target .NET)_ |
| [REST APIs with Flask & Python — Udemy](https://www.udemy.com/topic/rest-api/) | Course | ⭐ _(paid, simpler)_ |

---

## 📖 Phase 02 — Secure  → harden the API you built

> Bolt security onto your own code, then map every fix to the **OWASP API Security Top 10**.
> This is where your DevSecOps background compounds — see [tracks/appsec.md Module B](../tracks/appsec.md) for the deep study checklist.

### Concepts
- [ ] Authentication — OAuth 2.0 / OIDC, JWT (and JWT attacks: `none`, alg confusion)
- [ ] Authorization — object-level checks that kill **BOLA (API1:2023)**
- [ ] Input validation, mass-assignment defence, and output filtering
- [ ] Rate limiting, secrets management (env/secret store, never hardcoded)
- [ ] The full [OWASP API Security Top 10](https://owasp.org/API-Security/)

### Hands-on
- [ ] Add an auth dependency + `owner_id` to the scaffold; scope every query to the caller
- [ ] Close the deliberate BOLA in [`routers/findings.py`](fastapi-scaffold/app/routers/findings.py)
- [ ] Move `DATABASE_URL` to an env var; add per-client rate limiting
- [ ] Front the API with a managed gateway (see the **cloud tracks** below)

### Resources
| Resource | Type | Priority |
|---|---|---|
| [API Security Fundamentals — APIsec University](https://www.apisecuniversity.com/courses/api-security-fundamentals) (free) | Course | ⭐⭐⭐ |
| [OWASP API Security Top 10](https://owasp.org/API-Security/) | Standard | ⭐⭐⭐ |
| [OWASP API Top 10 course — APIsec](https://www.credly.com/org/apisec-university/badge/owasp-api-security-top-10-2-hours) (free) | Course | ⭐⭐⭐ |
| [Secure Your APIs — freeCodeCamp](https://www.freecodecamp.org/news/owasp-api-security-top-10-secure-your-apis/) | Article | ⭐⭐ |

---

## 📖 Phase 03 — Test  → prove it works, then document it

> Exercise and document the API properly — the same tooling carries straight into offense.

### Concepts
- [ ] API testing with Postman collections + automated assertions
- [ ] Contract testing against the OpenAPI spec
- [ ] Negative testing — malformed input, authz edge cases, status-code correctness

### Hands-on
- [ ] Grow [`tests/`](fastapi-scaffold/tests/) — add authz and negative-path tests
- [ ] Import the scaffold's `openapi.json` into a Postman collection; add contract tests
- [ ] Wire the test run into CI (fail the build on a broken contract)

### Resources
| Resource | Type | Priority |
|---|---|---|
| [Postman Academy](https://academy.postman.com/) (free) | Course | ⭐⭐⭐ |
| [OpenAPI / Swagger docs](https://swagger.io/docs/) | Reference | ⭐⭐ |
| [REST API testing courses — Class Central](https://www.classcentral.com/subject/rest-apis) (free) | Hub | ⭐⭐ |

---

## 📖 Phase 04 — Break  → red-team it (the payoff)

> Attack deliberately-vulnerable APIs, then turn the tools on the service you built. This is the
> phase you're built for — and it ends in a respected, free, practical cert.

### Concepts
- [ ] API recon & attack-surface mapping
- [ ] Auth/authz attacks — BOLA, broken function-level authz, JWT abuse
- [ ] Injection, mass assignment, SSRF at the API layer

### Hands-on
- [ ] Complete the [APIsec API Penetration Testing course](https://www.apisecuniversity.com/courses/api-penetration-testing) (12 h) against [vAPI/crAPI](https://github.com/roottusk/vapi)
- [ ] Exploit the BOLA in your **own** scaffold with Postman/Burp/ZAP — then fix it and prove the fix
- [ ] Write a portfolio-grade findings report (ties into the [threat-model deliverable](../tracks/appsec.md))
- [ ] Sit **CASA**; then work toward **ASCP**

### Resources
| Resource | Type | Priority |
|---|---|---|
| [API Penetration Testing (12h) — APIsec](https://www.apisecuniversity.com/courses/api-penetration-testing) (free) | Course | ⭐⭐⭐ |
| [CASA — Certified API Security Analyst](https://www.apisecuniversity.com/) (free) | Cert · entry | ⭐⭐⭐ |
| [ASCP — API Security Certified Professional](https://university.apisec.ai/apisec-certified-expert) (free) | Cert · pro (12h practical) | ⭐⭐⭐ |
| [vAPI & crAPI](https://github.com/roottusk/vapi) | Lab | ⭐⭐⭐ |

---

## ☁️ Cloud provider tracks

In production you front an API with a managed gateway (auth, keys, throttling, monitoring).
Layer one in during Phase 02–03. Given the roadmap is [Azure-primary](../README.md), **start with
APIM**; Apigee has the deepest dedicated *security* course of the three.

| Provider | Service | Best training | Covers |
|---|---|---|---|
| **Azure** ★ | API Management | [MS Learn: Implement API Management](https://learn.microsoft.com/en-us/training/paths/az-204-implement-api-management/) · [Explore APIM](https://learn.microsoft.com/en-us/training/modules/explore-api-management/) (free, official) | Policies, transform/secure APIs, backend APIs, AKS, lifecycle |
| **GCP** | Apigee | [Coursera: Developing APIs with Apigee](https://www.coursera.org/specializations/apigee-api-gcp) (3-course) | Design & Fundamentals · **API Security** (OAuth/JWT/federation) · Development |
| **AWS** | API Gateway | [Official tutorials & workshops](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-tutorials.html) · [Educative](https://www.educative.io/courses/aws-api-gateway-the-unsung-warrior) | REST/HTTP/WebSocket, authorizers, throttling, serverless |
| Others | Kong · Cloudflare · IBM API Connect | Vendor docs & free tiers | Concepts (keys, rate limits, plugins) transfer once you know one gateway |

---

## 🗓️ Suggested 12-week run

| Weeks | Focus | Phase |
|---|---|---|
| 1–2 | RESTful design + spin up the FastAPI scaffold | 01 Build |
| 3–4 | Add DB fields, filters, a 2nd resource; deploy once (Docker) | 01 Build |
| 5–6 | APIsec Fundamentals + add JWT/OAuth2, validation, rate limiting | 02 Secure |
| 7 | OWASP API Top 10 audit of your code; front it with a cloud gateway | 02 + Cloud |
| 8 | Postman Academy + automated test collection | 03 Test |
| 9–10 | APIsec pentest course vs vAPI/crAPI, then your own API | 04 Break |
| 11 | Sit the **CASA** exam (free) | 04 Break |
| 12+ | Work toward the **ASCP** practical pentest | 04 Break |

---

## ✅ Track completion signals

- [ ] A running API **you built**, with auth, validation, rate limiting, and OpenAPI docs
- [ ] The scaffold's deliberate BOLA closed — with a test that proves it stays closed
- [ ] A Postman collection + CI contract test against the OpenAPI spec
- [ ] A portfolio pentest write-up (exploit → fix → verification) on your own API
- [ ] **CASA** passed; **ASCP** scheduled or in progress

---

_← [tracks/appsec.md](../tracks/appsec.md) · [Pillars](../pillars/README.md) | [Back to README](../README.md)_
