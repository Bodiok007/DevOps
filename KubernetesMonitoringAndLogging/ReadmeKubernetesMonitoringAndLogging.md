1. Create AWS infrustructure by using [cloudformation-infrastructure-template.yaml](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/cloudformation-infrastructure-template.yaml).

Infrastructure contains 2 intances:
  - `devopsPublicEC2Instance` - will be used as Manager to connect to EKS.

2. Login to `devopsPublicEC2Instance` by ssh.

Will look like: `ssh -i "DevOps-key.pem" ubuntu@100.24.72.98`, where:
  - `"DevOps-key.pem"` - ssh key
  - `ubuntu@100.24.72.98` - remote machine, `ubuntu` is user, `100.24.72.98` is public IP of remote machine

3. Copy [configure_eks_manager_part1.sh](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/configure_eks_manager_part1.sh) and [configure_eks_manager_part2.sh](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/configure_eks_manager_part2.sh) to Manager.

4. Execute [configure_eks_manager_part1.sh](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/configure_eks_manager_part1.sh):

```
sh configure_eks_manager_part1.sh
```

5. Execute [configure_eks_manager_part2.sh](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/configure_eks_manager_part2.sh):

```
sh configure_eks_manager_part2.sh
```

6. Change configuration of Prometheus and Grafana from `ClusterIP` to `LoadBalancer` by executing next commands and finding line `type: ClusterIP` and replacing it with `type: LoadBalancer`:

```
sudo kubectl edit svc stable-kube-prometheus-sta-prometheus -n prometheus
sudo kubectl get svc -n prometheus

sudo kubectl edit svc stable-grafana -n prometheus 
sudo kubectl get svc -n prometheus
```

Will look like:
![ChangeServiceTypeClusterIPToLoadBalancer](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/Screenshots/ChangeServiceTypeClusterIPToLoadBalancer.png?raw=true)

7. Copy [secrets.yaml](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/secrets.yaml), [app-deployment.yaml](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/app-deployment.yaml) and [db-deployment.yaml](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/db-deployment.yaml) to Master.

8. Apply:
```
sudo kubectl apply -f secrets.yaml
sudo kubectl apply -f app-deployment.yaml
sudo kubectl apply -f db-deployment.yaml
```

9. Check Wordpress:
![RunningWordpress](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/Screenshots/RunningWordpress.png?raw=true)

10. Find Grafana admin password:
```
sudo kubectl get secrets -n prometheus stable-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```

11. Check Grafana, use some template:
![RunningWordpress](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/Screenshots/Grafana15760.png?raw=true)
![RunningWordpress](https://github.com/Bodiok007/DevOps/blob/develop/KubernetesMonitoringAndLogging/Screenshots/Grafana6417.png?raw=true)

12. Delete cluster:
```
sudo eksctl delete cluster --name devops-eks
```

If does not work, please follow official AWS doc: [Deleting an Amazon EKS cluster](https://docs.aws.amazon.com/eks/latest/userguide/delete-cluster.html).
