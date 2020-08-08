variable "region" {
  type        = string
  description = "aws region"
  default     = "ap-northeast-1"
}

variable "cidr_blocks" {
  type = map(string)
  default = {
    "vpc"    = "10.1.0.0/16"
    "subnet" = "10.1.0.0/24"
  }
}
