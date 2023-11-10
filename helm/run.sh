#!/bin/bash
## ======================================================= 01
minikube start --listen-address='0.0.0.0' --apiserver-ips=192.168.1.5 --vm-driver=docker --ports=8443:8443
kubectl proxy --address='0.0.0.0' --disable-filter=true
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/workloads?namespace=default

## ingress
minikube addons enable ingress
kubectl get pods -n ingress-nginx

kubectl get events

# sample app
helm create sample-ap
helm lint ./sample-app
helm template ./sample-app
helm install sample-app ./sample-app
helm ls --all
helm upgrade sample-app ./sample-app
helm rollback sample-app 1 # 1 - previous version
helm uninstall sample-app
helm package ./sample-app

kubectl apply -f ingress.yaml
kubectl get service nginx-ingress-controller -n nginx-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

## ======================================================= 02
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm install nginx-ingress nginx-stable/nginx-ingress
helm install nginx-service ./nginx-service.yaml

## ======================================================= MISC
# repositories
helm repo index sm-repo/ --url https://smiguelnet.gihub.io/sm-repo
helm repo add sm-repo http://smiguelnet.github.io/sm-repo
helm install sm-repo/sample-app --name=sample-app

# repo search
helm search repo sample-repo

# pod validation
kubectl get pods --namespace default
kubectl describe pod sample-app-55f7d66cb4-ftfxx

kubectl get service sample-app

# viewing pod status
kubectl get po -A
kubectl get nodes

kubectl describe service kubchallenge-service


minikube service sample-app --url
minikube service kubchallenge-service --url