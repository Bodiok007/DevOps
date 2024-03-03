variable "instance_type" {
  description = "Instance Type"
  type        = string
  # default = "t2.micro"
}

variable "instance_ami" {
  description = "Instance AMI"
  type = string
}

variable "ssh_key_name" {
  description = "SSH Key Name"
  type        = string
  default = "DevOps-key"
}

variable "subnet_id" {
  description = "Subnet ID"
  type = string
}

variable "security_groups_name" {
  description = "SGs Name"
  type = string
}

variable "instance_name" {
  description = "Instance name"
  type = string
}

variable "instance_role" {
  description = "Instance role"
  type = string
}

variable "instance_env" {
  description = "Instance env"
  type = string
}