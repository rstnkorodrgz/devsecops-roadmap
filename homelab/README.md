# 🛡️ Hybrid Multi-Arch DevSecOps Homelab (Lenovo ThinkCentre Edition)

An enterprise-grade, micro-segmented hybrid-architecture homelab designed for DevSecOps skill validation and public portfolio construction. This directory holds the infrastructure blueprints for a localized private cloud aligned with **CIS Controls v8** and **zero-trust principles (NIST SP 800-207)**.

> **Roadmap tie-in:** this lab is the physical substrate for [Phase 2–3 Kubernetes labs](../phases/), the [API track](../api-track/), and Sentinel log forwarding practice for [Phase 4 (SC-500)](../phases/).

---

## 🗺️ Target Architecture

```
                         Home Router ── Internet
                              │
                              │ Port 8 · WAN transit (VLAN 99)
                 ┌────────────┴─────────────┐
                 │   TP-Link TL-SG108PE     │  L2 · 4× PoE+ · 64 W budget
                 └─┬──────┬──────┬──────┬───┘
          Port 5   │      │      │      │
          trunk    │   P1 │   P2 │   P3 │
       (10,20,30,  │  PoE+│  PoE+│      │
        40,99)     │      │      │      │
        ┌──────────┴──┐ ┌─┴──┐ ┌─┴──┐ ┌─┴─────────┐
        │ Lenovo M720q│ │Pi 5│ │Pi 5│ │ Pi 3B     │
        │ Proxmox VE  │ │ #1 │ │ #2 │ │ sentinel  │
        │ + OPNsense  │ │    k3s    │ │ DNS·NTP·  │
        │   gateway VM│ │  cluster  │ │ logs→Sent.│
        └─────────────┘ └────┴──────┘ └───────────┘
```

**Routing:** the TL-SG108PE is Layer-2 only. Inter-VLAN routing and firewalling run on an **OPNsense VM** on Proxmox (router-on-a-stick over the Port 5 trunk). Every VLAN's `.1` gateway lives on OPNsense, with default-deny rules between segments.

### VLAN Plan

| VLAN | Name | Subnet | Purpose |
| :--- | :--- | :--- | :--- |
| 10 | MGMT | `10.0.10.0/24` | Proxmox UI, switch mgmt, OPNsense UI, admin laptop |
| 20 | SEC | `10.0.20.0/24` | Core security services: DNS (query-logged), NTP, log aggregation |
| 30 | LAB | `10.0.30.0/24` | Vulnerable targets & attack range — **isolated, no egress by default** |
| 40 | APPS | `10.0.40.0/24` | Pi 5 k3s cluster, production-style workloads |
| 99 | WAN | home LAN (DHCP) | OPNsense WAN uplink transit to home router |

### Node Roles

| Node | Arch | Role |
| :--- | :--- | :--- |
| Lenovo M720q (i3-9100T, 12GB) | x86_64 | Proxmox VE hypervisor: OPNsense gateway, CI runners, SIEM/lab VMs |
| 2× Raspberry Pi 5 (8GB) | arm64 | k3s cluster on NVMe — cloud-native runtime layer |
| Raspberry Pi 3B (1GB) | arm64 | **Security Services Sentinel** (`10.0.20.10`): Pi-hole + Unbound DNS with query logging, chrony NTP source, Fluent Bit log aggregation → **Microsoft Sentinel** via the Azure Logs Ingestion API. Three lightweight services — nothing heavier fits in 1GB |

### Design Decisions

* **Gateway = OPNsense VM, not the Pi 3B.** The Pi 3B has a single 100 Mbps NIC — as a router-on-a-stick it would cap inter-VLAN traffic at ~50 Mbps. OPNsense on the M720q trunk routes at wire speed and provides the default-deny policy engine that makes the zero-trust claim demonstrable.
* **Core services live out-of-band on the Pi 3B.** DNS, NTP, and the log pipeline sit on dedicated hardware, so they survive every hypervisor rebuild — and a lab hypervisor gets rebuilt often. Their traffic volumes are trivial, so the 100 Mbps NIC is irrelevant in this role.
* **DNS query logs are the lab's richest telemetry.** Pi-hole logs from every segment flow into Microsoft Sentinel — real hunting material for KQL practice (Phase 4 / SC-500).

---

## 📊 Bill of Materials (BOM) & Sourcing Matrix

The total hardware budget target is **$700.00 USD (~$650.000 CLP)**. Sourcing leverages local Chilean channels for the main compute node to skip international heavy-freight costs, combined with Amazon global logistics for specialized cloud-native processing layers.

> ⚠️ **Import costs:** the Amazon subtotal (~$373 USD) will attract ~19% IVA plus courier/customs fees on arrival in Chile — budget an extra **$75–100 USD** of landed cost. If that breaks the ceiling, the cosmetic tier (patch panel, keystones, slim cables ≈ $77) is fully deferrable without touching the architecture.

### 1. Pre-Existing Assets (Current Inventory)

*   **2×** Raspberry Pi 5 (8GB RAM variant)
*   **2×** M.2 PCIe NVMe SSDs (256GB capacity tier) — k3s node storage
*   **1×** Raspberry Pi 3 Model B host — ⚠️ *no PoE header (that arrived with the 3B+); powered via micro-USB PSU*

### 2. Sourcing Requirements & Retail Map

| Component | Sourcing Node | Target Specification / Model | Est. USD | Est. CLP |
| :--- | :--- | :--- | :--- | :--- |
| **Main Compute Engine** | Local (Chile) | [Tecnoboss Chile — Lenovo ThinkCentre M720q](https://tecnoboss.cl/pc-lenovo-thinkcentre-m720q-i3-9100t-12-gb-ram-512-gb-ssd) (i3-9100T / 4C-4T / 12GB / 512GB) | ~$250.00 | ~$237.650 |
| **Server Support Rail** | Local (Chile) | [Diartek — Linkmade 1U 10" Vented Support Shelf](https://diartek.cl) (`RB101-2L`) | ~$12.00 | ~$11.000 |
| **System Enclosure** | Global (Amazon) | DeskPi RackMate T1 — 10-inch **4U** open rack frame | ~$39.99 | ~$37.500 |
| **Core Switching Fabric** | Global (Amazon) | TP-Link TL-SG108PE **V3 or later** — 8× GbE Easy Smart Managed, 4× PoE+ 802.3at @ 64W — ⚠️ *V2 is 802.3af-only and can't power the Pi 5 HATs; confirm "Deliver to Chile" on the listing before checkout* | ~$49.99 | ~$47.000 |
| **Cluster Multi-HATs** | Global (Amazon) | [GeeekPi P33 M.2 NVMe M-Key + PoE+ HAT w/ official active cooler](https://www.amazon.com/dp/B0D8JC3MXQ) (×2) — 802.3at, 5.1V/4.5A, fits 2230–2280 drives — ⚠️ *verify HAT stack height clears the UCTRONICS 1U mount* | ~$75.98 | ~$71.000 |
| **Interconnect Cabling** | Global (Amazon) | Rapink Cat6 2ft slim orange patch cables (24-pack) | ~$19.99 | ~$18.500 |
| **Patch Panel Inserts** | Global (Amazon) | GeeekPi Cat6 RJ45 multicolor keystone jacks (12-pack) | ~$11.99 | ~$11.000 |
| **Compute Upgrade (Disk)** | Global (Amazon) | Crucial P3 1TB NVMe **or** Crucial MX500 1TB 2.5" SATA — *see slot check below* | ~$60.00 | ~$56.000 |
| **Cluster Faceplate** | Global (Amazon) | UCTRONICS 10-inch 1U multi-Pi horizontal rackmount | ~$45.00 | ~$42.000 |
| **Sentinel Log Storage** | Global (Amazon) | SanDisk 256GB Max Endurance microSDXC | ~$25.00 | ~$23.000 |
| **Power & Termination** | Global (Amazon) | 10" 1U PDU strip + 10-inch unloaded keystone patch panel bundle | ~$45.00 | ~$42.000 |
| **TOTAL TARGET** | **Hybrid Sourcing** | **Fully hardened multi-arch cloud-native sandbox** | **~$634.94** | **~$593.650** |

> ⚠️ **Pre-purchase slot check (M720q):** the M720q has **one** M.2 NVMe slot plus **one** 2.5" SATA bay. If the included 512GB SSD occupies the M.2 slot (most common config), there is no free M.2 slot — buy the **MX500 1TB SATA** variant instead (plus the 2.5" drive caddy/cable kit if not included, ~$8). Confirm with Tecnoboss which slot the 512GB ships in before ordering the drive.

*Note: since the Lenovo ships with 12GB RAM, the 32GB SODIMM kit (2×16GB DDR4-2666, ~$55) is deferred to stay under the $700 ceiling. It is the **first planned upgrade** — 12GB is tight once OPNsense + a SIEM VM + CI runners coexist. Remaining cushion: ~$65.06 USD (before import fees).*

---

## ⏭️ Next Step

Proceed to the [Day-1 Infrastructure Initialization Runbook](INITIAL_SETUP.md).
