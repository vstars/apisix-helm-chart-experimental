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

- When the upstreams are the services on k8s, we should use FQDN of `kube-dns` service as dns server address(`kube-dns.kube-system.svc.cluster.local`), 
and the `resolver` directive must have `kube-dns`'s FQDN only, otherwise nginx can not resolve the FQDN of service in k8s. Reference issue: [#298](https://github.com/openresty/openresty/issues/298)

### TODO

- [ ] Enable etcd cluster persistance;
- [ ] Make it can be deployed to custom k8s namespace;
