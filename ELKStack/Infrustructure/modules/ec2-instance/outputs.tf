# output "instance_id" {
#   value = data.aws_ami.ubuntu.id
# }

output "instance_public_ip" {
  value = aws_instance.ec2.public_ip
}