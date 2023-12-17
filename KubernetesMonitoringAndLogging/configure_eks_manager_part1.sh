# switch to root user
# sudo -i

AWS_ACCESS_KEY_ID="put_your_key_id"
AWS_SECRET_ACCESS_KEY="put_your_access_key"
AWS_DEFAULT_REGION ="put_your_default_region_or_make_empty"
AWS_OUTPUT_FORMAT="json"  # or any other desired output format

install_aws_cli() {
    sudo apt update
    sudo apt install unzip
    sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    sudo unzip awscliv2.zip
    sudo ./aws/install
    aws --version
}

# aws configure

configure_aws_keys() {
    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    aws configure set default.region $AWS_DEFAULT_REGION
    aws configure set default.output $AWS_OUTPUT_FORMAT

    # aws ec2 describe-instances
}

install_kubectl() {
    sudo curl --silent --location -o /usr/local/bin/kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl
    sudo chmod +x /usr/local/bin/kubectl
}

install_eksctl() {
    sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | sudo tar xz -C /usr/local/bin/
    eksctl version
}

install_helm() {
    sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    sudo chmod 700 get_helm.sh
    sudo ./get_helm.sh
    helm version
}

create_cluster() {
    # managed: is controled by aws, manager nodes; -nodes-min 2 --nodes-max 3: optional
    sudo eksctl create cluster --name devops-eks --region us-east-1 --node-type t3.small --managed --nodes 2 --nodes-min 2 --nodes-max 3
    eksctl get cluster --name devops-eks --region us-east-1
}

run() {
    install_aws_cli
    configure_aws_keys
    install_kubectl
    install_eksctl
    install_helm
    create_cluster
}

run

