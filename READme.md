### This README file provides an overview of the DevOps project utilizing various tools such as Azure, Kubernetes, GitOps, Terraform, CI/CD, and Prometheus. It aims to guide developers and operators through the project setup and deployment process.

## Install ARGO CD

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

## Expose the argocd-server service in order to connect
kubectl edit svc argocd-server -n argocd

## Retrieve the secret to connect the API
kubectl get secret -n argocd

kubectl get secret argocd-initial-admin-secret -o yaml -n argocd

## Decode the secrets
echo "S0dHN3R2dkZWd2trcDRrTQ==" | base64 --decode