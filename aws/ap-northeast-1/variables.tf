variable "region" {
  type        = string
  description = "aws region"
  default     = "ap-northeast-1"
}

variable "availability_zone" {
  type    = string
  default = "ap-northeast-1a"
}

variable "cidr_blocks" {
  type = map(string)
  default = {
    "vpc"    = "10.2.0.0/16"
    "subnet" = "10.2.0.0/24"
    "global" = "0.0.0.0/0"
  }
}
