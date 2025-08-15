# Secure Flask API on Kubernetes

A PoC demonstrating secure CI/CD practices for deploying a minimal Flask API to Kubernetes with comprehensive security scanning, signing, and policy enforcement.

## 🎯 Project Goals

- **Secure CI/CD Pipeline**: Automated security scanning, image signing, and policy enforcement
- **Zero-Trust Deployment**: Every artifact is scanned, signed, and verified before deployment
- **Audit-Ready**: Complete audit trail with metrics and runbooks for day-1 operations
- **Production Patterns**: Demonstrates enterprise security practices in a simple PoC

## 🏗️ Architecture

```
GitHub → Security Scan → Build → Sign → Deploy → Runtime Verification
   ↓         ↓           ↓       ↓       ↓            ↓
  Code → Trivy Scan → Docker → Cosign → K8s → OPA Gatekeeper
```

## 🔒 Security Stack

- **Image Scanning**: Trivy for vulnerability detection
- **Image Signing**: Cosign with AWS KMS or local keys
- **Admission Control**: OPA Gatekeeper policies
- **Runtime Security**: kube-bench + kubesec validation
- **Registry**: AWS ECR with image scanning enabled

## 🚀 Quick Start

### Prerequisites

- Docker Desktop with Kubernetes enabled OR kind/minikube
- AWS CLI configured (for ECR/KMS) OR local setup
- kubectl and helm installed

### 1. Setup Git Hooks

```bash
# Install git hooks for security checks
./scripts/setup-git-hooks.sh
```

### 2. Setup Infrastructure

```bash
# For AWS setup
cd infra/terraform
terraform init
terraform plan
terraform apply

# For local setup
./scripts/setup-local.sh
```

### 3. Deploy Security Policies

```bash
kubectl apply -f k8s/policies/
```

### 4. Build and Deploy

```bash
# Trigger CI/CD pipeline
git push origin main

# Or manual deployment
./scripts/deploy.sh
```

## 📁 Project Structure

```
secure-k8s-flask-poc/
├── app/                    # Flask application
│   ├── app.py             # Minimal Flask API
│   ├── Dockerfile         # Multi-stage secure build
│   └── requirements.txt   # Python dependencies
├── k8s/                   # Kubernetes manifests
│   ├── app/              # Application deployment
│   ├── policies/         # OPA Gatekeeper policies
│   └── monitoring/       # Security monitoring
├── infra/                # Infrastructure as Code
│   └── terraform/        # AWS ECR + KMS setup
├── .github/              # CI/CD workflows
│   └── workflows/        # Security-focused pipelines
├── scripts/              # Automation scripts
├── git-hooks/            # Git hook templates
├── docs/                 # Runbooks and documentation
└── audit/               # Audit reports and metrics
```

## 🛡️ Security Features

### Image Security

- Multi-stage Docker builds with distroless base
- Trivy vulnerability scanning (fail on HIGH/CRITICAL)
- Cosign image signing with KMS keys
- SBOM generation and attestation

### Kubernetes Security

- OPA Gatekeeper admission policies
- Pod Security Standards enforcement
- Network policies for micro-segmentation
- RBAC with least privilege

### Runtime Security

- kube-bench CIS benchmark validation
- kubesec workload security scoring
- Continuous compliance monitoring
- Security event alerting

## 📊 Audit & Compliance

### Day-1 Audit Package

- **Security Scan Reports**: Trivy vulnerability assessments
- **Compliance Metrics**: CIS benchmark scores
- **Policy Violations**: Gatekeeper policy reports
- **Signature Verification**: Cosign attestation logs
- **Runtime Posture**: Security monitoring dashboards

### Runbooks

- [Incident Response](docs/runbooks/incident-response.md)
- [Security Updates](docs/runbooks/security-updates.md)
- [Policy Management](docs/runbooks/policy-management.md)
- [Audit Procedures](docs/runbooks/audit-procedures.md)

## 🪝 Git Hooks

### Security Hooks
- **Pre-commit**: Secret scanning, YAML linting, Python formatting, Dockerfile security
- **Post-commit**: Audit logging, security scanning, compliance tracking

### Setup
```bash
./scripts/setup-git-hooks.sh
```

### Required Tools
- `gitleaks`: Secret scanning
- `yamllint`: YAML validation
- `black`: Python formatting
- `hadolint`: Dockerfile linting
- `trivy`: Security scanning
- `jq`: JSON processing

## 🔧 Configuration

### Environment Variables

```bash
# AWS Configuration (if using ECR/KMS)
AWS_REGION=us-east-1
ECR_REPOSITORY=secure-flask-poc
KMS_KEY_ID=alias/cosign-key

# Local Configuration
REGISTRY=localhost:5000
COSIGN_PRIVATE_KEY=cosign.key
```

### Security Policies

- **Image Policy**: Only signed images allowed
- **Resource Limits**: CPU/Memory constraints enforced
- **Network Policy**: Deny-all with explicit allows
- **Security Context**: Non-root, read-only filesystem

## 🚨 Monitoring & Alerting

- **Falco**: Runtime security monitoring
- **Prometheus**: Security metrics collection
- **Grafana**: Security dashboards
- **AlertManager**: Security incident notifications

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Ensure all security checks pass
4. Submit a pull request

## 📝 License

MIT License - see LICENSE file for details

## ⚠️ Security Notice

This is a PoC project demonstrating security practices. Review and adapt security configurations for your specific production requirements.
