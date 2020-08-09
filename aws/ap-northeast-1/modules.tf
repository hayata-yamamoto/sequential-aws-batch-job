module "batch" {
  source = "../../modules/aws/batch/"

  iam_instance_profile       = module.iam.instance_profile
  iam_aws_batch_service_role = module.iam.aws_batch_service_role

  vpc_sg            = module.vpc.sg
  vpc_public_subnet = module.vpc.public_subnet
}

module "cloudwatch" {
  source = "../../modules/aws/cloudwatch/"

  lambda_batch_job_function = module.lambda.batch_job_function
}

module "lambda" {
  source = "../../modules/aws/lambda/"

  batch_job_a_definition = module.batch.job_a_definition
  batch_job_b_definition = module.batch.job_b_definition
  batch_job_queue        = module.batch.job_queue

  cloudwatch_lambda_invoke_event_rule = module.cloudwatch.lambda_invoke_event_rule

  iam_lambda_function_role = module.iam.lambda_function_role
}

module "iam" {
  source = "../../modules/aws/iam"

  batch_job_queue = module.batch.job_queue
}

module "vpc" {
  source            = "../../modules/aws/vpc/"
  cidr_blocks       = var.cidr_blocks
  availability_zone = var.availability_zone
}

