data "aws_ami" "ubuntu" {
  filter {
    name = "name"
    values = ["*ubuntu-jammy-22.04-amd64-server*"]
  }
  most_recent = true
}