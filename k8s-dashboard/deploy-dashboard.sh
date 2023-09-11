#!/usr/bin/env bash
cd "$(dirname "$0")"

# deploy the dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
# start the K8s so that it exposes the dashboard
kubectl proxy &
# create the dashboard user
kubectl apply -f ./dashboard-user.yml
# create the users cluster role
kubectl apply -f ./cluster-role.yml
# create a token for the new user
kubectl -n kubernetes-dashboard create token admin-user
# open the dashboard to login with that token
xdg-open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login