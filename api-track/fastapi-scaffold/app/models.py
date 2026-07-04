"""Data model for a security *finding*.

One base class (`FindingBase`) carries the shared, validated fields. The table model,
the create payload, the patch payload, and the read/response model all derive from it
so validation lives in exactly one place — this is the FastAPI/SQLModel idiom and a
core Phase 1 lesson (typed input validation is also your first line of API defence).
"""
from enum import Enum

from sqlmodel import Field, SQLModel


class Severity(str, Enum):
    low = "low"
    medium = "medium"
    high = "high"
    critical = "critical"


class Status(str, Enum):
    open = "open"
    triaged = "triaged"
    resolved = "resolved"


class FindingBase(SQLModel):
    title: str = Field(index=True, min_length=1, max_length=200)
    severity: Severity = Severity.medium
    status: Status = Status.open
    description: str | None = Field(default=None, max_length=4000)
    owner: str | None = Field(default=None, description="Team or person accountable")


class Finding(FindingBase, table=True):
    """The database table."""

    id: int | None = Field(default=None, primary_key=True)


class FindingCreate(FindingBase):
    """Request body for POST — same fields, no id (the server assigns it)."""


class FindingUpdate(SQLModel):
    """Request body for PATCH — every field optional, only sent ones are applied."""

    title: str | None = Field(default=None, min_length=1, max_length=200)
    severity: Severity | None = None
    status: Status | None = None
    description: str | None = Field(default=None, max_length=4000)
    owner: str | None = None


class FindingRead(FindingBase):
    """Response model — guarantees `id` is present in what we return."""

    id: int
