"""Database wiring — one SQLite file, one engine, a session-per-request dependency.

Kept deliberately small: understanding this file is a Phase 1 goal. When you reach
Phase 2 you'll likely swap SQLite for Postgres and move the URL into an env var /
secret — that migration is the point.
"""
from collections.abc import Iterator

from sqlmodel import Session, SQLModel, create_engine

# TODO(Phase 2): read this from an environment variable / secret, never hardcode
#                a real connection string. SQLite-on-disk is fine for the scaffold.
DATABASE_URL = "sqlite:///./findings.db"

# check_same_thread=False lets FastAPI's threadpool share the SQLite connection.
engine = create_engine(
    DATABASE_URL,
    echo=False,
    connect_args={"check_same_thread": False},
)


def init_db() -> None:
    """Create tables from the SQLModel metadata. Idempotent."""
    SQLModel.metadata.create_all(engine)


def get_session() -> Iterator[Session]:
    """FastAPI dependency: yields a session and closes it after the request."""
    with Session(engine) as session:
        yield session
