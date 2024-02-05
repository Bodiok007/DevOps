region              = "us-east-1"
my_vpc_cidr         = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"

ami_id        = "ami-0fc5d935ebf8bc3bc"
instance_type = "t2.micro"
ssh_key_name  = "DevOps-key"

protocol_type_all = -1
port_all          = 0
port_ssh          = 22