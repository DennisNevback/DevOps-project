# 🚀 DevOps Platform Demo

Run a complete containerized platform locally with a single command.

This project demonstrates a full DevOps workflow including containerization, Kubernetes deployment, monitoring, and automated environment setup.

---

## 🧩 Overview

This is an end-to-end DevOps demo project featuring:

- A containerized API service using Entity framework
- Kubernetes-based deployments
- Monitoring with Prometheus and Grafana
- Infrastructure managed via Helm and Kubernetes manifests
- One-command environment setup

The goal of this project is to showcase practical DevOps skills in a realistic environment.

---

## ⚡ Quick Start

```bash
git clone <your-repo-url>
cd devops-platform
./scripts/start.sh
```

---

## 🔧 What the Script Does

The startup script will automatically:

- Start a local Kubernetes cluster using Minikube
- Build Docker images using Docker
- Deploy services to Kubernetes
- Install monitoring stack using Helm
- Configure Prometheus for metrics collection
- Set up Grafana dashboards
- Expose application endpoints

---

## 🌐 Accessing the Services

After the script completes:

### API

Accessible via:

```bash
minikube service api
```

### Grafana

- URL: http://localhost:3000
- Username: `admin`
- Password: printed in terminal output

---

## 🏗️ Architecture

The platform consists of:

- **API Service** (.NET)
- **Kubernetes Cluster** (Minikube)
- **Monitoring Stack**
  - Prometheus (metrics collection)
  - Grafana (visualization)

Kubernetes resources include:

- Deployments
- Services
- Secrets
- Namespaces

---

## 📊 Observability

- Application exposes metrics via `/metrics`
- Metrics are scraped by Prometheus
- Dashboards are visualized in Grafana

> Add screenshots here:
>
> - Grafana dashboard
> - Running pods (`kubectl get pods`)
> - API response

---

## 📁 Project Structure

```
devops-platform/
├── apps/
│   └── api/
├── helm/
│   ├── prometheus/
│   └── grafana/
├── k8s/
│   ├── deployments/
│   ├── services/
│   └── secrets/
├── scripts/
│   └── start.sh
```

---

## ⚙️ Technologies Used

- Docker
- Kubernetes
- Minikube
- Helm
- Prometheus
- Grafana

---

## 🎯 What This Project Demonstrates

- Containerizing applications
- Deploying to Kubernetes
- Managing infrastructure as code
- Setting up monitoring and observability
- Automating local environments
- Structuring a DevOps-oriented repository

---

## 💡 Notes

This project is designed for local development and demonstration purposes.
It uses Minikube and locally built Docker images for simplicity.

---

## 📌 Future Improvements (Optional)

- CI/CD pipeline using GitHub Actions
- Helm chart for application deployment
- Distributed tracing (e.g. OpenTelemetry)
- Production-ready container registry integration

---

## 👤 Author

Created as a DevOps portfolio project to demonstrate practical skills in modern cloud-native tooling.
