#!/bin/bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "Starting cluster..."
minikube start

echo "Building images..."
eval $(minikube docker-env)
docker build -t api:dev -f apps/api/api/Dockerfile apps/api

echo "Installing monitoring"

cd helm/prometheus
helm dependency update
helm upgrade --install prometheus . -n monitoring --create-namespace

cd "$ROOT_DIR/helm/grafana"
helm dependency update
helm upgrade --install grafana . -f values.yaml -n monitoring

cd "$ROOT_DIR/helm/traefik"
helm dependency update
helm upgrade --install traefik . -n traefik -f values.yaml --create-namespace

cd "$ROOT_DIR/helm/argocd"
helm dependency update
helm upgrade --install argocd . -n argocd -f values.yaml --create-namespace

cd "$ROOT_DIR"

echo "Deploying to Kubernetes..."

kubectl apply -f k8s/secrets/
kubectl apply -f k8s/deployments/
kubectl apply -f k8s/services/
kubectl apply -f k8s/ingress/

#Grafana dashboard
echo "Waiting for Grafana..."
kubectl wait \
  --for=condition=ready \
  pod -l app.kubernetes.io/instance=grafana \
  -n monitoring \
  --timeout=120s

echo "Open traefik port."
kubectl port-forward svc/traefik -n traefik 8080:80 >/tmp/traefik.log 2>&1 &

echo "Grafana dashboard:"
echo "http://localhost:8080/grafana/"

echo "Traefik dashboard:"
echo "http://localhost:8080/dashboard/"

echo "ArgoCD dashboard:"
echo "http://localhost:8080/argocd/"

echo "Swagger dashboard:"
echo "http://localhost:8080/swagger"
echo "Api endpoint /api/worldcity"