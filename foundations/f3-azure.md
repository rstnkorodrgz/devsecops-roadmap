# F3 — Cloud You Can Build In ★

> **Months 5–8 · ~110 hrs · the pivot point of the whole track**
> **Target certification:** **AZ-104 — Azure Administrator Associate.** Book it at the start of month 6, per the roadmap's [execution rule #1](../README.md#execution-rules).
> **Exit signal:** AZ-104 passed **and** an Azure environment you built yourself, not one you reviewed.
> **This is where you start applying for Cloud Security Engineer roles.**

---

## 🎯 Why this cert, and why now

The gap in your profile is not security knowledge — you have Security+, the Lead title, and daily exposure to cloud security decisions. Another security certificate proves something you have already proven.

**AZ-104 proves the thing you currently cannot claim: that you build and operate cloud infrastructure.** It is performance-oriented, it is the standard baseline expectation for Cloud Security Engineer roles in Azure-heavy markets, and Chile is an Azure-heavy market.

It also front-loads everything [Phase 1](../phases/phase-1-terraform.md) needs. Terraform is much easier when you already know what a VNet, an NSG, a managed identity and an RBAC assignment actually are — because Terraform is just a way of describing them.

> 💡 **If the material feels like a wall in the first fortnight**, drop to **AZ-900** for three weeks and come back. That is a sequencing correction, not a failure.

> 💸 **Money:** set a **budget alert in week one** — before your first resource. Use free-tier services where they exist, and `az group delete` after every session. The roadmap's [cost note](../README.md) applies double here, because you will be creating and destroying constantly.

---

## 🗓️ Month 5–6 — Core Azure, by hand

Do everything in the **portal first**, then repeat it in the **CLI**. The portal builds intuition; the CLI builds the muscle that becomes Terraform.

### Concepts
- [ ] **Tenants, subscriptions, management groups, resource groups** — the hierarchy everything else hangs off
- [ ] **Entra ID** — users, groups, service principals, **managed identities**, app registrations
- [ ] **RBAC** — roles, scope inheritance, and why `Owner` at subscription scope is the finding you keep writing
- [ ] **Virtual networks** — subnets, NSGs, route tables, peering, private endpoints *(your networking background is a real advantage here — lean on it)*
- [ ] **Compute** — VMs, scale sets, availability, disks, images
- [ ] **Storage** — accounts, blob containers, access tiers, SAS tokens, **public access settings**
- [ ] **Key Vault** — secrets, keys, certificates, access policies vs RBAC mode
- [ ] **Monitoring** — Azure Monitor, Log Analytics workspaces, KQL basics, alerts
- [ ] **Governance** — Azure Policy, tags, locks, cost management

### Hands-on
- [ ] Create a resource group, a VNet with two subnets, and an NSG. Then **delete it all and do it again from the CLI**
- [ ] Deploy a Linux VM, SSH in, install the [F2](f2-linux-containers.md) app on it, reach it from the internet
- [ ] Lock it down: NSG allowing only your IP, no public SSH from anywhere else
- [ ] Create a storage account, block public blob access, generate a scoped SAS token, prove it expires
- [ ] Put a secret in Key Vault, then **read it from the VM using a managed identity** — no credentials in code. This is the pattern the rest of the roadmap depends on
- [ ] Assign RBAC at three scopes and observe inheritance
- [ ] Write a KQL query in Log Analytics that finds failed sign-ins
- [ ] Apply an Azure Policy that denies public blob access, then try to violate it

> 🎯 **Month-6 rep (ship it):** extend the [F1](f1-code.md) ASPM ranker to pull real data from Azure using `azure-identity` + the SDK — list storage accounts with public access, or role assignments unused for 90 days. **You are now writing security automation against real cloud infrastructure**, which is the job description you are applying for.

---

## 🗓️ Month 7 — Operate, then automate

### Concepts
- [ ] Backup and recovery — Recovery Services vaults, restore testing
- [ ] Load balancing — Azure Load Balancer vs Application Gateway (and where a WAF sits)
- [ ] Networking depth — DNS zones, service endpoints vs private endpoints, hub-spoke topology
- [ ] Containers on Azure — Container Instances, Container Registry, and what AKS is *(depth comes in [Phase 2](../phases/phase-2-cka.md))*
- [ ] **ARM/Bicep** — read a template, understand declarative infrastructure. **This is the bridge to Terraform**
- [ ] Defender for Cloud — Secure Score and recommendations *(you likely already read these outputs; now generate them)*

### Hands-on
- [ ] Build a **hub-spoke** VNet topology with peering and a firewall subnet
- [ ] Push a container image to Azure Container Registry, run it in Container Instances
- [ ] Deploy the same resource group with a **Bicep template** you wrote. Delete it. Redeploy. Notice it is identical every time — that is the whole idea behind [Phase 1](../phases/phase-1-terraform.md)
- [ ] Enable Defender for Cloud on a subscription; read the Secure Score and fix three recommendations
- [ ] Break something and diagnose it from Azure Monitor rather than the portal blade

### 🔥 Break/fix
- [ ] Misconfigure an NSG so the app is unreachable; diagnose it with **Network Watcher**, not by guessing
- [ ] Delete a role assignment your app needs; find the permission error in the logs
- [ ] Let a managed identity's access expire; trace the failure end to end

---

## 🗓️ Month 8 — Exam and the job search

### Exam prep
- [ ] Complete the [Microsoft Learn AZ-104 path](https://learn.microsoft.com/en-us/credentials/certifications/azure-administrator/) end to end (free, official)
- [ ] Do the labs, not just the reading. **AZ-104 tests whether you have done things**
- [ ] Two full practice exams at 85%+ before you sit it
- [ ] ✅ **PASS AZ-104**

### 📦 F3 artifact
- [ ] A public repo: **a small but complete Azure environment** — VNet, VM or container, Key Vault with managed identity, NSGs, a Bicep template that builds all of it, and a README with an architecture diagram
- [ ] A `SECURITY.md` explaining the controls you applied **and the ones you deliberately did not, with reasoning**. This is where your risk background makes your artifact better than a bootcamp graduate's — most people cannot articulate residual risk, and you do it professionally

### 🎯 Start applying
This is the month it flips. You can now honestly say:

> *"I hold a DevSecOps Lead role focused on risk and assurance, I'm AZ-104 certified, and here is an Azure environment I built with the controls documented and the residual risk stated."*

- [ ] Rewrite your CV around **building**, with the F1–F3 artifacts linked
- [ ] Update LinkedIn — AZ-104 plus the repos
- [ ] Apply for **Cloud Security Engineer** roles. Also look at Cloud Engineer and Platform Engineer with a security slant — the same skills, a wider funnel
- [ ] **You may now take hands-on technical screens.** The [sequencing rule](README.md#-the-risk-you-need-to-manage) is lifted

---

## 📄 Exit criteria

- [ ] **AZ-104 passed**
- [ ] You can build a working Azure environment from the CLI without a tutorial
- [ ] You understand managed identity well enough to explain why it beats a stored secret
- [ ] You have written and deployed a Bicep template
- [ ] The F3 artifact repo is public, diagrammed and documented
- [ ] Applications are out

> 🎯 **What this proves in an interview:** that the title and the hands now match. This is the phase that closes the gap between what your CV claims and what you can demonstrate — and after it, your risk-and-assurance background stops being a liability to explain away and becomes the thing that makes you unusual.

---

## 📚 Resources

| Resource | Type | Priority |
|---|---|---|
| [Microsoft Learn — AZ-104 path](https://learn.microsoft.com/en-us/credentials/certifications/azure-administrator/) (free, official) | Course | ⭐⭐⭐ |
| [John Savill — AZ-104 Study Cram + Master Classes](https://www.youtube.com/@NTFAQGuy) (free) | Video | ⭐⭐⭐ |
| [Microsoft Learn Sandbox](https://learn.microsoft.com/en-us/training/) — free labs, no subscription needed | Lab | ⭐⭐⭐ |
| [Azure CLI reference](https://learn.microsoft.com/en-us/cli/azure/) | Docs | ⭐⭐⭐ |
| [Bicep documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/) | Docs | ⭐⭐ |
| MeasureUp or Whizlabs AZ-104 practice exams | Practice | ⭐⭐ |
| [Azure Architecture Center](https://learn.microsoft.com/en-us/azure/architecture/) | Reference | ⭐ |

---

_← [F2 — Systems you can operate](f2-linux-containers.md) | [F4 — Your first pipeline →](f4-first-pipeline.md)_
