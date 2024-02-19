resource "aws_instance" "ec2" {
  # ami = data.ubuntu.id
  ami = var.instance_ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  security_groups = [var.security_groups_name]
  key_name = var.ssh_key_name

  tags = {
    Name = var.instance_name
    Role = var.instance_role
    Env = var.instance_env
  }
}

# resource "aws_instance" "jenkins-controller" {
#   ami                    = data.ubuntu.id
#   instance_type          = var.instance_type
#   subnet_id              = aws_subnet.my-public-subnet.id
#   vpc_security_group_ids = [aws_security_group.my-sg.id]
#   key_name               = var.ssh_key_name
#   tags = {
#     Name = "jenkins-controller-tg"
#     Env  = "prod"
#     Role = "jenkins"
#   }
# }

# resource "aws_instance" "app-server" {
#   ami                    = data.ubuntu.id
#   instance_type          = var.instance_type
#   subnet_id              = aws_subnet.my-public-subnet.id
#   vpc_security_group_ids = [aws_security_group.my-sg.id]
#   key_name               = var.ssh_key_name
#   tags = {
#     Name = "app-server-tg"
#     Env  = "prod"
#     Role = "application"
#   }
# }