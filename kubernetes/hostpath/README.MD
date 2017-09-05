Target of this guide is to setup a kubernets hostpah PV.
This is basically a implementation of [this guide](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)

## How to setup

* create PV
```shell
kubectl kubectl create -f task-pv-volume.yaml
```

* create PVC
```shell
kubectl kubectl create -f task-pv-claim.yaml
```

* create a POD for testing

```shell
kubectl kubectl create -f task-pv-pod.yaml
```
