# Terraform Module: Security Group

## Overview

This Terraform module provisions an AWS Security Group, allowing you to define and manage network access rules for your EC2 instances within a specified Virtual Private Cloud (VPC). Security Groups act as virtual firewalls for your instances, controlling inbound and outbound traffic based on defined rules.

## Usage

```
module "my_security_group" {
  source             = "github.com/your-org/security-group-module"
  sg_name            = "my-sg"
  sg_description     = "My Security Group"
  vpc_id             = "vpc-xxxxxxxxxxxxxxxxx"
  sg_ingress_rules   = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["10.0.0.0/16"] },
    # Add more ingress rules as needed
  ]
  sg_egress_rules    = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] },
    # Add more egress rules as needed
  ]
}
```

## Variables

| Name                  | Description                                       | Type               |
|-----------------------|---------------------------------------------------|--------------------|
| `sg_name`             | Name of the security group.                       | string             |
| `sg_description`      | Description of the security group.                | string             |
| `vpc_id`              | ID of the Virtual Private Cloud (VPC) where the security group will be created. | string |
| `sg_ingress_rules`    | List of ingress rules for the security group.     | list(object({}))   |
| `sg_egress_rules`     | List of egress rules for the security group.      | list(object({}))   |

<br />

`sg_ingress_rules` and `sg_egress_rules` Object Structure:

| Field          | Description                                     | Type               |
|-----------------|-------------------------------------------------|--------------------|
| `from_port`     | Starting port for the rule.                      | number             |
| `to_port`       | Ending port for the rule.                        | number             |
| `protocol`      | Protocol for the rule (e.g., "tcp", "udp", "icmp"). | string          |
| `cidr_blocks`   | List of CIDR blocks for the rule.                | list(string)       |



## Outputs

| Name                | Description                                   | Type   |
|---------------------|-----------------------------------------------|--------|
| `my_sg_id`          | ID of the created AWS Security Group.          | string |
