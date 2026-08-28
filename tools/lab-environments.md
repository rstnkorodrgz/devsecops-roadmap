# Lab Environments Setup

> Hands-on practice environments for each phase.  
> All local labs run on your MacBook Pro 2020 13".  
> Cloud labs use AWS Free Tier / GCP Free Tier where possible.

---

## 🏠 Local Lab Stack (MacBook)

Your MacBook runs the entire local lab stack using Docker + kind:

```
┌─────────────────────────────────────────────────────┐
│  MacBook Pro 2020 13"                                │
│  ┌──────────────────────────────────────────────┐   │
│  │  Docker Desktop                               │   │
│  │  ┌────────────────────────────────────────┐  │   │
│  │  │  kind cluster: devsecops-lab           │  │   │
│  │  │  ┌──────────┐ ┌──────────┐ ┌────────┐ │  │   │
│  │  │  │  Istio   │ │  Falco   │ │Tetragon│ │  │   │
│  │  │  │(service  │ │(runtime  │ │ (eBPF) │ │  │   │
│  │  │  │  mesh)   │ │detection)│ │        │ │  │   │
│  │  │  └──────────┘ └──────────┘ └────────┘ │  │   │
│  │  │  ┌──────────┐ ┌──────────┐            │  │   │
│  │  │  │  OPA /   │ │ Kyverno  │            │  │   │
│  │  │  │Gatekeeper│ │(policies)│            │  │   │
│  │  │  └──────────┘ └──────────┘            │  │   │
│  │  └────────────────────────────────────────┘  │   │
│  │  ┌─────────────────────────────────────────┐ │   │
│  │  │  Vulnerable lab containers              │ │   │
│  │  │  DVWA │ crAPI │ vAPI │ Juice Shop       │ │   │
│  │  └─────────────────────────────────────────┘ │   │
│  └──────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
```

---

## ☁️ Cloud Lab Accounts

### AWS Free Tier Account Setup
- [ ] Create AWS account at aws.amazon.com (use a dedicated email)
- [ ] Enable MFA on root account immediately
- [ ] Create an IAM admin user (never use root for daily work)
- [ ] Set up a billing alert at $10 to avoid surprise charges
- [ ] Configure `aws-vault` profile pointing to your IAM user

```bash
# Set up billing alarm (run after AWS CLI is configured)
aws cloudwatch put-metric-alarm \
  --alarm-name "billing-alert-10usd" \
  --alarm-description "Alert when monthly AWS charges exceed $10" \
  --metric-name EstimatedCharges \
  --namespace AWS/Billing \
  --statistic Maximum \
  --period 86400 \
  --threshold 10 \
  --comparison-operator GreaterThanThreshold \
  --dimensions Name=Currency,Value=USD \
  --evaluation-periods 1 \
  --alarm-actions arn:aws:sns:us-east-1:ACCOUNT_ID:billing-alerts
```

- [ ] AWS Free Tier account created
- [ ] MFA enabled on root account
- [ ] IAM admin user created with programmatic access
- [ ] Billing alert configured
- [ ] `aws-vault` profile working

### GCP Free Tier Account Setup
- [ ] Create GCP account at cloud.google.com ($300 free credits for new accounts)
- [ ] Create a dedicated project: `devsecops-lab`
- [ ] Enable the Security Command Center API
- [ ] Configure `gcloud` CLI: `gcloud init`

- [ ] GCP account created
- [ ] `devsecops-lab` project created
- [ ] `gcloud auth login` working

---

## 🐳 Phase 2 — Kubernetes Lab Setup

### Create the lab cluster

```bash
# Create a multi-node kind cluster for realistic testing
cat > ~/.kind-config.yaml << 'EOF'
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: devsecops-lab
nodes:
  - role: control-plane
    kubeadmConfigPatches:
      - |
        kind: ClusterConfiguration
        apiServer:
          extraArgs:
            audit-log-path: /var/log/kubernetes/audit.log
            audit-policy-file: /etc/kubernetes/audit-policy.yaml
        etcd:
          local:
            extraArgs:
              cipher-suites: TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
  - role: worker
  - role: worker
EOF

kind create cluster --config ~/.kind-config.yaml
kubectl cluster-info --context kind-devsecops-lab
```

- [ ] Multi-node kind cluster created
- [ ] `kubectl get nodes` shows 1 control-plane + 2 workers

### Install Falco (Runtime Security)

```bash
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update

helm install falco falcosecurity/falco \
  --namespace falco-system \
  --create-namespace \
  --set falco.grpc.enabled=true \
  --set falco.grpcOutput.enabled=true

# Verify Falco is running
kubectl get pods -n falco-system

# Trigger a Falco alert (in a test pod)
kubectl run test --image=ubuntu --rm -it --restart=Never -- \
  bash -c "cat /etc/shadow 2>/dev/null || echo 'Permission denied (expected)'"

# Check Falco logs for the alert
kubectl logs -n falco-system -l app.kubernetes.io/name=falco --tail=20
```

- [ ] Falco running in `falco-system`
- [ ] Falco alert triggered by `cat /etc/shadow` test

### Install OPA Gatekeeper

```bash
helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
helm repo update

helm install gatekeeper gatekeeper/gatekeeper \
  --namespace gatekeeper-system \
  --create-namespace

# Verify
kubectl get pods -n gatekeeper-system

# Test with a sample constraint (no privileged containers)
cat << 'EOF' | kubectl apply -f -
apiVersion: templates.gatekeeper.sh/v1
kind: ConstraintTemplate
metadata:
  name: k8spspprivilegedcontainer
spec:
  crd:
    spec:
      names:
        kind: K8sPSPPrivilegedContainer
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8spspprivilegedcontainer
        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          container.securityContext.privileged == true
          msg := sprintf("Privileged container not allowed: %v", [container.name])
        }
EOF
```

- [ ] OPA Gatekeeper running in `gatekeeper-system`
- [ ] No-privileged-containers policy applied

### Install Kyverno (Alternative to OPA)

```bash
helm repo add kyverno https://kyverno.github.io/kyverno
helm repo update

helm install kyverno kyverno/kyverno \
  --namespace kyverno \
  --create-namespace

kubectl get pods -n kyverno
```

- [ ] Kyverno running in `kyverno` namespace

---

## 🎯 Phase 2 — Vulnerable App Lab

```bash
# DVWA — Damn Vulnerable Web Application (for DAST practice)
docker run -d \
  --name dvwa \
  -p 8080:80 \
  vulnerables/web-dvwa

echo "DVWA running at http://localhost:8080"
echo "Login: admin / password"

# crAPI — Completely Ridiculous API (OWASP API Top 10 lab)
git clone https://github.com/OWASP/crAPI.git ~/labs/crAPI
cd ~/labs/crAPI
docker compose -f deploy/docker/docker-compose.yml up -d

echo "crAPI running at http://localhost:8888"

# Juice Shop — OWASP Juice Shop (web app security training)
docker run -d \
  --name juice-shop \
  -p 3000:3000 \
  bkimminich/juice-shop

echo "Juice Shop running at http://localhost:3000"
```

- [ ] DVWA running at localhost:8080
- [ ] crAPI running at localhost:8888
- [ ] Juice Shop running at localhost:3000

---

## 🔍 Phase 3 — AppSec Lab Setup

### PortSwigger Web Academy (Free Online Labs)
No local setup needed — use your browser.

- [ ] Create free account at portswigger.net/web-security
- [ ] Complete all SQL Injection labs
- [ ] Complete all XSS labs
- [ ] Complete all SSRF labs
- [ ] Complete all API Security labs
- [ ] Complete all JWT attacks labs

### vAPI — Vulnerable API (OWASP API Top 10 practice)

```bash
git clone https://github.com/roottusk/vapi.git ~/labs/vapi
cd ~/labs/vapi
docker compose up -d

echo "vAPI running at http://localhost:80"
echo "Import the Postman collection from ~/labs/vapi/postman/"
```

- [ ] vAPI running at localhost:80
- [ ] Postman collection imported

---

## 🧩 Gap-Closing Labs (v2.2 — CDP sequence)

> Targets for the [CDP gap-closing sequence](../tracks/README.md#-the-cdp-gap-closing-sequence). These run **instead of** the kind cluster on an 8 GB machine, not alongside it.

### Ansible / Inspec / OpenSCAP target VM

`oscap` is a Linux tool and Ansible needs a real host — neither works against macOS. Multipass gives you a throwaway Ubuntu VM on both Intel and Apple Silicon.

```bash
brew install --cask multipass

multipass launch 22.04 --name target --memory 2G --disk 10G
multipass list                       # note the IP
multipass shell target               # break it freely

# Reset to a clean host whenever a hardening lab goes wrong
multipass delete target && multipass purge
```

- [ ] `target` VM running, key-based SSH working from the Mac
- [ ] You have reset it at least once (you will need to)

Full walkthrough: [tracks/config-management.md](../tracks/config-management.md) and [tracks/compliance-as-code.md](../tracks/compliance-as-code.md).

### DefectDojo — vulnerability aggregation

```bash
git clone https://github.com/DefectDojo/django-DefectDojo ~/labs/defectdojo
cd ~/labs/defectdojo
docker compose up -d
docker compose logs initializer | grep -i "admin password"

echo "DefectDojo at http://localhost:8080 — login: admin"
```

- [ ] DefectDojo reachable, admin password captured
- [ ] At least one scanner report imported (Semgrep or Trivy JSON)
- [ ] `docker compose down` when finished — it is the heaviest thing in this file

### Polyglot scanner targets

Your codebases are Python, Go and containers. CDP's SAST and SCA labs run on **Java, JavaScript and Ruby**, and so do a large share of real enterprise estates. You are not learning these languages — you are learning what each scanner prints and how to gate on it. One evening, once.

```bash
mkdir -p ~/labs/polyglot && cd ~/labs/polyglot

# --- Java: SpotBugs + OWASP Dependency-Check ---
git clone https://github.com/WebGoat/WebGoat.git
brew install spotbugs dependency-check

dependency-check --project webgoat --scan ./WebGoat --format HTML --out ./dc-report
# SpotBugs alone finds *bugs*; the Find Security Bugs plugin is what makes it SAST.
# Install it from https://find-sec-bugs.github.io/ before drawing conclusions.

# --- JavaScript: RetireJS + npm audit ---
git clone https://github.com/OWASP/NodeGoat.git && cd NodeGoat
npm install --package-lock-only
npm audit --json > ../npm-audit.json
npx retire --outputformat json --outputpath ../retire.json
cd ..

# --- Ruby: Brakeman ---
git clone https://github.com/OWASP/railsgoat.git
gem install brakeman
brakeman -o brakeman.json -f json railsgoat/
```

- [ ] Dependency-Check HTML report opened and read — note how it reports CVEs against **transitive** dependencies
- [ ] `npm audit` vs RetireJS on the same project: note what each finds that the other misses
- [ ] Brakeman run once — note that it is Rails-**aware**, not generic, which is why framework-specific SAST still exists
- [ ] All four JSON outputs imported into DefectDojo, deduplicated
- [ ] Write down, in one line each, what you'd use in a real pipeline instead — and why Semgrep and Trivy are usually the better answer

---

## 📊 Lab Resource Usage Guide

| Lab Component | RAM | CPU | Storage |
|---|---|---|---|
| Docker Desktop | ~2 GB | ~10% idle | 20 GB disk |
| kind cluster (3 nodes) | ~1.5 GB | ~5% idle | ~3 GB |
| Falco in cluster | ~200 MB | ~2% | — |
| OPA Gatekeeper | ~100 MB | ~1% | — |
| DVWA container | ~50 MB | minimal | — |
| Juice Shop | ~100 MB | minimal | — |
| crAPI stack | ~500 MB | ~5% | — |
| Multipass `target` VM | ~2 GB | ~5% | ~10 GB |
| DefectDojo stack | ~2.5 GB | ~10% | ~5 GB |
| **Total peak (Phase 2/3 labs)** | **~4.5 GB** | **~25%** | **~25 GB** |
| **Total peak (gap-closing labs)** | **~4.5 GB** | **~15%** | **~15 GB** |

> ⚠️ **Do not run the gap-closing labs and the kind cluster at the same time** on 8 GB — DefectDojo plus a Multipass VM plus kind will swap. Run one stack per session.
> Your MacBook Pro 2020 13" with 8 GB RAM can run either stack, one at a time.  
> Close other apps during lab sessions if you have 8 GB RAM.  
> 16 GB RAM runs everything comfortably in parallel.

---

_← [Homebrew Packages](homebrew-packages.md) | [Back to README](../README.md)_
