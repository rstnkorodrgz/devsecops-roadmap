"""A first taste of Phase 3 (Test): exercise every endpoint end-to-end.

Run with:  pytest
Uses FastAPI's TestClient as a context manager so the lifespan startup (init_db) runs.
"""
import pytest
from fastapi.testclient import TestClient

from app.database import init_db
from app.main import app


@pytest.fixture(scope="module")
def client():
    init_db()
    with TestClient(app) as c:
        yield c


def test_health(client):
    r = client.get("/healthz")
    assert r.status_code == 200
    assert r.json() == {"status": "ok"}


def test_create_read_update_delete(client):
    # create
    r = client.post("/findings", json={"title": "BOLA on /findings", "severity": "high"})
    assert r.status_code == 201
    body = r.json()
    assert body["id"] > 0
    assert body["status"] == "open"  # server default applied
    fid = body["id"]

    # read
    r = client.get(f"/findings/{fid}")
    assert r.status_code == 200
    assert r.json()["title"] == "BOLA on /findings"

    # update (patch)
    r = client.patch(f"/findings/{fid}", json={"status": "triaged"})
    assert r.status_code == 200
    assert r.json()["status"] == "triaged"

    # delete
    assert client.delete(f"/findings/{fid}").status_code == 204
    assert client.get(f"/findings/{fid}").status_code == 404


def test_validation_rejects_bad_severity(client):
    r = client.post("/findings", json={"title": "x", "severity": "apocalyptic"})
    assert r.status_code == 422  # Pydantic rejects values outside the enum


def test_missing_finding_is_404(client):
    assert client.get("/findings/999999").status_code == 404
