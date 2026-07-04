"""Findings API — Phase 1 scaffold.

Run it:
    uvicorn app.main:app --reload

Then open http://127.0.0.1:8000/docs for the auto-generated OpenAPI UI — that
interactive spec is free with FastAPI and is exactly what you'll document in Phase 3.
"""
from contextlib import asynccontextmanager

from fastapi import FastAPI

from .database import init_db
from .routers import findings


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup: create tables. (Modern lifespan API — not the deprecated on_event.)
    init_db()
    yield
    # Shutdown: nothing to clean up yet.


app = FastAPI(
    title="Findings API",
    version="0.1.0",
    summary="A small CRUD API for tracking security findings.",
    description=(
        "Phase 1 build scaffold for the API DevSecOps track. Intentionally has no "
        "auth yet — you add that in Phase 2 and attack the gap in Phase 4."
    ),
    lifespan=lifespan,
)

app.include_router(findings.router)


@app.get("/healthz", tags=["meta"], summary="Liveness probe")
def healthz() -> dict[str, str]:
    return {"status": "ok"}
