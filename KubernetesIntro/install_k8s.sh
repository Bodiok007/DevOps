#!/bin/bash

disable_swap() {
    sudo swapoff -a
}

update_kernel_modules() {
    # These lines represent kernel modules that should be loaded at boot time. 
    # The overlay module is commonly used for overlay filesystem support, and br_netfilter is related to Linux bridge networking.
    sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

    # The modprobe command is used in Unix-like operating systems, including Linux, to manage kernel modules.
    # Kernel modules are pieces of code that can be dynamically loaded into or unloaded from the Linux kernel at runtime. They allow the kernel to add or remove functionality without the need to restart the system.
    sudo modprobe overlay
    sudo modprobe br_netfilter
}

configure_network() {
    # Configure network for k8s
    sudo tee /etc/sysctl.d/kubernetes.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

    # Apply these kernel settings
    sudo sysctl --system
}

install_secutiry_packages() {
    sudo apt update
    sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
}

install_containerd() {
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg

    # This command adds the Kubernetes package repository to the list of sources for the Advanced Package Tool (APT) on an Ubuntu system
    sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu/ $(lsb_release -cs) stable"

    sudo apt update

    # Containerd is an open-source container runtime that provides a core set of functionalities for container orchestration systems
    sudo apt install -y containerd.io
}

configure_containerd() {
    containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1

    sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
    cat /etc/containerd/config.toml | grep SystemdCgroup

    sudo systemctl restart containerd.service

    # This command enables the Containerd service to start automatically at boot time
    sudo systemctl enable containerd.service
}

install_k8s() {
    curl -fsSL "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/kubernetes-archive-keyring.gpg
    sudo add-apt-repository -y "deb https://apt.kubernetes.io/ kubernetes-xenial main"

    sudo apt update

    sudo apt install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl
}

# Only for master node
init_k8s() {
    sudo kubeadm init --control-plane-endpoint=k8smaster

    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf /$HOME/.kube/config
    sudo chown $(id -u):$(id -g) /$HOME/.kube/config

    kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
}

run() {
    if [[ $# -eq 0 ]]; then
        echo "No arguments provided."
        exit 1
    fi

    isMaster="$1"

    disable_swap
    update_kernel_modules
    configure_network
    install_secutiry_packages
    install_containerd
    configure_containerd
    install_k8s

    if [ "$isMaster" = "true" ]; then
        init_k8s
    fi   
}

run "$@"