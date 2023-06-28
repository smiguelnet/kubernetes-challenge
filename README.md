# Kubernetes challenge
Challenge reference: 
https://github.com/learnk8s/kubernetes-challenge

## Instructions

- Fork this repo
- Build the Docker image
- Write yaml files for a deployment, service, ingress and configmap
- Deploy your application to Minikube
- You should be able to `curl` Minikube's ip and retrieve the string `Hello {yourname}!`
- Commit your files to Github

## Notes

There's no need to push the Docker image to a Docker registry. You should be able to build and use the image from within Minikube.

You can expose Minikube's Docker daemon with:

```shell
$ eval (minkube docker-env)
```

---

## Files

- [deployment.yml](deployment.yml)
- [service.yml](service.yml)
- [configmap.yml](configmap.yml)
- [ingress.yml](ingress.yml)

---

## Scripts

```shell
# Building docker image
docker build --tag kubchallenge --file Dockerfile .
docker tag kubchallenge:latest smiguelnet/kubchallenge:1.0.0
docker push smiguelnet/kubchallenge:1.0.0

# Testing docker image
docker run -d -p 4000:8080 --name kubchallenge smiguelnet/kubchallenge:1.0.0
# *** REMOVE IT AFTER TESTING ***
# docker stop kubchallenge
# docker rm kubchallenge

# Deployment
kubectl apply -f deployment.yml

# Service
kubectl apply -f service.yml

# Config Map
kubectl apply -f configmap.yml

# Ingress (Nginx)
kubectl apply -f ingress.yml
```

Additional commands available on [script.sh](script.sh)

---

## Notes
To utilize the Load Balancer and test it locally (e.g. https://localhost:8080), use the minikube tunnel:
```shell
minikube tunnel
``` 
