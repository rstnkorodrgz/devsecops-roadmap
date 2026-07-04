# Phase 2 — Kubernetes Core (CKA)

> **Duration:** Months 4–6
> **Target Certification:** CKA — Certified Kubernetes Administrator. **Book the exam at the start of the phase.** A passed, active CKA is a **registration prerequisite for CKS** (Phase 3).
> **Quarterly artifact:** Cluster build & troubleshooting runbook, published in this repo
> **Accelerated by:** senior DevOps experience — most domains are review; budget the time for gaps and exam-speed practice, not relearning basics.

---

## 🗓️ Month 4 — Cluster Architecture & Workloads

### Concepts (current CKA curriculum)
- [ ] Cluster architecture & lifecycle — `kubeadm` install, upgrades, etcd backup/restore
- [ ] Workloads & scheduling — Deployments, rolling updates/rollbacks, taints/tolerations, affinity
- [ ] **Helm & Kustomize** — both are in the current CKA curriculum
- [ ] RBAC fundamentals — Roles, Bindings, ServiceAccounts (deepened in Phase 3)

### Hands-on Labs
- [ ] Build a multi-node cluster with `kubeadm` (UTM/multipass VMs, or a cheap cloud VM)
  - ⚠️ CKA is **vanilla Kubernetes** — practice on kubeadm, not AKS. AKS is for Phase 4.
- [ ] Perform an etcd backup and restore
- [ ] Upgrade the cluster one minor version with `kubeadm`
- [ ] Deploy an app via Helm, then the same via Kustomize overlays

---

## 🗓️ Month 5 — Networking, Storage & Troubleshooting

### Concepts
- [ ] Services & networking — Service types, Ingress, **Gateway API**, CoreDNS
- [ ] Storage — PV/PVC, StorageClasses, dynamic provisioning, access modes
- [ ] Troubleshooting — nodes, control plane, and application failures (**the highest-weight domain**)

### Hands-on Labs
- [ ] Break the cluster on purpose (kubelet down, wrong CNI config, expired/bad cert, full disk) and repair it under time pressure
- [ ] Debug a failing app end-to-end: events → logs → probes → resources → DNS
- [ ] Expose a service through Ingress and through Gateway API; compare

---

## 🗓️ Month 6 — Exam & Artifact

### Exam Prep
- [ ] Complete killer.sh CKA simulator — both sessions
- [ ] Time yourself: full mock scenarios under exam conditions (2 h, performance-based)
- [ ] ✅ **PASS CKA — Certified Kubernetes Administrator**

### 📦 Quarterly artifact (Q2)
- [ ] **Cluster build & troubleshooting runbook** (public): kubeadm build steps, etcd backup/restore procedure, upgrade procedure, and a failure-mode catalog (symptom → diagnosis → fix) from your Month 5 break/fix labs

---

## 🧰 Tools
- [ ] `kubectl` · `kind` · `helm` · `kustomize` · `k9s` · `kubectx`

## 📚 Resources
- KodeKloud CKA Course (Mumshad Mannambeth)
- Killer.sh CKA Simulator (included with exam purchase)
- kubernetes.io docs — allowed in the exam; learn to navigate them fast

---

_← [Phase 1](phase-1-terraform.md) | [Back to README](../README.md) | [Phase 3 (CKS) →](phase-3-cks.md)_
