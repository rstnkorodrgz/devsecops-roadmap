# Project 01 — Secure CI/CD Pipeline

> **Pairs with:** [Phase 3](../phases/phase-3-cks.md) · **Proves:** you can design a pipeline where security is automated, gating, and supply-chain-aware.

---

## Brief

Take a small but real app (a containerized REST API is ideal) and build a GitHub Actions pipeline that enforces security at every stage — and *fails the build* when controls are violated.

## Architecture

```
commit ─► pre-commit (gitleaks)
       ─► CI:
            ├─ SAST            (Semgrep)
            ├─ SCA             (Trivy / Snyk — fail on HIGH/CRITICAL)
            ├─ Secret scan     (Gitleaks)
            ├─ IaC scan        (Checkov)
            ├─ Build image     (distroless / minimal base)
            ├─ Image scan      (Trivy)
            ├─ SBOM            (Syft → CycloneDX)
            ├─ Sign            (Cosign, keyless/OIDC)
            └─ Provenance      (SLSA attestation)
       ─► deploy gate: admission rejects unsigned images
```

## Acceptance criteria
- [ ] Every stage above runs in CI and is visible in the Actions log
- [ ] At least one stage **demonstrably fails** the build on a planted vuln (show it in the README)
- [ ] All GitHub Actions pinned to commit SHAs; `GITHUB_TOKEN` least-privilege
- [ ] No long-lived cloud credentials — OIDC only
- [ ] SBOM published as a build artifact; image signed and verifiable
- [ ] `THREATMODEL.md` covering the pipeline itself (poisoned dependency, malicious PR, secret exfil)
- [ ] Controls matrix mapping each gate to NIST SSDF practices

## Stretch
- [ ] Branch protection + required checks documented
- [ ] DAST (OWASP ZAP) against an ephemeral deploy of the app
- [ ] In-toto / SLSA provenance verified at deploy time

## Tools
Semgrep · Trivy · Gitleaks · Checkov · Syft · Cosign · GitHub Actions OIDC

---

_← [Projects](README.md)_
