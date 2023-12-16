1. Repeat steps 1-11 from [KubernetesIntro](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesIntro/ReadmeKubernetesIntro.md) but with files from current KubernetesDeployment
folder.

2. Copy `secrets.yaml`, `app-deployment.yaml` and `db-deployment.yaml` to Master Node.

3. Aplly
```
kubectl apply -f secrets.yaml
kubectl apply -f app-deployment.yaml
kubectl apply -f db-deployment.yaml
```

4. Reload DNS: `kubectl delete pods -l k8s-app=kube-dns -n kube-system`

5. Check Wordpress by `<nodePublicId>:<port>`.

![WorkingWordpress](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesDeployment/Screenshots/WorkingWordpress.png?raw=true)

6. Clean up
```
kubectl delete -f secrets.yaml
kubectl delete -f app-deployment.yaml
kubectl delete -f db-deployment.yaml
```

7. To reset a Kubernetes cluster (everything created by sudo kubeadm `init --control-plane-endpoint=k8smaster`):
```
sudo kubeadm reset
```
