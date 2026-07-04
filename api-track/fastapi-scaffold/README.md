# Findings API — Phase 1 Scaffold

A small, runnable **FastAPI** service so the [API DevSecOps track](../README.md) starts
with code on day one, not just courses. It's a CRUD API for tracking security findings
(`title`, `severity`, `status`, `owner`) backed by SQLite.

It is **intentionally incomplete**: there is no authentication and no ownership check.
That gap is the spine of the whole track — you *add* auth in Phase 2 and *exploit* the
missing check (BOLA) in Phase 4.

---

## Quick start

```bash
cd api-track/fastapi-scaffold

python3 -m venv .venv
source .venv/bin/activate          # Windows: .venv\Scripts\activate
pip install -r requirements.txt

uvicorn app.main:app --reload
```

Then open:

| URL | What it is |
|---|---|
| http://127.0.0.1:8000/docs | Interactive Swagger UI (auto-generated) |
| http://127.0.0.1:8000/redoc | Alternative ReDoc documentation |
| http://127.0.0.1:8000/openapi.json | The raw OpenAPI spec you'll work with in Phase 3 |
| http://127.0.0.1:8000/healthz | Liveness probe |

## Try it

```bash
# create a finding
curl -s -X POST http://127.0.0.1:8000/findings \
  -H 'content-type: application/json' \
  -d '{"title":"Secrets in CI logs","severity":"high","owner":"platform"}' | jq

# list them
curl -s http://127.0.0.1:8000/findings | jq

# read / patch / delete by id
curl -s http://127.0.0.1:8000/findings/1 | jq
curl -s -X PATCH http://127.0.0.1:8000/findings/1 -H 'content-type: application/json' -d '{"status":"triaged"}' | jq
curl -s -X DELETE http://127.0.0.1:8000/findings/1 -i
```

## Run the tests

```bash
pytest -q
```

Four tests exercise create/read/update/delete, enum validation (`422`), and `404`s.

## Run it in a container (Phase 1 "deploy once")

```bash
docker build -t findings-api .
docker run --rm -p 8000:8000 findings-api
```

---

## Layout

```
fastapi-scaffold/
├── app/
│   ├── main.py            ← FastAPI app + lifespan + /healthz
│   ├── database.py        ← engine, init_db(), get_session() dependency
│   ├── models.py          ← SQLModel: Finding + Create/Update/Read schemas
│   └── routers/
│       └── findings.py    ← the CRUD endpoints (BOLA left in on purpose)
├── tests/test_findings.py ← pytest + TestClient
├── conftest.py            ← puts the root on sys.path for imports
├── Dockerfile · .dockerignore
└── requirements.txt
```

## Your job, by phase

- **Phase 1 — Build** ✅ *You are here.* Read every file; extend it: add a `created_at`
  timestamp, a `GET /findings?severity=high` filter, and a second resource (e.g. `assets`).
- **Phase 2 — Secure** 🔒 Add an auth dependency (JWT/OAuth2), attach an `owner_id` to each
  finding, and scope every query to the authenticated caller. Move `DATABASE_URL` to an env var.
  Add rate limiting.
- **Phase 3 — Test** 🧪 Grow the test suite; import the OpenAPI spec into a Postman collection
  and add contract tests.
- **Phase 4 — Break** 💥 Point the APIsec pentest tooling (Postman/Burp/ZAP) at your running
  instance and exploit the BOLA in `routers/findings.py` — then fix it and prove the fix.

> ⚠️ This service is for local learning only. It has known, deliberate vulnerabilities —
> never deploy it to a public network.
