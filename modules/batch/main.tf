resource "aws_batch_job_definition" "batch_jobA" {
  name                 = "batch_jobA"
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

resource "aws_batch_job_definition" "batch_jobB" {
  name                 = "batch_jobB"
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


resource "aws_batch_compute_environment" "batch_job_compute_environment" {
  compute_environment_name_prefix = "batch_job_"

  compute_resources {
    type                = "EC2"
    allocation_strategy = "BEST_FIT"

    desired_vcpus = 2
    min_vcpus     = 0
    max_vcpus     = 2

    instance_role = var.iam_instance_profile.arn
    instance_type = ["optimal"]

    security_group_ids = [var.vpc_sg.id]
    subnets            = [var.vpc_public_subnet.id]

    tags = {
      Name = "test_batch_job_${terraform.workspace}"
    }

  service_role                    = var.iam_batch_service_role.arn
  state                           = "ENABLED"
  type                            = "MANAGED"
  depends_on = [var.iam_batch_service_role_policy_attachment]
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_batch_job_queue" "batch_job_queue" {
  name     = "batch_job_queue"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    aws_batch_compute_environment.batch_job_compute_environment.arn
  ]
}
