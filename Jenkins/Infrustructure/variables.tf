variable "region" {
  description = "AWS Region"
  type        = string
}

variable "my_vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  type        = string
}

variable "ami_id" {
  description = "AMI ID Ubuntu"
  type        = string
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "ssh_key_name" {
  description = "SSH Key Name"
  type        = string
}

variable "protocol_type_all" {
  description = "Value which means all possible Internet protocols"
  type        = number
}

variable "port_all" {
  description = "Value which means all possible ports"
  type        = number
}

variable "port_ssh" {
  description = "SSH port"
  type        = number
}