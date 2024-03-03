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

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "${var.vpc_name}-my-igw-tg"
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