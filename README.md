# infra
### Kubernetes Dashboard admin token
When logged in on the controller run:

`kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')`
