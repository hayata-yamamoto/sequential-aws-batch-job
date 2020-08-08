module "batch" {
  source = "../../modules/batch/"

  iam_instance_profile       = module.iam.instance_profile
  iam_aws_batch_service_role = module.iam.aws_batch_service_role

  vpc_sg            = module.vpc.sg
  vpc_public_subnet = module.vpc.public_subnet
}

module "cloudwatch" {
  source = "../../modules/cloudwatch/"
}

module "lambda" {
  source = "../../modules/lambda/"
}

module "iam" {
  source = "../../modules/iam"
}

module "vpc" {
  source            = "../../modules/vpc/"
  cidr_blocks       = var.cidr_blocks
  availability_zone = var.availability_zone
}

