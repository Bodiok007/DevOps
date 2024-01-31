variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  # default     = "my-vpc-tg"
}

variable "my_vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  # default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDRs"
  type        = list(string)
  # default     = ["0.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private Subnet CIDRs"
  type        = list(string)
  # default     = ["0.0.2.0/24"]
}