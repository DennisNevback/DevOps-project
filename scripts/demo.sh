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

cd "$ROOT_DIR"

echo "Deploying to Kubernetes..."

kubectl apply -f k8s/secrets/
kubectl apply -f k8s/deployments/
kubectl apply -f k8s/services/

#Grafana dashboard
kubectl wait --for=condition=ready pod -l app.kubernetes.io/instance=grafana -n monitoring --timeout=120s
kubectl port-forward svc/grafana -n monitoring 3000:80 &

echo "Printing grafana dashboard password:"
echo ""
kubectl get secret grafana -o jsonpath='{.data.admin-password}' -n monitoring | base64 --decode

echo "Opening Api"

minikube service api