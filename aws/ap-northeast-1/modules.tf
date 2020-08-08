module "batch" {
  source = "../../modules/batch/"

  iam_instance_profile   = module.iam.batch_instance_profile
  iam_batch_service_role = module.iam.batch_service_role

  vpc_sg            = module.vpc.sg
  vpc_public_subnet = module.vpc.public_subnet
}

module "cloudwatch" {
  source = "../../modules/cloudwatch/"
}

module "iam" {
  source = "../../modules/iam"
}

module "lambda" {
  source = "../../modules/lambda/"

}

module "vpc" {
  source      = "../../modules/vpc/"
  cidr_blocks = var.cidr_blocks
}

