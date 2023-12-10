1. Create AWS infrustructure by using [cloudformation-infrastructure-template.yaml](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesIntro/cloudformation-infrastructure-template.yaml).

Infrastructure contains 2 intances:
  - `devopsPublicEC2Instance` - will be used as Master Node
  - `devopsPublicEC2Instance2` - will be used as Worker Node


2. Login to `devopsPublicEC2Instance` by ssh.

Will look like: `ssh -i "DevOps-key.pem" ubuntu@100.24.72.98`, where:
  - `"DevOps-key.pem"` - ssh key
  - `ubuntu@100.24.72.98` - remote machine, `ubuntu` is user, `100.24.72.98` is public IP of remote machine

3. Rename host name and restart bash: 
```
sudo hostnamectl set-hostname "k8smaster"
exec bash
```

4. Update `/etc/hosts` to specify Worker and Master node with IP addresses.
```
echo "54.82.81.75 k8smaster" | sudo tee -a /etc/hosts \
echo "3.85.137.95 k8sworker" | sudo tee -a /etc/hosts
```

![ChangeHost](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesIntro/Screenshots/ChangeHost.png?raw=true)

5. Create and execute script file to install and run k8s:
  - `nano install_k8s.sh`
  - copy data from [install_k8s.sh](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesIntro/install_k8s.sh) and save
  - `sh install_k8s.sh true`, where `true` means that script will init k8s cluster

6. After [install_k8s.sh](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesIntro/install_k8s.sh) finish execution, in output can be found info how to join Worker Node, sth like: 
```
kubeadm join k8smaster:6443 --token u6z22k.fful61jc4aka1rwz \
        --discovery-token-ca-cert-hash sha256:5c2933802ce98dadc6769f49aa7364a47962a56972fd664e8bb46badd2d9595b 
```
![ClusterUp](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesIntro/Screenshots/ClusterUp.png?raw=true)

7. Login to `devopsPublicEC2Instance2` by ssh.

8. Rename host name and restart bash: 
```
sudo hostnamectl set-hostname "k8sworker"
exec bash
```

9. Repeat Step 4.

10. Repeat Step 5. but run script with parameter `false`: `sh install_k8s.sh false`.

10. Join to Master Node by command from Step 6. Then execute on Master Node `kubectl get nodes`:

![Nodes](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesIntro/Screenshots/Nodes.png?raw=true)

## All next steps should be done on Master Node

11. Create namespace: `kubectl create namespace my-n`.

12. Create nginx deplayment and expose as `NodePort` so we can access it by `<nodePublicId>:<port>`.
```
kubectl create deployment nginx-app --image=nginx -n=my-n --replicas=2
kubectl expose deployment nginx-app --type=NodePort -n=my-n --port=80
```
![Nginx](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesIntro/Screenshots/Nginx.png?raw=true)

13. Find which port k8s assigned to `nginx-app `: `kubectl get svc nginx-app -n=my-n`

14. Open port from previous Step 13. for security group `devopsPublicInstanceSecutiryGroup`.

15. Check nginx by `<nodePublicId>:<port>`.

![RunningNginxNodePort](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesIntro/Screenshots/RunningNginxNodePort.png?raw=true)

16. Create secrets for mysql:
```
kubectl create secret generic mysql-secret \
    -n=my-n \
    --from-literal=mysql-user=admin \
    --from-literal=mysql-password=password123
```

17. Run mysql pod:
```
kubectl run mysql-deployment \
        --image=mysql:latest \
        -n=my-n \
        --env="MYSQL_ROOT_PASSWORD=$(kubectl get secret mysql-secret -n my-n -o=jsonpath='{.data.mysql-password}' | base64 --decode)" \
        --env="MYSQL_DATABASE=mydb" \
        --env="MYSQL_USER=$(kubectl get secret mysql-secret -n my-n -o=jsonpath='{.data.mysql-user}' | base64 --decode)" \
        --env="MYSQL_PASSWORD=$(kubectl get secret mysql-secret -n my-n -o=jsonpath='{.data.mysql-password}' | base64 --decode)"
```

18. Try to connect to `mysql-deployment` pod: `kubectl exec -it mysql-deployment -n my-n -- /bin/bash`.
It will show error with port which is needed to be opened in security group `devopsPublicInstanceSecutiryGroup`.
After that try to connect once more:

![ConnectedToDbPod](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesIntro/Screenshots/ConnectedToDbPod.png?raw=true)

20. Clean up
```
kubectl delete deployment nginx-app -n my-n
kubectl delete pods -l run=mysql-deployment -n my-n
kubectl delete namespace my-n
sudo kubeadm reset
```
