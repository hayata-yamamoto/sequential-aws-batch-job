variable "access_key" {}
variable "secret_key" {}

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
    "global" = "0.0.0.0/0"
  }
}
