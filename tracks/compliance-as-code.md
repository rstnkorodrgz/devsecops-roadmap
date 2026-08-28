# Track — Compliance as Code (Background)

> **Status: gap-closing track — sequenced, ~8 hrs.** Added in v2.2 to close **CDP Chapter 8**, the thinnest chapter in the gap analysis (~20% covered).
> **Prerequisite:** [config-management.md](config-management.md) — you need a hardened host before you can prove it is hardened. **Do these two back to back**; they are one continuous lab.
> **Primary outcome:** an executable compliance profile that turns "we hardened the fleet" from a claim into a **test result an auditor can read**.
> **Feeds:** [architect/secure-sdlc.md](../architect/secure-sdlc.md) (the governance layer) and the [Phase 5 capstone](../phases/phase-5-ccsp.md).

---

## 🧭 The idea in one paragraph

You already write **preventive** policy: Checkov and Rego stop bad infrastructure from being *created* ([Phase 1](../phases/phase-1-terraform.md)). Compliance as code is the **detective** half: code that inspects a system that already exists and asserts it still matches policy. Same shift-left instinct, opposite direction in time. In a regulated market — which is exactly the Chilean market this roadmap targets — the detective half is what gets shown to auditors, because "the pipeline would have blocked it" is not evidence, and a passing test report is.

- [ ] Be able to state the difference: **preventive** (Checkov, OPA admission) vs **detective** (Inspec, OpenSCAP, CSPM) vs **corrective** (Ansible re-run, auto-remediation)
- [ ] Understand why compliance evidence has to be *repeatable and dated* to be worth anything

---

## 📖 Module A — Inspec (~3.5 hrs)

Inspec is a Ruby DSL that reads like English: `describe` a resource, assert what it `should` look like. If you can read a pytest assertion, you can read Inspec.

> 📌 **Licensing — read this before installing.** Chef InSpec 5+ requires accepting a Progress Chef licence, and commercial use is not free. **CINC Auditor** is the licence-clean community rebuild of the same codebase — identical syntax, identical profiles, different binary name (`cinc-auditor` instead of `inspec`). Use CINC for self-study. Know the distinction; it comes up when you propose the tool at work.

### Concepts
- [ ] **Controls** — the unit of compliance: an `id`, `impact`, `title`, `desc`, and one or more `describe` blocks
- [ ] **Resources** — the built-in things you can assert on: `sshd_config`, `file`, `package`, `service`, `user`, `port`, `command`, `kernel_parameter`
- [ ] **Matchers** — `should eq`, `should cmp`, `should include`, `should be_owned_by`, and why `cmp` exists (loose type comparison)
- [ ] **Profiles** — the packaging unit: `inspec.yml`, `controls/`, `libraries/`, and profile **inheritance** (`depends`)
- [ ] **Impact → severity** — `impact 1.0` is critical, `0.0` is informational; this drives your report
- [ ] **Waivers** — documented, dated, expiring exceptions. The auditor-facing feature everyone forgets exists
- [ ] **Targets** — local, SSH, Docker, WinRM: `-t ssh://user@host`, `-t docker://container`

### Hands-on
```bash
brew install --cask chef/chef/inspec        # or the CINC build: https://cinc.sh
# CINC path (licence-clean):
#   curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-auditor

cinc-auditor init profile hardening-baseline
cd hardening-baseline
```

Write your first control against the host you hardened in the previous track:

```ruby
# controls/ssh.rb
control 'ssh-01' do
  impact 1.0
  title 'SSH must not permit root login'
  desc  'CIS Ubuntu 22.04 Benchmark 5.2.7'

  describe sshd_config do
    its('PermitRootLogin')        { should cmp 'no' }
    its('PasswordAuthentication') { should cmp 'no' }
    its('X11Forwarding')          { should cmp 'no' }
  end
end
```

```bash
cinc-auditor exec . -t ssh://ubuntu@$TARGET_IP -i ~/.ssh/lab_ed25519
cinc-auditor exec . -t ssh://... --reporter cli json:results.json
```

- [ ] Run the profile against the **un-hardened** VM first — watch it fail. Save that output.
- [ ] Run your Ansible role, run the profile again — watch it pass. **That before/after pair is your deliverable.**
- [ ] Write **one control per hardening task** in your Ansible role — SSH, sysctl, auditd, filesystem, accounts, time sync
- [ ] Add a control that uses `command(...)` and assert on `stdout` — the escape hatch for anything without a built-in resource
- [ ] Add a **waiver file** for one control you deliberately don't meet, with an expiry date and a justification
- [ ] Emit JSON with `--reporter json:results.json` — you will feed this into DefectDojo in [project-01](../projects/project-01-secure-cicd.md)
- [ ] Run the same profile against a **Docker** target (`-t docker://...`) to see it work on containers

---

## 📖 Module B — OpenSCAP (~2.5 hrs)

Where Inspec is *your* policy expressed as code, OpenSCAP runs **standardised government/industry content** — the SCAP ecosystem. You rarely author SCAP; you run it, read it, and remediate from it.

### Concepts
- [ ] **SCAP** as an umbrella of standards: **XCCDF** (the checklist), **OVAL** (the low-level checks), **CPE** (platform identification), **datastream** (all of it in one XML)
- [ ] **SSG / ComplianceAsCode** — the open-source content project that ships the actual CIS/STIG/PCI profiles
- [ ] **Profiles** — one datastream contains many (`cis_level1_server`, `stig`, `pci-dss`); you pick one
- [ ] Why **remediation output** matters: OpenSCAP can generate an Ansible playbook or a bash script that fixes what it found — the loop back to the previous track
- [ ] Where this fits vs a CSPM: SCAP is *inside the OS*, CSPM is *outside at the cloud control plane*. You need both

### Hands-on
Run these **inside the Ubuntu VM** — `oscap` is a Linux tool, not a macOS one.

```bash
multipass shell target

sudo apt update
sudo apt install -y openscap-scanner
apt search ssg-                       # confirm the content package name for your release
sudo apt install -y ssg-debderived    # ships the Debian/Ubuntu datastreams

ls /usr/share/xml/scap/ssg/content/   # find your datastream file

# List the profiles the datastream offers
oscap info /usr/share/xml/scap/ssg/content/ssg-ubuntu2204-ds.xml

# Scan, and produce a human-readable report
sudo oscap xccdf eval \
  --profile <profile-id-from-above> \
  --results results.xml \
  --report report.html \
  /usr/share/xml/scap/ssg/content/ssg-ubuntu2204-ds.xml
```

> ⚠️ Package and datastream names drift between Ubuntu releases. If `ssg-debderived` isn't found, run `apt search ssg-` and use what your release actually ships, or pull a release from the [ComplianceAsCode/content](https://github.com/ComplianceAsCode/content/releases) GitHub releases. Don't get stuck here — the concept matters more than the package name.

- [ ] Open `report.html` in a browser (`multipass transfer target:report.html .`) and read it properly — this is what an auditor sees
- [ ] Find three failures your Ansible role should have caught. Add them to the role.
- [ ] Generate the **remediation** output and read it before running it:
```bash
sudo oscap xccdf generate fix --profile <profile-id> --fix-type ansible results.xml > remediate.yml
```
- [ ] Compare that generated playbook against your hand-written role. Note what it does better — and what it does dangerously
- [ ] Re-scan after remediation and record the score delta

> 💡 **Never run generated remediation blind.** SCAP fixes are written for a generic host and will happily disable something your application needs. Read, then apply selectively. Saying this in an interview signals real operational experience.

---

## 📖 Module C — Compliance at scale & in the pipeline (~2 hrs)

Running one scan on one box is a lab. The chapter is about doing it across a fleet, continuously.

### Concepts
- [ ] Scanning **many hosts**: Inspec against an Ansible inventory, results aggregated centrally
- [ ] **Continuous** compliance — scheduled scans, trend over time, not a point-in-time audit
- [ ] Compliance as a **pipeline gate** vs a **scheduled report** — and when each is appropriate (hint: gating on a flaky detective control will get you overruled)
- [ ] Mapping one control set to **multiple frameworks** (a single SSH control satisfies CIS, PCI-DSS and ISO 27001 clauses) — write the mapping once, report against all three
- [ ] Evidence retention: dated, immutable, attributable

### Hands-on
- [ ] Run your Inspec profile against **two** hosts in one command via an Ansible-style inventory
- [ ] Add a **compliance stage** to the pipeline in [project-01](../projects/project-01-secure-cicd.md): build image → run Inspec against the running container → fail on `impact >= 0.7` failures
- [ ] Feed `results.json` into **DefectDojo** so compliance findings live beside your SAST/SCA/DAST findings
- [ ] Extend the **controls matrix** in [architect/secure-sdlc.md](../architect/secure-sdlc.md): one row per control, columns for CIS / NIST SSDF / the Inspec control ID that proves it

---

## 📄 Deliverable

- [ ] A public `compliance-baseline` repo containing:
  - An Inspec/CINC profile covering every control your Ansible role applies
  - **Before/after run output** — the same profile failing on a fresh host and passing on a hardened one
  - One dated, justified **waiver**
  - An OpenSCAP `report.html` for the same host, with the score
  - A **controls matrix**: control → CIS ID → NIST SSDF practice → the Inspec control that proves it
- [ ] The pipeline stage that runs it, wired into [project-01](../projects/project-01-secure-cicd.md)

> 🎯 **What this proves in an interview:** that you can produce *evidence*, not assurances. In a regulated market this is the single most transferable skill on the roadmap — every bank, insurer and utility in Chile has an auditor who wants exactly this artifact, and most engineers cannot produce it.

---

## 🧰 Tools
- [ ] `cinc-auditor` (or `inspec` — see the licensing note) · `oscap` (inside the Linux VM)
- [ ] DefectDojo (stood up in [project-01](../projects/project-01-secure-cicd.md)) for aggregating the JSON output

## 📚 Resources

| Resource | Type | Priority |
|---|---|---|
| [InSpec documentation — resources reference](https://docs.chef.io/inspec/resources/) | Docs | ⭐⭐⭐ |
| [CINC Auditor](https://cinc.sh/start/auditor/) — the licence-clean build | Docs | ⭐⭐⭐ |
| [ComplianceAsCode/content](https://github.com/ComplianceAsCode/content) — the SSG source | Repo | ⭐⭐⭐ |
| [OpenSCAP user manual](https://www.open-scap.org/resources/documentation/) | Docs | ⭐⭐ |
| [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) (free, registration) | Standard | ⭐⭐ |
| [NIST SP 800-53 → CIS mappings](https://www.cisecurity.org/controls/cis-controls-navigator) | Reference | ⭐ |

---

## ✅ Track completion signals

- [ ] A profile that fails on an unhardened host and passes on a hardened one — **with both outputs saved**
- [ ] An OpenSCAP HTML report you can hand to a non-engineer
- [ ] Compliance running as a stage in your pipeline, findings landing in DefectDojo
- [ ] You can explain preventive vs detective vs corrective controls with an example of each from your own repos

---

_← [Configuration Management](config-management.md) · [Tracks](README.md) | [Back to README](../README.md)_
