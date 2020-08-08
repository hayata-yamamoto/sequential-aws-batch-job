module "batch" {
  source = "../../modules/batch/"

  iam_instance_profile   = module.iam.iam_test_batch_instance_profile
  iam_batch_service_role = module.iam.iam_test_batch_service_role
  vpc_test_batch_sg      = module.vpc.vpc_test_batch_sg
  vpc_test_batch_subnet  = module.vpc.vpc_test_batch_subnet
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

module vpc {
  source = "../../modules/vpc/"
}

