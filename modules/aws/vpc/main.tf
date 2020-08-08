resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_blocks["vpc"]
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    "Name" = "batch-job"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.availability_zone
  cidr_block              = var.cidr_blocks["subnet"]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "batch-job"
  }
}

resource "aws_security_group" "sg" {
  name   = "batch_security_group"
  vpc_id = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "test_batch"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.cidr_blocks["global"]
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt-assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}
