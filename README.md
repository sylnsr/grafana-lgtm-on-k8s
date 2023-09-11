# grafana-lgtm-in-k8s

Grafana LGTM stack on Kubernetes for local evaluation / development.

(i.e. not intended for production use or serving any network or real world applications)

### What's in this setup

1. [Grafana LGTM stack](https://grafana.com/go/webinar/getting-started-with-grafana-lgtm-stack/)
2. If you don't have a K8s environment, then you may want to consider setting one up with [Kind](https://kind.sigs.k8s.io/).
3. [MinIO](https://microk8s.io/) is needed for storage. You may want to run it as a [container](https://hub.docker.com/r/minio/minio)

### Steps

I assume you can execute `kubectl` and `helm` commands in your K8s setup. On K8s control host, do the following:

1. Add the Helm chart repo for Grafana: `helm repo add grafana https://grafana.github.io/helm-charts`
2. Install Grafana from chart: `helm install grafana grafana/grafana`
3. Install [Loki](https://grafana.com/docs/loki/latest/setup/install/helm/install-monolithic/) from chart: `helm install --values loki-helm-values.yml loki grafana/loki`
4. Install [Tempo](https://grafana.com/docs/tempo/latest/setup/helm-chart/) from chart: `helm install tempo grafana/tempo`
5. Install Mirmir from chart: `helm install mirmir grafana/mimir-distributed`
