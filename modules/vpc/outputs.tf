output "vpc" {
  value = aws_vpc.vpc
}

output "public_subnet" {
  value = aws_subnet.subnet
}

output "sg" {
  value = aws_security_group.sg
}
