This guide setup a simple kubernetes NFS PV.
This guide is almost a copy a [this guide](https://github.com/kubernetes/examples/tree/master/staging/volumes/nfs)
I just simplified it.

## Setup steps

### Create a PV.
you need change nfs-pv.yaml according to your NFS server settings

```shell
server: 10.168.62.38
path: "/var/nfs/kubenfs"
```
then run this command
```
kubectl create -f nfs-pv.yaml
```

### Create a PVC

```
kubectl create -f nfs-pvc.yaml
```

### Create a pod for testing

```
kubectl create -f nfs-pod.yaml
```
