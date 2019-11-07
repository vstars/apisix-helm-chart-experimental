# apisix-helm-chart-experimental
Experimental project to make it easy to deploy [apisix](https://github.com/apache/incubator-apisix) to k8s via helm, **not finished**!

**NOTICE**: This project is a experimental project, do not use it in production environment!!!


#### Install

```bash
# install by helm
helm install --name apisix --namespace apisix .
```

ETCD cluster is created by [etcd-operator](https://github.com/helm/charts/tree/master/stable/etcd-operator) helm chart.

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

### References

- Regarding ETCD backup and restore, see [etcd backup operator](https://github.com/coreos/etcd-operator/blob/master/doc/user/walkthrough/backup-operator.md) & 
[etcd restore operator](https://github.com/coreos/etcd-operator/blob/master/doc/user/walkthrough/restore-operator.md); 
you can pass `--set etcd-operator.customResources.createBackupCRD=true` and `--set etcd-operator.customResources.createRestoreCRD=true` and other values
during install apisix by helm command.

### TODO

- [ ] Make it can be deployed to custom k8s namespace;
