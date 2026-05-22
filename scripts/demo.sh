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
echo "Waiting for Grafana..."
kubectl wait \
  --for=condition=ready \
  pod -l app.kubernetes.io/instance=grafana \
  -n monitoring \
  --timeout=120s

echo "Starting Grafana..."
kubectl port-forward svc/grafana -n monitoring 3000:80 >/tmp/grafana.log 2>&1 &

echo "Grafana dashboard:"
echo "http://localhost:3000"

MINIKUBE_IP=$(minikube ip)

echo "Swagger endpoint */swagger"
echo "Api endpoint /api/worldcity"
echo "api:"
minikube service api --url