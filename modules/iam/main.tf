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
  name               = "batch_instance_profile"
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
  name               = "aws_batch_service_role"
  assume_role_policy = data.aws_iam_policy_document.batch_service_role_policy_document.json
}

resource "aws_iam_role_policy_attachment" "batch_service_role_attachment" {
  role       = aws_iam_role.batch_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}
