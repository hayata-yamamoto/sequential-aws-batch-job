resource "aws_vpc" "test_batch_vpc" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "test_batch_subnet" {
  vpc_id     = aws_vpc.test_batch_vpc.id
  cidr_block = "10.1.1.0/24"
}

resource "aws_security_group" "test_batch_sg" {
  name = "aws_batch_compute_environment_security_group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
