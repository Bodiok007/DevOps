output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.my-public-subnet : subnet.id]
}

output "my_igw_id" {
  value = aws_internet_gateway.my-igw.id
}