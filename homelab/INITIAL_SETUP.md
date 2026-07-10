# 🛠️ Day-1 Infrastructure Initialization Runbook

This technical runbook transforms bare-metal components into a secured, micro-segmented compute infrastructure. Follow the execution tracks sequentially — later tracks depend on earlier ones. Network design (VLAN plan, subnets, node roles) lives in the [README](README.md).

---

## ✅ Track 0: Pre-Flight Checks

Before assembly day, confirm:

- [ ] **M720q storage slots** — confirmed with seller whether the 512GB SSD is M.2 or 2.5" SATA, and bought the matching 1TB drive (see BOM slot check).
- [ ] **Pi 5 EEPROM current** — boot each Pi 5 once from any SD card and run `sudo rpi-eeprom-update -a`; NVMe boot needs a recent bootloader.
- [ ] **Downloads staged** — Proxmox VE 8.x ISO, OPNsense 24.x ISO (amd64/dvd), Raspberry Pi Imager.
- [ ] **Micro-USB PSU on hand** for the Pi 3B (it has no PoE header).
- [ ] **Switch credentials ready** — the TL-SG108PE ships with `admin`/`admin`; rotate it on first login, before the switch touches the rest of the network. Confirm the unit is **hardware V3 or later** (V2 lacks 802.3at PoE+).

---

## 🔌 Track 1: Physical Assembly & PoE Configuration

1. Assemble the **DeskPi RackMate T1** (4U) frame. Mount the **10-inch keystone patch panel** at **U1**, populated with the multicolor **GeeekPi Cat6 keystones**.
2. Mount the **UCTRONICS 1U faceplate** at **U2**, housing the two Raspberry Pi 5 units (each on a **GeeekPi P33 Multi-HAT** with the existing 256GB NVMe drives installed) plus the Pi 3B.
3. Open the **Lenovo M720q** case (rear thumbscrew). Install the **1TB drive** — into the free M.2 slot *or* the 2.5" SATA bay, per your Track 0 finding. Slide the host onto the **Linkmade 1U vented tray** at **U3**.
4. Mount the **1U PDU strip** at **U4** (or rear-mount it if the bracket allows, freeing U4 for future expansion).
5. Place the **TP-Link TL-SG108PE** behind the frame. Patch the front-panel keystones to the switch with the **2ft Rapink orange cables**, looping them around the chassis rail. Run one cable from **Port 8** to the home router.
6. Power: Pi 5s draw over PoE+ — they **must** land on ports 1–4 (the SG108PE's only PoE+ ports); the port map keeps them on 1–2. Pi 3B and the Lenovo plug into the PDU.

---

## 💽 Track 2: Storage Flash & Base OS Bootstrapping

### A. Raspberry Pi Sentinel Node (Pi 3B)

1. Slot the **SanDisk 256GB Max Endurance microSD** into your workstation.
2. Open **Raspberry Pi Imager**, select **Raspberry Pi OS Lite (64-bit)**.
3. In advanced options (`Ctrl+Shift+X`): enable SSH (**key-based only**), set username `devsecops-admin`, inject your public SSH key. Flash.
4. Flash only for now — this node becomes the **Security Services Sentinel** (DNS, NTP, log aggregation) in **Track 6**, once the gateway provides it internet access. Its static identity: `10.0.20.10/24`, gateway `10.0.20.1`.

### B. Raspberry Pi 5 k3s Nodes

1. Flash **Raspberry Pi OS Lite (64-bit)** to each 256GB NVMe (via USB-NVMe adapter, or boot from SD once and image the NVMe in place). Same imager hardening as above.
2. Set NVMe-first boot: `sudo rpi-eeprom-config --edit` → `BOOT_ORDER=0xf416` (NVMe → SD fallback).
3. ⚠️ **Never connect the USB-C PSU while a Pi is powered over PoE+** — 52Pi warns this can damage the P33 HAT. Pick one power source per boot.
4. Optional: the P33 guarantees PCIe Gen 2 but usually runs Gen 3 — add `dtparam=pciex1_gen=3` to `/boot/firmware/config.txt` and revert if the NVMe throws errors under load.

### C. Lenovo Hypervisor Node (Proxmox VE)

1. Flash a USB drive with **Proxmox VE 8.x**. Boot the Lenovo — `F12` for the boot menu, `F1` for BIOS setup.
2. In BIOS, confirm **Intel VT-x** and **VT-d** are **Enabled**.
3. Install onto the pre-existing **512GB SSD** (`pve-root`). Static management configuration:
   * **IP Address:** `10.0.10.10/24`
   * **Gateway:** `10.0.10.1` — the OPNsense VM built in Track 5. ⚠️ *The gateway doesn't exist yet: until Track 5 completes, reach the Proxmox UI from a laptop patched into **switch port 4** with static IP `10.0.10.50/24`, and expect no internet from the PVE host. That's fine — updates come in Track 5.*

---

## 🌐 Track 3: TL-SG108PE VLAN Execution Guide

Log into the switch web UI (DHCP-assigned address, or fallback `192.168.0.1`; default `admin`/`admin` — **rotate immediately**) and enforce the segmentation boundaries:

1. **VLAN ► 802.1Q VLAN** — set to **Enable**, then create **VLAN IDs 10, 20, 30, 40, 99**.
2. **VLAN Membership** — configure per this port map:

   | Port | Device | Mode | Untagged | Tagged |
   | :--- | :--- | :--- | :--- | :--- |
   | 1 | Pi 5 #1 (PoE+ port) | Access | 40 | — |
   | 2 | Pi 5 #2 (PoE+ port) | Access | 40 | — |
   | 3 | Pi 3B sentinel | Access | 20 | — |
   | 4 | Admin laptop / crash cart | Access | 10 | — |
   | 5 | Lenovo Proxmox | **Trunk** | 10 (native) | 20, 30, 40, 99 |
   | 6–7 | Spare (future expansion) | Access | 10 | — |
   | 8 | Home router uplink | Access | 99 | — |

3. **VLAN ► 802.1Q PVID Setting** — set PVIDs to match the untagged column: ports 1–2 → `40`, port 3 → `20`, ports 4–7 → `10`, port 5 → `10`, port 8 → `99`.
4. **System ► IP Setting** — disable DHCP and assign the switch `10.0.10.2/24` (do this **last** — you'll need to be on port 4 to keep access). ⚠️ Easy Smart switches have no dedicated management-VLAN control; containment relies on `10.0.10.0/24` existing only on VLAN 10 plus the OPNsense default-deny rules.
5. Save. Segmentation boundaries are now enforced at wire speed — but nothing routes between them until Track 5.

---

## 💾 Track 4: Proxmox Post-Install & Target Drive Partitioning

From the laptop on port 4, open `https://10.0.10.10:8006`:

1. **Repositories:** Node ► Updates ► Repositories — disable the enterprise repo, enable **No-Subscription**. (Actual `apt update` waits until the gateway is live.)
2. **VLAN-aware bridge** — required for the trunk to work. Node ► Network ► edit `vmbr0`: check **VLAN aware**, apply. VMs can now attach to any VLAN by tag.
3. **Thinpool:** Node ► Disks ► LVM-Thin ► **Create: Thinpool** on the 1TB drive (`/dev/nvme0n1` if M.2, `/dev/sda` if SATA). Name it exactly: `local-lvm-nvme`.

---

## 🚦 Track 5: OPNsense Gateway VM (Router-on-a-Stick)

This VM is the routing and firewalling core — every VLAN's `.1` lives here.

1. Upload the **OPNsense ISO** to `local`. Create a VM: 2 vCPU, 2GB RAM, 20GB disk on `local-lvm-nvme`.
2. Attach **five virtio NICs**, all on `vmbr0`, with VLAN tags: *(no tag)* = VLAN 10 native, `99`, `20`, `30`, `40`.
3. Install OPNsense; assign interfaces:
   * **WAN** = the tag-99 NIC (DHCP from home router)
   * **LAN** = the untagged NIC → `10.0.10.1/24`
   * **OPT1/2/3** = tags 20/30/40 → `10.0.20.1`, `10.0.30.1`, `10.0.40.1`
4. Enable DHCP per segment (or static-map everything on MGMT). Set the DHCP-advertised **DNS server to `10.0.20.10`** and **NTP server to `10.0.20.10`** on every segment (the sentinel node, live after Track 6).
5. **Firewall baseline (zero-trust default-deny):**
   * MGMT (10): allowed to reach all segments (admin plane).
   * SEC (20): accepts syslog `514/udp+tcp`, DNS `53`, and NTP `123/udp` from all segments; outbound only DNS resolution + HTTPS to Azure ingestion endpoints.
   * LAB (30): **no egress** — allow only from MGMT in, plus `53`/`123`/`514` out to SEC. This is the detonation zone.
   * APPS (40): egress to internet allowed; no lateral to 10/20/30 except `53`/`123`/`514` to SEC.
6. Set VM options: **start at boot**, startup order `1`. The whole lab's connectivity depends on this VM surviving host reboots.
7. Verify: PVE host can now `apt update`; run full upgrades on the node.

---

## 📡 Track 6: Security Services Sentinel Deployment (Pi 3B)

With routing live, SSH into the Pi 3B (`10.0.20.10`) and stand up the lab's out-of-band service plane. All three services fit comfortably in 1GB RAM.

1. **DNS — Pi-hole + Unbound:** install Unbound as a local recursive resolver (`127.0.0.1#5335`), then Pi-hole pointing at it as its sole upstream. Enable query logging. Every segment now resolves through `10.0.20.10` (advertised via OPNsense DHCP in Track 5).
2. **NTP — chrony:** configure as the lab time source (`allow 10.0.0.0/16`), syncing upstream to `pool.ntp.org`. Consistent timestamps across nodes are what make cross-segment log correlation work.
3. **Log pipeline — Fluent Bit:**
   * Inputs: syslog listener on `514/udp+tcp` (OPNsense, Proxmox, and Pi 5 nodes forward here) + tail of the Pi-hole query log.
   * Buffer: filesystem-backed on the Max Endurance microSD (that's what the high-endurance card is for).
   * Output: **Azure Logs Ingestion API** (`azure_logs_ingestion` plugin) — create a Log Analytics workspace, DCE + DCR, and an Entra app registration scoped to the DCR. No Azure Monitor Agent needed (AMA doesn't support the Pi). Hands-on DCR work is direct SC-500 practice.
4. Point log forwarding at the sentinel: OPNsense (System ► Settings ► Logging), Proxmox (`/etc/rsyslog.d/`), and each Pi 5 → `10.0.20.10:514`.

---

## 🔒 Track 7: Baseline Hardening Checklist

- [ ] Switch admin password rotated; management UI reachable only from VLAN 10.
- [ ] Proxmox: non-root admin user created (`pam` + `Administrator` role), root SSH login disabled, 2FA on the web UI.
- [ ] All Pis: SSH key-only auth confirmed (`PasswordAuthentication no`), `unattended-upgrades` enabled.
- [ ] OPNsense: default-deny verified from each segment (test with `nc`/`ping` from a VM per VLAN).
- [ ] DNS resolution and NTP sync confirmed from every segment against `10.0.20.10`.
- [ ] Syslog + DNS query logs ingesting into Microsoft Sentinel; confirmed with a KQL query in the workspace.
- [ ] Nothing port-forwarded from the home router into the lab. Remote access, if ever needed, via Tailscale/WireGuard on OPNsense — never raw exposure.

**Exit criteria:** four isolated segments routed and filtered by OPNsense, k3s nodes booted from NVMe on PoE+, and an out-of-band sentinel serving DNS/NTP while streaming query logs and syslog into Microsoft Sentinel. The lab is ready for [Phase 2 Kubernetes work](../phases/).
