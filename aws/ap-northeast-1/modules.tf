module "batch" {
  source = "../../modules/aws/batch/"

  iam_instance_profile       = module.iam.instance_profile
  iam_aws_batch_service_role = module.iam.aws_batch_service_role

  vpc_sg            = module.vpc.sg
  vpc_public_subnet = module.vpc.public_subnet
}

module "cloudwatch" {
  source = "../../modules/aws/cloudwatch/"
}

module "lambda" {
  source = "../../modules/aws/lambda/"
}

module "iam" {
  source = "../../modules/aws/iam"
}

module "vpc" {
  source            = "../../modules/aws/vpc/"
  cidr_blocks       = var.cidr_blocks
  availability_zone = var.availability_zone
}

