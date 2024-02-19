variable "sg_name" {
  type = string
}

variable "sg_description" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "sg_ingress_rules" {
  description = "List of ingress rules"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "sg_egress_rules" {
  description = "List of egress rules"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

# variable "protocol_type_all" {
#   description = "Value which means all possible Internet protocols"
#   type        = number
#   default = -1
# }

# variable "port_all" {
#   description = "Value which means all possible ports"
#   type        = number
#   default = 0
# }

# variable "port_ssh" {
#   description = "SSH port"
#   type        = number
#   default = 22
# }