# Project 03 — Cloud Security (AWS)

> **Pairs with:** [AWS elective](../electives/aws-security-specialty.md) *(dormant)* + [Phase 1](../phases/phase-1-terraform.md) · **Proves:** you can provision a secure-by-default AWS environment as code, then continuously verify it.

---

## Brief

Build a small but real AWS environment **entirely in Terraform**, secured by default, scanned in CI, and monitored at runtime. This is the reusable foundation for the [Capstone](project-05-devsecops-capstone.md).

## Architecture

```
Terraform / Terragrunt
        ↓
  Multi-account org (mgmt · workload · log-archive)
        ↓
  VPC: private subnets, endpoints, flow logs, egress control
        ↓
  Guardrails: SCPs, IAM least-privilege, KMS key hierarchy
        ↓
  Detection: org CloudTrail → log-archive, GuardDuty, Security Hub, Config
```

## Acceptance criteria
- [ ] 100% provisioned via Terraform with remote, locked, encrypted state
- [ ] Checkov + Trivy (`trivy config`) gate the apply; findings triaged
- [ ] CloudTrail org trail delivers to a separate log-archive account
- [ ] GuardDuty + Security Hub enabled; at least one finding triaged end-to-end
- [ ] No IAM users with long-lived keys; OIDC for CI, roles for workloads
- [ ] Run **Prowler** and/or **steampipe** CSPM scan; publish a before/after posture score
- [ ] `THREATMODEL.md` for the environment; controls matrix mapped to CIS AWS Benchmark + Well-Architected Security Pillar

## Stretch
- [ ] Break it on purpose: deploy a CloudGoat/flaws.cloud-style misconfig, detect it via Config/GuardDuty, auto-remediate
- [ ] Cost guardrails (budgets, Infracost in CI)

## Tools
Terraform · Terragrunt · Checkov · Trivy · Prowler · steampipe · GuardDuty · Security Hub

---

_← [Projects](README.md)_
