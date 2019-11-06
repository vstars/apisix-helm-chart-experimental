# apisix-helm-chart-experimental
Experimental project to make it easy to deploy [apisix](https://github.com/apache/incubator-apisix) to k8s via helm, **not finished**!

**NOTICE**: This project is a experimental project, do not use it in production environment!!!



#### Install

```bash
# install by helm
helm install --name apisix --namespace apisix .
```

#### Delete

1. Delete apisix chart

    ```bash
    helm delete --purge apisix
    ```

2. Cleanup etcd CRDs

    ```bash
    kubectl get crd -n apisix | grep coreos | awk '{ print $1 }' | xargs kubectl delete crd -n apisix
    ```

### Known issues

- When use `kube-dns` service as dns server, apisix can not connect to etcd cluster by using `etcd-cluster-client` service's FQDN `etcd-cluster-client.apisix.svc.cluster.local`. 

### TODO

- [ ] Enable etcd cluster persistance;
- [ ] Make it can be deployed to custom k8s namespace;
