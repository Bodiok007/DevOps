# Terraform Module: EC2 Instance

## Overview

This Terraform module provisions an EC2 instance on AWS with configurable parameters such as instance type, AMI, subnet, security groups, and tags.

## Usage

```
module "ec2_instance" {
  source            = "github.com/your-org/ec2-instance-module"
  instance_ami      = "ami-xxxxxxxxxxxxxxxxx"
  instance_type     = "t2.micro"
  subnet_id         = "subnet-xxxxxxxxxxxxxx"
  security_groups_name = "example-security-group"
  ssh_key_name      = "your-key-pair-name"
  instance_name     = "example-instance"
  instance_role     = "web-server"
  instance_env      = "production"
  # Add any additional configuration parameters as needed
}
```

## Variables

| Name                  | Description                                                   | Type   | Default      |
|-----------------------|---------------------------------------------------------------|--------|--------------|
| `instance_ami`        | ID of the Amazon Machine Image (AMI) to use for the instance. | string | -            |
| `instance_type`       | Type of the EC2 instance.                                     | string | -            |
| `subnet_id`           | ID of the subnet where the instance will be launched.         | string | -            |
| `security_groups_name`| Name of the security group for the instance.                  | string | -            |
| `ssh_key_name`        | Name of the key pair for SSH access.                          | string | `DevOps-key` |
| `instance_name`       | Name tag for the EC2 instance.                                | string | -            |
| `instance_role`       | Role tag for the EC2 instance.                                | string | -            |
| `instance_env`        | Environment tag for the EC2 instance.                         | string | -            |

## Outputs

| Name                 | Description                                    | Type   |
|----------------------|------------------------------------------------|--------|
| `instance_id`        | ID of the created EC2 instance.                | string |
| `instance_public_ip` | Public IP address of the EC2 instance.         | string |
| `instance_private_ip`| Private IP address of the EC2 instance.        | string |
