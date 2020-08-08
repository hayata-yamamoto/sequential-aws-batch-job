####################
# Instance Profile #
####################
data "aws_iam_policy_document" "batch_instance_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "batch_instance_role" {
  name               = "batch_instance_role"
  assume_role_policy = data.aws_iam_policy_document.batch_instance_role_policy_document.json
}

resource "aws_iam_role_policy_attachment" "batch_instance_role_attachment" {
  role       = aws_iam_role.batch_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "batch_instance_profile" {
  name = "batch_instance_profile"
  role = aws_iam_role.batch_instance_role.name
}

##########################
# AWS Batch Service Role # 
##########################
data "aws_iam_policy_document" "batch_service_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "batch_service_role" {
  name               = "batch_service_role"
  assume_role_policy = data.aws_iam_policy_document.batch_service_role_policy_document.json
}

resource "aws_iam_role_policy_attachment" "batch_service_role_attachment" {
  role       = aws_iam_role.batch_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

#######################
# Batch Configuration #
#######################
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

    instance_role = aws_iam_instance_profile.batch_instance_profile.arn
    instance_type = ["optimal"]

    security_group_ids = [var.vpc_sg.id]
    subnets            = [var.vpc_public_subnet.id]

    tags = {
      Name = "batch_job"
    }
  }

  service_role = aws_iam_role.batch_service_role.arn
  state        = "ENABLED"
  type         = "MANAGED"
  depends_on   = [aws_iam_role_policy_attachment.batch_service_role_attachment]

  lifecycle {
    ignore_changes = [compute_resources]
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
