resource "aws_security_group" "my-sg" {
  name   = var.sg_name
  description = var.sg_description
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.sg_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  # ingress {
  #   from_port   = var.port_ssh
  #   to_port     = var.port_ssh
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # egress {
  #   from_port   = var.port_all
  #   to_port     = var.port_all
  #   protocol    = var.protocol_type_all
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

#   module "web_security_group" {
#   source = "./modules/security_group"

#   security_group_name        = "web-sg"
#   security_group_description = "Security group for web servers"

#   ingress_rules = [
#     {
#       from_port   = 80
#       to_port     = 80
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     },
#     {
#       from_port   = 443
#       to_port     = 443
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     },
#   ]
# }

  tags = {
    Name = var.sg_name
  }
}