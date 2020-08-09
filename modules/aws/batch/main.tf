resource "aws_batch_job_definition" "jobA" {
  name                 = "jobA"
  type                 = "container"
  container_properties = <<CONTAINER_PROPERTIES
{
    "command": ["echo", "JobA"],
    "image": "bash:latest",
    "memory": 500,
    "vcpus": 1
}
CONTAINER_PROPERTIES
}

resource "aws_batch_job_definition" "jobB" {
  name                 = "jobB"
  type                 = "container"
  container_properties = <<CONTAINER_PROPERTIES
{
    "command": ["echo", "JobB"],
    "image": "bash:latest",
    "memory": 500,
    "vcpus": 1
}
CONTAINER_PROPERTIES
}


resource "aws_batch_compute_environment" "compute_environment" {
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
      Name = "batch_job"
    }
  }

  service_role = var.iam_aws_batch_service_role.arn
  state        = "ENABLED"
  type         = "MANAGED"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [compute_resources]
  }

}

resource "aws_batch_job_queue" "job_queue" {
  name     = "aws_batch_job_queue"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    aws_batch_compute_environment.compute_environment.arn
  ]
}
