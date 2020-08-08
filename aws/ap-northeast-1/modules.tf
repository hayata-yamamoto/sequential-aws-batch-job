module "batch" {
  source = "../../modules/batch/"

  vpc_sg            = module.vpc.sg
  vpc_public_subnet = module.vpc.public_subnet
}

module "cloudwatch" {
  source = "../../modules/cloudwatch/"
}

module "lambda" {
  source = "../../modules/lambda/"

}

module "vpc" {
  source      = "../../modules/vpc/"
  cidr_blocks = var.cidr_blocks
}

