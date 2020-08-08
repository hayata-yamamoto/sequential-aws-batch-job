output "vpc_test_batch_vpc" {
  value = aws_vpc.test_batch_vpc
}

output "vpc_test_batch_subnet" {
  value = aws_subnet.test_batch_subnet
}

output "vpc_test_batch_sg" {
  value = aws_security_group.test_batch_sg
}
