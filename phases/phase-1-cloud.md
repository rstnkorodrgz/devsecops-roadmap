# Phase 1 — Cloud Security Foundations

> **Duration:** Months 1–2 (8 weeks)  
> **Target Certification:** AWS Certified Security Specialty (SCS-C02)  
> **Accelerated by:** Security+ theory + CCNA networking depth

---

## 📊 Phase Progress

Count your checked boxes and update the README table.

`Week 1` `Week 2` `Week 3` `Week 4` `Week 5` `Week 6` `Week 7` `Week 8`

---

## 🗓️ Week 1–2 — AWS IAM & Account Security

### Concepts
- [ ] Understand AWS IAM policies: identity-based vs resource-based vs SCPs
- [ ] Master permission boundaries and when to use them
- [ ] Learn attribute-based access control (ABAC) with IAM tags
- [ ] Understand IAM roles vs users vs groups — when to use each
- [ ] Study AWS Organizations structure and multi-account patterns
- [ ] Review Service Control Policies (SCPs) — allow vs deny hierarchy
- [ ] Learn AWS IAM Access Analyzer — what it detects and how to act on findings
- [ ] Study CIS AWS Foundations Benchmark v1.5 (read the PDF)

### Hands-on Labs
- [ ] Create an AWS Free Tier account (if not already done)
- [ ] Build a least-privilege IAM policy for an EC2 instance using the policy simulator
- [ ] Set up an AWS Organization with two accounts (root + dev)
- [ ] Apply an SCP that prevents disabling CloudTrail
- [ ] Use IAM Access Analyzer to find externally shared resources
- [ ] Run `aws iam generate-credential-report` and analyze it
- [ ] Enable MFA on root account and all IAM users

### Tools to install (see [`../tools/macos-setup.md`](../tools/macos-setup.md))
- [ ] AWS CLI v2
- [ ] `aws-vault` (credential management)
- [ ] `iamlive` (policy generation from live API calls)

---

## 🗓️ Week 3–4 — Cloud Detection & VPC Security

### Concepts
- [ ] Understand Amazon GuardDuty — threat types, finding categories, suppression rules
- [ ] Learn AWS Security Hub — standards, controls, finding aggregation
- [ ] Study CloudTrail — management events vs data events vs Insights
- [ ] Understand VPC Flow Logs — format, filtering, analysis patterns
- [ ] Learn Security Groups vs NACLs — stateful vs stateless differences
- [ ] Study VPC endpoints (Gateway vs Interface) — security implications
- [ ] Understand AWS Config rules — managed vs custom, remediation actions
- [ ] Review AWS Macie — S3 data classification and sensitive data discovery

### Hands-on Labs
- [ ] Enable GuardDuty in your AWS account and generate sample findings
- [ ] Set up Security Hub with CIS AWS Foundations standard enabled
- [ ] Enable CloudTrail with S3 + CloudWatch Logs integration
- [ ] Create a VPC with public/private subnet isolation
- [ ] Configure VPC Flow Logs and query them with CloudWatch Insights
- [ ] Build an overly permissive Security Group and use Security Hub to detect it
- [ ] Set up an AWS Config rule to flag unencrypted S3 buckets

### Tools to install
- [ ] `steampipe` (SQL queries against AWS resources)
- [ ] `cloudmapper` (VPC visualization — Python)
- [ ] `prowler` (AWS security assessment CLI)

---

## 🗓️ Week 5–6 — Data Protection & Secrets Management

### Concepts
- [ ] Understand AWS KMS — CMKs, key policies, grants, envelope encryption
- [ ] Learn S3 security: bucket policies, ACLs, Block Public Access, Object Lock
- [ ] Study AWS Secrets Manager vs SSM Parameter Store — when to use which
- [ ] Understand ACM (Certificate Manager) — public vs private CAs
- [ ] Review encryption in transit requirements across AWS services
- [ ] Learn S3 server-side encryption modes (SSE-S3, SSE-KMS, SSE-C)
- [ ] Study AWS CloudHSM — use cases vs KMS

### Hands-on Labs
- [ ] Create a KMS customer-managed key with a restrictive key policy
- [ ] Rotate a secret automatically using Secrets Manager + Lambda
- [ ] Set up an S3 bucket with server-side encryption and Object Lock enabled
- [ ] Issue a private TLS certificate using ACM Private CA
- [ ] Configure S3 Block Public Access at the organization level via SCP
- [ ] Build a key policy that allows cross-account KMS access securely

### Tools to install
- [ ] `trufflehog` (secret scanning)
- [ ] `detect-secrets` (pre-commit secret detection — Python)

---

## 🗓️ Week 7 — STRIDE Basics & Attack Surface Mapping

### Concepts
- [ ] Learn the STRIDE threat model categories (Spoofing, Tampering, Repudiation, Info Disclosure, DoS, Elevation of Privilege)
- [ ] Understand how to identify trust boundaries in a cloud architecture
- [ ] Practice mapping an AWS architecture diagram to STRIDE threats
- [ ] Learn OWASP Threat Dragon (free threat modeling tool)
- [ ] Understand the difference between a vulnerability, a threat, and a risk
- [ ] Study the DREAD scoring system for threat prioritization

### Hands-on Labs
- [ ] Install and run OWASP Threat Dragon on your MacBook
- [ ] Draw a simple 3-tier AWS app (ALB → EC2 → RDS) and apply STRIDE
- [ ] Identify 5 threats and write mitigations for each
- [ ] Map your VPC architecture from Week 3–4 to trust boundaries

---

## 🗓️ Week 8 — AWS Security Specialty Exam Prep

### Concepts
- [ ] Review all SCS-C02 exam domains and their weights
- [ ] Study Incident Response on AWS (IR playbooks, Detective, Athena forensics)
- [ ] Review Infrastructure Security domain (ELB, WAF, Shield, Network Firewall)
- [ ] Review Identity & Access Management domain exam patterns
- [ ] Study Data Protection domain exam patterns

### Exam Prep
- [ ] Complete at least 200 practice questions (Tutorials Dojo / Whizlabs)
- [ ] Score 85%+ on two full-length practice exams
- [ ] Review all incorrect answers and re-study weak domains
- [ ] Schedule the SCS-C02 exam (Pearson VUE or testing center)
- [ ] ✅ **PASS AWS Security Specialty (SCS-C02)**

---

## 📚 Phase 1 Resources

| Resource | Type | Priority |
|---|---|---|
| AWS Security Specialty Official Study Guide | Book | ⭐⭐⭐ |
| Stephane Maarek — AWS Security Specialty (Udemy) | Course | ⭐⭐⭐ |
| Tutorials Dojo SCS-C02 Practice Exams | Practice | ⭐⭐⭐ |
| AWS Well-Architected Security Pillar whitepaper | Free PDF | ⭐⭐⭐ |
| CIS AWS Foundations Benchmark v1.5 | Free PDF | ⭐⭐ |
| CloudSecDocs.com | Reference | ⭐⭐ |

---

## ✅ Phase 1 Completion Checklist

- [ ] All weekly concept boxes checked
- [ ] All hands-on labs completed
- [ ] All Phase 1 tools installed and tested
- [ ] AWS Security Specialty exam passed
- [ ] Phase 1 tools verified working on MacBook
- [ ] Weekly log entries written for all 8 weeks

---

_← [Phase 0](phase-0-foundation.md) | [Back to README](../README.md) | [Phase 2 →](phase-2-cicd.md)_
