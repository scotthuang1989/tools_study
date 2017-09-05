# Intall
## [install docker](https://docs.docker.com/engine/installation/)
## [install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
## Installing kubelet and kubeadm
* kubelet: the component that runs on all of the machines in your cluster and does things like starting pods and containers.
* kubeadm: the command to bootstrap the cluster.

```shell
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm
```

# setup
## Initializing your master

```shell
# kubeadm init, you need decide which pod network you use
# and modify your init command accordingly,
# following command is for: Canal
# refer the to following section "Installing a pod network"
kubeadm init --pod-network-cidr=10.244.0.0/16

```
**Note**: if you meet following errors
```
preflight] Some fatal errors occurred:
	Port 6443 is in use
	Port 10250 is in use
	Port 10251 is in use
	Port 10252 is in use
	/etc/kubernetes/manifests is not empty
	/var/lib/kubelet is not empty
	Port 2379 is in use
	/var/lib/etcd is not empty
[preflight] If you know what you are doing, you can skip pre-flight checks with `--skip-
```
The cause of this issue is:
You can’t run kubeadm init twice without **tearing down** the cluster in between
So, you need tearn down before you run `kubeadmin init`
## Tear down(if you want start over)

Talking to the master with the appropriate credentials, run:
```
kubectl drain <node name> --delete-local-data --force --ignore-daemonsets
kubectl delete node <node name>
```
Then, on the node being removed, reset all kubeadm installed state:
```
kubeadm reset
```

upon the succesfull execution of the `kubeadm init` the output shold be:

```shell
[kubeadm] WARNING: kubeadm is in beta, please do not use it for production clusters.
[init] Using Kubernetes version: v1.7.0
[init] Using Authorization modes: [Node RBAC]
[preflight] Running pre-flight checks
[preflight] Starting the kubelet service
[certificates] Generated CA certificate and key.
[certificates] Generated API server certificate and key.
[certificates] API Server serving cert is signed for DNS names [kubeadm-master kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 10.138.0.4]
[certificates] Generated API server kubelet client certificate and key.
[certificates] Generated service account token signing key and public key.
[certificates] Generated front-proxy CA certificate and key.
[certificates] Generated front-proxy client certificate and key.
[certificates] Valid certificates and keys now exist in "/etc/kubernetes/pki"
[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/admin.conf"
[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/kubelet.conf"
[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/controller-manager.conf"
[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/scheduler.conf"
[apiclient] Created API client, waiting for the control plane to become ready
[apiclient] All control plane components are healthy after 16.502136 seconds
[token] Using token: <token>
[apiconfig] Created RBAC rules
[addons] Applied essential addon: kube-proxy
[addons] Applied essential addon: kube-dns

Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run (as a regular user):

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  http://kubernetes.io/docs/admin/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join --token <token> <master-ip>:<master-port>
```
follow the instruction from above outputs
```shell
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Make a record of the kubeadm join command that kubeadm init outputs. You will need this in a moment.
The token is used for mutual authentication between the master and the joining nodes. The token included here is secret, keep it safe — anyone with this token can add authenticated nodes to your cluster. These tokens can be listed, created and deleted with the kubeadm token command.



## Installing a pod network
I choose "Canal" as my  pod network, here are the [official guide of Canal](https://github.com/projectcalico/canal/tree/master/k8s-install)

order for Network Policy to work correctly, you need to pass `--pod-network-cidr=10.244.0.0/16` to kubeadm init
```shell
kubectl apply -f https://raw.githubusercontent.com/projectcalico/canal/master/k8s-install/1.6/rbac.yaml
kubectl apply -f https://raw.githubusercontent.com/projectcalico/canal/master/k8s-install/1.6/canal.yaml
```

Once a pod network has been installed, you can confirm that it is working by checking that the kube-dns pod is Running in the output of
```kubectl get pods --all-namespaces```
output: the 7th is kube-dns
```shell
NAMESPACE     NAME                                       READY     STATUS    RESTARTS   AGE
kube-system   calico-etcd-4nvsp                          1/1       Running   0          24s
kube-system   calico-node-7h5mt                          2/2       Running   0          23s
kube-system   calico-policy-controller-336633499-nv1gr   1/1       Running   0          23s
kube-system   etcd-scott-z230                            1/1       Running   0          1m
kube-system   kube-apiserver-scott-z230                  1/1       Running   0          1m
kube-system   kube-controller-manager-scott-z230         1/1       Running   0          1m
kube-system   kube-dns-2425271678-v02dc                  2/3       Running   0          2m
kube-system   kube-proxy-6bpxx                           1/1       Running   0          2m
kube-system   kube-scheduler-scott-z230                  1/1       Running   0          1m

```

## Master Isolation

By default, your cluster will not schedule pods on the master for security reasons. If you want to be able to schedule pods on the master, e.g. for a single-machine Kubernetes cluster for development, run:

```shell
kubectl taint nodes --all node-role.kubernetes.io/master-
```
## Join cluster for worker nodes
runt the command you get from the output of `kubeadmin init ...`

```shell
kubeadm join --token <token> <master-ip>:<master-port>
```

## Check the nodes

```shell
scott@scott-z230:~$ kubectl get nodes
NAME         STATUS    AGE       VERSION
scott-t460   Ready     6m        v1.7.5
scott-z230   Ready     13m       v1.7.5
```
## install sample for testing

* install app
```shell
kubectl create namespace sock-shop
kubectl apply -n sock-shop -f "https://github.com/microservices-demo/microservices-demo/blob/master/deploy/kubernetes/complete-demo.yaml?raw=true"
```
* get port for front-end service-4updated
```shell
kubectl -n sock-shop get svc front-end
```
* go to web browser to check
```
http://<master_ip>:<port>
```

* delete

```
kubectl delete namespace sock-shop
```
