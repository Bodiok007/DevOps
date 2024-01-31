# Terraform Module: VPC

## Overview

This Terraform module sets up an Amazon Virtual Private Cloud (VPC) along with associated resources, including public and private subnets, an internet gateway for public subnet access, and a NAT gateway for private subnet internet access.

### Features:
- <b>VPC Configuration:</b> Creates a VPC with the specified CIDR block and a user-defined name. Enables DNS hostnames for the VPC.

- <b>Public and Private Subnets:</b> Defines public and private subnets within the VPC, allowing you to separate resources based on their network requirements.

- <b>Internet Gateway (IGW):</b> Establishes an internet gateway for public subnets to facilitate outbound internet access.

- <b>Network Address Translation (NAT) Gateway:</b> Sets up a NAT gateway for private subnets to enable instances in those subnets to access the internet.

## Usage

```
module "my_vpc" {
  source              = "github.com/your-org/vpc-module"
  vpc_name            = "my-vpc"
  my_vpc_cidr         = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24"]
}
```

## Variables

| Name                       | Description                                        | Type               |
|----------------------------|----------------------------------------------------|--------------------|
| `vpc_name`                 | Name of the VPC.                                   | string             |
| `my_vpc_cidr`              | CIDR block for the VPC.                            | string             |
| `public_subnet_cidrs`      | List of CIDR blocks for public subnets.            | list(string)       |
| `private_subnet_cidrs`     | List of CIDR blocks for private subnets.           | list(string)       |

## Outputs

| Name                        | Description                                        | Type   |
|-----------------------------|----------------------------------------------------|--------|
| `vpc_id`                    | ID of the created VPC.                            | string |
| `public_subnet_ids`         | List of IDs for public subnets.                    | list   |
| `private_subnet_ids`        | List of IDs for private subnets.                   | list   |
| `my_igw_id`                 | ID of the created internet gateway.                | string |
| `my_nat_gw`                 | ID of the created NAT gateway.                     | string |
