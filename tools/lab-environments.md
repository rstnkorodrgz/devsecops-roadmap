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
| **Total peak** | **~4.5 GB** | **~25%** | **~25 GB** |

> Your MacBook Pro 2020 13" with 8 GB RAM can run the full local stack.  
> Close other apps during lab sessions if you have 8 GB RAM.  
> 16 GB RAM runs everything comfortably in parallel.

---

_← [Homebrew Packages](homebrew-packages.md) | [Back to README](../README.md)_
