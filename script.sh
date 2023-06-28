#!/bin/bash

# Building docker image
docker build --tag kubchallenge --file Dockerfile .
docker tag kubchallenge:latest smiguelnet/kubchallenge:1.0.0
docker push smiguelnet/kubchallenge:1.0.0

# Testing local docker image
docker run -d -p 4000:8080 --name kubchallenge  smiguelnet/kubchallenge:1.0.0
# docker logs --follow kubchallenge 
# docker stop kubchallenge
# docker rm kubchallenge 

# ===================================== #
# DEPLOYMENT
kubectl apply -f deployment.yml
# kubectl apply -f deployment.yml --dry-run=client
# kubectl get deployment
# kubectl delete deploy kubchallenge-deployment

# ===================================== #
# SERVICE
kubectl apply -f service.yml
# kubectl get service
# kubectl delete service kubchallenge-service
# kubectl delete -n default service kubchallenge-deployment

# ===================================== #
# CONFIG MAP
kubectl apply -f configmap.yml
# kubectl get configmap
# kubectl delete configmap kubchallenge-configmap

# ===================================== #
# INGRESS
kubectl apply -f ingress.yml
# kubectl get ingress
# kubectl delete ingress kubchallenge-ingress

# ===================================== #
# MONITORING
kubectl rollout status deployment
kubectl rollout status service

minikube logs