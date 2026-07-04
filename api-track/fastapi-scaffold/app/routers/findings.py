"""CRUD endpoints for findings.

Notice what is deliberately MISSING: there is no authentication and no ownership
check. Anyone can read, edit, or delete anyone's finding by guessing the integer id.
That is Broken Object Level Authorization (OWASP API1:2023 / BOLA) left in on purpose:

  - Phase 2 (Secure): add an auth dependency and scope queries to the caller.
  - Phase 4 (Break):  exploit this exact gap against your own running instance.
"""
from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlmodel import Session, select

from ..database import get_session
from ..models import Finding, FindingCreate, FindingRead, FindingUpdate

router = APIRouter(prefix="/findings", tags=["findings"])


@router.get("", response_model=list[FindingRead])
def list_findings(
    session: Session = Depends(get_session),
    limit: int = Query(default=50, le=200),
    offset: int = Query(default=0, ge=0),
) -> list[Finding]:
    return list(session.exec(select(Finding).offset(offset).limit(limit)).all())


@router.post("", response_model=FindingRead, status_code=status.HTTP_201_CREATED)
def create_finding(
    payload: FindingCreate,
    session: Session = Depends(get_session),
) -> Finding:
    finding = Finding.model_validate(payload)
    session.add(finding)
    session.commit()
    session.refresh(finding)
    return finding


@router.get("/{finding_id}", response_model=FindingRead)
def get_finding(
    finding_id: int,
    session: Session = Depends(get_session),
) -> Finding:
    finding = session.get(Finding, finding_id)
    if finding is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Finding not found")
    return finding


@router.patch("/{finding_id}", response_model=FindingRead)
def update_finding(
    finding_id: int,
    payload: FindingUpdate,
    session: Session = Depends(get_session),
) -> Finding:
    finding = session.get(Finding, finding_id)
    if finding is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Finding not found")
    for key, value in payload.model_dump(exclude_unset=True).items():
        setattr(finding, key, value)
    session.add(finding)
    session.commit()
    session.refresh(finding)
    return finding


@router.delete("/{finding_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_finding(
    finding_id: int,
    session: Session = Depends(get_session),
) -> None:
    finding = session.get(Finding, finding_id)
    if finding is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Finding not found")
    session.delete(finding)
    session.commit()
