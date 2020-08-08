resource "aws_batch_job_definition" "test_batch_jobA" {
  name                 = "test_batch_jobA"
  type                 = "container"
  container_properties = <<CONTAINER_PROPERTIES
{
    "command": ["echo", "$JobName"],
    "image": "bash:latest",
    "memory": 500,
    "environment": [
      {"name": "JobName", "value": "JobA"}
    ],
    "vcpus": 1
}
CONTAINER_PROPERTIES
}

resource "aws_batch_job_definition" "test_batch_jobB" {
  name                 = "test_batch_jobB"
  type                 = "container"
  container_properties = <<CONTAINER_PROPERTIES
{
    "command": ["echo", "$JobName"],
    "image": "bash:latest",
    "memory": 500,
    "environment": [
      {"name": "JobName", "value": "JobB"}
    ],
    "vcpus": 1
}
CONTAINER_PROPERTIES
}


resource "aws_batch_compute_environment" "test_batch_job_compute_environment" {
  compute_environment_name_prefix = "test_batch_job_"
  service_role                    = var.iam_batch_service_role.arn
  state                           = "ENABLED"
  type                            = "MANAGED"

  compute_resources {
    type                = "SPOT"
    allocation_strategy = "SPOT_CAPACITY_OPTIMIZED"

    desired_vcpus = 2
    min_vcpus     = 0
    max_vcpus     = 2

    instance_role = var.iam_instance_profile.arn
    instance_type = ["optimal"]

    security_group_ids = [var.vpc_test_batch_sg.id]
    subnets            = [var.vpc_test_batch_subnet.id]

    tags = {
      Name = "test_batch_job_${terraform.workspace}"
    }
  }
}

resource "aws_batch_job_queue" "test_batch_job_queue" {
  name     = "test_batch_job_queue"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    aws_batch_compute_environment.test_batch_job_compute_environment.arn
  ]
}
