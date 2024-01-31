resource "aws_vpc" "my-vpc" {
  cidr_block = var.my_vpc_cidr
  #   enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "my-public-subnet" {
  vpc_id                  = aws_vpc.my-vpc.id
  for_each                = { for idx, cidr in var.public_subnet_cidrs : idx => cidr }
  cidr_block              = each.value
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-my-public-subnet-tg-${each.key}"
  }
}

resource "aws_subnet" "my-private-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  for_each   = { for idx, cidr in var.private_subnet_cidrs : idx => cidr }
  cidr_block = each.value
  tags = {
    Name = "${var.vpc_name}-my-private-subnet-tg-${each.key}"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "${var.vpc_name}-my-igw-tg"
  }
}

resource "aws_eip" "my_elastic_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "my-nat-gw" {
  subnet_id     = values(aws_subnet.my-public-subnet)[0].id
  allocation_id = aws_eip.my_elastic_ip.id

  tags = {
    Name = "${var.vpc_name}-my-nat-gw"
  }
}

resource "aws_route_table" "my-public-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "${var.vpc_name}-my-public-rt-tg"
  }
}

resource "aws_route_table_association" "my-public-subnet-association" {
  for_each       = aws_subnet.my-public-subnet
  route_table_id = aws_route_table.my-public-rt.id
  subnet_id      = each.value.id
}

resource "aws_route_table" "my-private-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my-nat-gw.id
  }

  tags = {
    Name = "${var.vpc_name}-my-private-rt-tg"
  }
}

resource "aws_route_table_association" "my-private-subnet-association" {
  for_each       = aws_subnet.my-private-subnet
  route_table_id = aws_route_table.my-private-rt.id
  subnet_id      = each.value.id
}