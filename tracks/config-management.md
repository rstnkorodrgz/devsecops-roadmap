# Track — Configuration Management & Golden Images (Background)

> **Status: gap-closing track — sequenced, ~8 hrs.** Added in v2.2 to close **CDP Chapter 7**, the largest structural gap in this roadmap.
> **Why it exists:** [Phase 1](../phases/phase-1-terraform.md) teaches *provisioning* — creating cloud resources with Terraform. It never teaches *configuration management* — what happens **inside** the box once it exists. That is a different tool category, and interviewers ask about it.
> **Primary outcome:** an Ansible role that hardens a Linux host, baked into a **golden image**, with the hardening **proven** by a scan.
> **Feeds:** [compliance-as-code.md](compliance-as-code.md) (the Inspec profile asserts what this role applied) and [Pillar D](../pillars/pillar-d-architecture.md).
> **Assumes zero Ansible experience.** Every command below is meant to be typed.

---

## 🧭 Why this is not Terraform

The single most common interview question on this topic. Be able to answer it in two sentences.

| | **Terraform** ([Phase 1](../phases/phase-1-terraform.md)) | **Ansible** (this track) |
|---|---|---|
| Question it answers | "Does this VM *exist*?" | "Is this VM *configured correctly*?" |
| Model | Declarative desired state, reconciled against a cloud API | Task list executed in order against an OS |
| State | Keeps a state file, knows what it owns | Stateless — re-reads the host every run |
| Transport | Cloud provider API | **Push** over SSH (agentless) |
| Failure mode | Drift from the state file | Drift from the last playbook run |

- [ ] Understand **push vs pull** configuration management — Ansible pushes over SSH; Puppet/Chef agents pull from a server on a schedule
- [ ] Understand why "agentless" matters — no bootstrap problem, no agent to patch, but no continuous enforcement either
- [ ] Be able to say when you'd use **both**: Terraform creates the VM, Ansible configures it, or Terraform bakes an Ansible-built golden image

---

## 🧪 Module 0 — Get a lab target (do this first)

You cannot practise Ansible against your Mac. You need a throwaway Linux host you can break and rebuild. **Multipass** is the lowest-friction option — it works on both Intel and Apple Silicon, it's free, and a VM is one command.

```bash
brew install --cask multipass

# Launch a target VM (2 GB is enough; you have 8 GB total — run one at a time)
multipass launch 22.04 --name target --memory 2G --disk 10G

multipass list                      # note the IP
multipass exec target -- hostname   # prove it works
```

Give Ansible SSH access to it:

```bash
# Reuse your existing key, or make a lab-only one
ssh-keygen -t ed25519 -f ~/.ssh/lab_ed25519 -N ""

multipass exec target -- bash -c \
  "mkdir -p ~/.ssh && echo '$(cat ~/.ssh/lab_ed25519.pub)' >> ~/.ssh/authorized_keys"

TARGET_IP=$(multipass info target --format csv | tail -1 | cut -d, -f3)
ssh -i ~/.ssh/lab_ed25519 ubuntu@$TARGET_IP hostname   # must succeed before continuing
```

- [ ] `multipass` installed and a `target` VM running
- [ ] Key-based SSH into the VM works **without a password prompt**
- [ ] You know how to reset: `multipass delete target && multipass purge && multipass launch ...`

> 💡 **Once the [homelab](../homelab/README.md) exists**, move these labs onto a Proxmox VM instead — same commands, real hardware, and the segmentation work becomes testable from Ansible.

---

## 📖 Module A — Ansible from zero (~3 hrs)

### Concepts
- [ ] **Inventory** — the list of hosts, and how groups let one playbook target many
- [ ] **Ad-hoc commands** — `ansible -m ping`, for when you don't need a playbook
- [ ] **Modules** — the unit of work (`apt`, `copy`, `template`, `service`, `user`, `lineinfile`)
- [ ] **Tasks, plays, playbooks** — and why order matters (unlike Terraform's graph)
- [ ] **Idempotency** — the central idea: running twice changes nothing the second time
- [ ] **Handlers** — deferred actions triggered by `notify` (restart sshd once, not five times)
- [ ] **Variables and precedence** — group_vars, host_vars, `--extra-vars`, and the precedence order that catches everyone
- [ ] **Roles** — the reusable unit: `tasks/`, `handlers/`, `templates/`, `defaults/`, `meta/`
- [ ] **Ansible Vault** — encrypting secrets at rest in the repo (`ansible-vault encrypt_string`)

### Hands-on
```bash
pip3 install ansible ansible-lint     # or: brew install ansible ansible-lint
mkdir -p ~/labs/ansible && cd ~/labs/ansible

cat > inventory.ini <<INV
[lab]
target ansible_host=REPLACE_WITH_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/lab_ed25519
INV

ansible -i inventory.ini lab -m ping                    # first contact
ansible -i inventory.ini lab -m setup | head -40        # facts — see what Ansible knows
ansible -i inventory.ini lab -a "uptime"                # ad-hoc command
```

- [ ] Get a green `pong` from `-m ping`
- [ ] Read the `setup` facts output — find `ansible_distribution` and `ansible_default_ipv4`
- [ ] Write a 3-task playbook: install `htop`, create a user, drop a templated `/etc/motd`
- [ ] **Run it twice.** Confirm the second run reports `changed=0` — that is idempotency, and it is the whole point
- [ ] Break idempotency deliberately (use `shell:` with no `creates:`) and watch `changed=1` every run. Fix it. This is the lesson.
- [ ] Convert the playbook into a **role** with `ansible-galaxy init hardening`
- [ ] Encrypt one variable with `ansible-vault encrypt_string` and use it in the play
- [ ] Run `ansible-lint` against your role and fix every finding

---

## 📖 Module B — A real hardening role (~2.5 hrs)

This is the part that maps to the job. You are automating what you used to do by hand on a firewall or switch.

### Controls to implement
- [ ] **SSH** — `PermitRootLogin no`, `PasswordAuthentication no`, `X11Forwarding no`, modern ciphers/KEX only
- [ ] **Kernel** via `sysctl` — disable IP forwarding, ignore ICMP redirects, enable `kernel.randomize_va_space`
- [ ] **Auditd** — installed, enabled, with rules for `/etc/passwd`, `/etc/shadow`, `/etc/sudoers`
- [ ] **Patching** — `unattended-upgrades` configured for security updates
- [ ] **Accounts** — no empty passwords, password ageing policy, a locked-down service user
- [ ] **Filesystem** — `noexec,nosuid,nodev` on `/tmp`, permissions on `/etc/shadow`
- [ ] **Time** — chrony installed and synced (matters for every log you'll ever correlate)

### Hands-on
- [ ] Write **at least 6 of these tasks yourself** before looking at anything pre-built — you need to feel the module syntax
- [ ] Use a **handler** to restart `sshd`, and prove it only fires when the config actually changed
- [ ] Use `ansible.builtin.template` with a Jinja2 `sshd_config.j2` rather than `lineinfile` — templates are how real roles do it
- [ ] Then read the **`devsec.hardening`** collection and compare it to yours. Note every control you missed.
- [ ] Add `--check --diff` to your run — this is **drift detection**, and it's the same idea as `terraform plan`
- [ ] Test the role with **Molecule** (Docker driver) so it verifies in CI without a VM

> ⚠️ **Lock yourself out at least once.** Apply `PasswordAuthentication no` before installing your key, get locked out, and recover with `multipass shell target`. Every engineer who runs hardening in production has done this — do it here instead.

---

## 📖 Module C — Golden images (~1.5 hrs)

A golden image is a machine image built **once**, hardened, scanned, versioned, and then deployed many times. It moves hardening from deploy-time to build-time — which means it can be gated in a pipeline.

### Concepts
- [ ] Why golden images beat configuring at boot: faster, deterministic, **scannable before deployment**
- [ ] Image lifecycle: build → scan → sign/version → publish → **expire**. An unexpired golden image is a liability
- [ ] The patching question: do you patch running hosts, or rebuild the image and redeploy? (Immutable infrastructure)

### Hands-on — the CDP-faithful path (local, free)
- [ ] Build a hardened **container** image by running your Ansible role at build time, then scan it:
```bash
trivy image --severity HIGH,CRITICAL hardened-base:v1
docker history hardened-base:v1        # inspect what each layer added
```
- [ ] Compare `trivy image` CVE counts against the un-hardened base — put the numbers in your README

### Stretch — the Azure path (costs money, ties to [Phase 1](../phases/phase-1-terraform.md))
- [ ] Build an Ubuntu image with **Packer** + your Ansible role as the provisioner
- [ ] Publish it to an **Azure Compute Gallery**, versioned
- [ ] Reference the gallery image from the Terraform AKS node pool or VM module
- [ ] Wire the build into GitHub Actions so a new image is produced on every role change

---

## 📖 Module D — Put it in a pipeline (~1 hr)

- [ ] `ansible-lint` as a **required** CI gate
- [ ] `ansible-playbook --check --diff` on a schedule → drift detection report
- [ ] Molecule converge + verify on every PR to the role
- [ ] Fail the build if the golden image scan returns HIGH/CRITICAL

---

## 📄 Deliverable

- [ ] A public `ansible-hardening` repo containing:
  - The role, linted clean, with Molecule tests that pass in CI
  - A **before/after CVE count** and a before/after config diff
  - The golden image build (Dockerfile or Packer template)
  - A `README.md` stating which CIS controls the role implements — and **which it deliberately does not**, and why
- [ ] Cross-link it from [compliance-as-code.md](compliance-as-code.md), where you'll write the profile that proves it

> 🎯 **What this proves in an interview:** that you can automate OS-level security across a fleet, not just click through a portal — and that you know the difference between *applying* a control and *proving* it. That second half is what separates a DevSecOps engineer from a sysadmin.

---

## 🧰 Tools
- [ ] `multipass` (lab VMs) · `ansible` · `ansible-lint` · `molecule` (+ `molecule-plugins[docker]`)
- [ ] `packer` (golden images — stretch) · `trivy` (already installed)

## 📚 Resources

| Resource | Type | Priority |
|---|---|---|
| [Ansible documentation — Getting Started](https://docs.ansible.com/ansible/latest/getting_started/index.html) (free) | Docs | ⭐⭐⭐ |
| *Ansible for DevOps* — Jeff Geerling (+ his free YouTube series) | Book | ⭐⭐⭐ |
| [`devsec.hardening` collection](https://galaxy.ansible.com/ui/repo/published/devsec/hardening/) | Reference role | ⭐⭐⭐ |
| [Molecule documentation](https://ansible.readthedocs.io/projects/molecule/) | Docs | ⭐⭐ |
| [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) (free, registration) | Standard | ⭐⭐ |
| [Packer — Azure builder](https://developer.hashicorp.com/packer/integrations/hashicorp/azure) | Docs | ⭐ _(stretch)_ |

---

## ✅ Track completion signals

- [ ] A hardening role that is **idempotent** — second run reports `changed=0`
- [ ] Molecule tests green in CI
- [ ] A golden image built from the role, scanned, with the CVE delta documented
- [ ] You can explain push vs pull, and Terraform vs Ansible, without hedging

---

_← [Tracks](README.md) · [Compliance as Code →](compliance-as-code.md) | [Back to README](../README.md)_
