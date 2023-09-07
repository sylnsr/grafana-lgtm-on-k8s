# grafana-lgtm-in-k8s

Grafana LGTM stack on Kubernetes for local evaluation / development.

(i.e. not intended for production use or serving any network or real world applications)

### What's in this setup

1. [Grafana LGTM stack](https://grafana.com/go/webinar/getting-started-with-grafana-lgtm-stack/)
2. If you don't have a K8s environment, then we use [Microk8s in Ubuntu](https://microk8s.io/)
3. [MinIO](https://microk8s.io/) is needed for storage.

# Intro

I assume you have Helm 3.x and Ansible 2.15 or higher, and that you can execute `kubectl` commands in your K8s setup.
If you don't have a K8s environment setup, then you could simply set one up in 2 Ubuntu virtual machines, by following
the instructions in [`ubuntu-k8s-setup.md`](ubuntu-k8s-setup.md).
