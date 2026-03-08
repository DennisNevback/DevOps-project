#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Starting cluster..."

minikube start

echo "Building images..."

eval $(minikube docker-env)

docker build -t api:dev -f apps/api/api/Dockerfile apps/api

echo "Deploying to Kubernetes..."

kubectl apply -f k8s/secrets/
kubectl apply -f k8s/deployments/
kubectl apply -f k8s/services/

echo "Done!"

minikube service api