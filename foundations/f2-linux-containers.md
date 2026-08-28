# F2 — Systems You Can Operate

> **Months 3–5 · ~80 hrs** (overlaps the tail of [F1](f1-code.md) — keep writing code while you do this)
> **Exit signal:** an application you containerised, deployed, deliberately broke, and fixed — with the failure written up.
> **The gap this closes:** you assess systems other people run. You have not run one.

---

## 🧠 The one rule

> **Break it on purpose, then fix it without reinstalling.**

Reviewing teaches you what should be true. Operating teaches you what happens when it is not. The whole point of this track is the second thing, and you only get it by causing failures deliberately and sitting with them.

Every module below ends with a break/fix exercise. Those are not optional extras — they are the actual content.

---

## 🐧 Module A — Linux you can operate (~4 weeks)

Your networking background helps here more than you expect. `ip`, `ss` and routing tables will feel familiar; the process and permission model will not.

### Get a machine to break

```bash
brew install --cask multipass
multipass launch 22.04 --name lab --memory 2G --disk 10G
multipass shell lab

# When you destroy it beyond repair — and you should, at least once:
multipass delete lab && multipass purge
```

### Concepts
- [ ] **The filesystem** — `/etc`, `/var/log`, `/usr`, `/proc`, `/opt`, and what belongs where
- [ ] **Permissions** — users, groups, `chmod`/`chown`, octal notation, SUID/SGID and why they matter to you
- [ ] **Processes** — `ps aux`, `top`, signals, `kill`, parent/child, zombies and orphans
- [ ] **systemd** — units, `systemctl start/enable/status`, reading why a service refuses to start
- [ ] **journald** — `journalctl -u <unit>`, `-f`, `--since`, filtering by priority. This is how you debug everything
- [ ] **Networking** — `ip a`, `ip r`, `ss -tulpn`, `dig`, `curl -v`. *(Familiar territory — lean on it)*
- [ ] **Package management** — `apt`, repositories, why pinning versions matters
- [ ] **Disks** — `df -h`, `du -sh`, mounts, what happens when `/` fills up
- [ ] **Users and SSH** — key-based auth, `sudo`, `/etc/sudoers`, hardening `sshd_config`

### Hands-on
- [ ] Install and run **nginx**; serve a page; change the port; reload it
- [ ] Write a `systemd` unit for a Python script from [F1](f1-code.md) so it runs on boot
- [ ] Read the logs of a service you deliberately misconfigured — **find the cause in `journalctl`, not by guessing**
- [ ] Set up key-based SSH, then disable password auth
- [ ] Find what is listening on every open port and justify each one

### 🔥 Break/fix
- [ ] Fill the disk (`fallocate -l 9G /big`) and recover
- [ ] `chmod 000` something important and recover
- [ ] Break `sshd_config` so the service will not start, then diagnose from the console
- [ ] Kill a critical process and watch what systemd does about it

---

## 🐳 Module B — Containers (~4 weeks)

You review container findings. Now build the images the findings are about.

### Concepts
- [ ] **What a container actually is** — namespaces + cgroups, not a small VM. This one insight explains most container security
- [ ] Images vs containers vs registries; layers and the build cache
- [ ] **Dockerfile** — `FROM`, `RUN`, `COPY`, `WORKDIR`, `CMD` vs `ENTRYPOINT`, `EXPOSE`
- [ ] Why each `RUN` creates a layer, and why a deleted secret in an earlier layer **is still in the image**
- [ ] Volumes and bind mounts — where data lives when the container dies
- [ ] Container networking — port publishing, container-to-container DNS
- [ ] **`docker compose`** — multi-container apps in one file
- [ ] Image security: non-root `USER`, multi-stage builds, minimal/distroless bases, pinned tags over `:latest`

### Hands-on
- [ ] `docker run` nginx, postgres, and redis. Get into each with `docker exec -it ... bash`
- [ ] Write a Dockerfile for your [F1](f1-code.md) ASPM ranker. Build it. Run it. Fix it when it fails
- [ ] Make it **multi-stage** and run as **non-root**; compare image sizes before and after
- [ ] `docker compose` an app + database together, with the app reading the DB host by service name
- [ ] Scan your image: `trivy image <name>`. **Now read the findings as the person who has to fix them** — this will change how you write findings at work
- [ ] Rebuild on a smaller base image and re-scan. Record the CVE delta
- [ ] Prove the layer problem to yourself: `COPY` a file with a secret, delete it in a later layer, then find it with `docker history` and by extracting the layer

### 🔥 Break/fix
- [ ] Build an image that fails at runtime because of a missing dependency; diagnose from `docker logs`
- [ ] Get a container that exits immediately to tell you why
- [ ] Break container-to-container networking in compose, then fix it

---

## 🚀 Module C — Deploy and operate something real (~2 weeks)

### Hands-on
- [ ] Take the [`api-track/fastapi-scaffold/`](../api-track/fastapi-scaffold/) — a real FastAPI service that already exists in this repo
- [ ] Run it locally. Read every file. You did [F1](f1-code.md); this is now readable
- [ ] Containerise it, run it with `docker compose` alongside a database
- [ ] Deploy it to a cheap always-on host (a small cloud VM, or the [homelab](../homelab/README.md) if it exists by then)
- [ ] Put nginx in front of it as a reverse proxy with TLS (Let's Encrypt)
- [ ] **Operate it for two weeks.** Check it is up. Read its logs. Notice what breaks
- [ ] Write a one-page runbook: how to deploy, restart, roll back, read logs, rotate the certificate

> 🎯 **F2 rep (ship it):** the runbook plus a **post-mortem of one real failure** you caused or hit. Written the way you would want a team to write it for you: symptom → diagnosis → fix → what would have prevented it.
>
> You review other people's incidents. Writing your own from the operator's chair is a different and more credible thing.

---

## 📄 Exit criteria

- [ ] You can SSH to a Linux box and diagnose a stopped service from logs alone
- [ ] You can write a Dockerfile from scratch — non-root, multi-stage, pinned base
- [ ] You have an app running that you deployed and kept alive
- [ ] You have broken something and fixed it without rebuilding from zero
- [ ] You can explain what a container actually is, in namespace/cgroup terms
- [ ] The runbook and post-mortem are public

> 🎯 **What this proves in an interview:** operator credibility. "I deployed it, it broke at 2am on a Tuesday, here is what I found in the logs and here is the runbook I wrote afterwards" is a fundamentally different answer from "I reviewed a deployment." Interviewers can tell them apart instantly.

---

## 📚 Resources

| Resource | Type | Priority |
|---|---|---|
| [*The Linux Command Line*](https://linuxcommand.org/tlcl.php) — Shotts (free PDF) | Book | ⭐⭐⭐ |
| [Linux Journey](https://linuxjourney.com/) (free, structured) | Course | ⭐⭐⭐ |
| [Docker — Get Started](https://docs.docker.com/get-started/) (official, free) | Docs | ⭐⭐⭐ |
| [*Docker Deep Dive*](https://nigelpoulton.com/) — Nigel Poulton | Book | ⭐⭐ |
| [Julia Evans — *Linux debugging tools* zine](https://wizardzines.com/) | Reference | ⭐⭐ |
| [Play with Docker](https://labs.play-with-docker.com/) (free browser labs) | Lab | ⭐⭐ |
| [*Container Security*](https://www.oreilly.com/library/view/container-security/9781492056690/) — Liz Rice | Book | ⭐ _(revisit in [Phase 3](../phases/phase-3-cks.md))_ |

---

_← [F1 — Code you can write](f1-code.md) | [F3 — Cloud you can build in →](f3-azure.md)_
