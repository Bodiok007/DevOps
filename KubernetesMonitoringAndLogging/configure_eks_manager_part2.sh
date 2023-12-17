update_cluster_configs() {
    # will work for root user, so all kubectl should be called with sudo
    # config will be in /root/.kube/config
    aws eks update-kubeconfig --name devops-eks --region us-east-1 # --kubeconfig $HOME/.kube/config
    sudo kubectl get nodes
}

add_repositories() {
    sudo helm repo add stable https://charts.helm.sh/stable
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
}

install_prometheus() {
    sudo kubectl create namespace prometheus

    helm repo update
    sudo helm install stable prometheus-community/kube-prometheus-stack -n prometheus 
    sudo kubectl get pods --namespace prometheus
}

run() {
    update_cluster_configs
    add_repositories
    install_prometheus
}

run