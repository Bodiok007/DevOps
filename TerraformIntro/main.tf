provider "aws" {
  # access_key = ""
  # secret_key = ""
  region = "us-east-1"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = var.my_vpc_cidr
  #   enable_dns_hostnames = true
  tags = {
    Name = "my-vpc-tg"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-tg"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.private_subnet_cidr
  tags = {
    Name = "private-subnet-tg"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw-tg"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "public-rt-tg"
  }
}

resource "aws_route_table_association" "public-subnet-association" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.public-subnet.id
}

resource "aws_security_group" "my-sg" {
  name   = "my-sg-to-display"
  vpc_id = aws_vpc.my-vpc.id
  ingress {
    from_port   = var.port_ssh
    to_port     = var.port_ssh
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = var.port_all
    to_port     = var.port_all
    protocol    = var.protocol_type_all
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins-controller" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  key_name               = var.ssh_key_name
  tags = {
    Name = "jenkins-controller-tg"
    Env  = "prod"
    Role = "jenkins"
  }
}

resource "aws_instance" "app-server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  key_name               = var.ssh_key_name
  tags = {
    Name = "app-server-tg"
    Env  = "prod"
    Role = "application"
  }
}