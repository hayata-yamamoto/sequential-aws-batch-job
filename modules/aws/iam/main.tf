####################
# Instance Profile #
####################
data "aws_iam_policy_document" "instance_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance_role" {
  name               = "instance_role"
  assume_role_policy = data.aws_iam_policy_document.instance_role_policy_document.json
}

resource "aws_iam_role_policy_attachment" "instance_role_attachment" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.instance_role.name
}

##########################
# AWS Batch Service Role # 
##########################
data "aws_iam_policy_document" "aws_batch_service_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "aws_batch_service_role" {
  name               = "aws_batch_service_role"
  assume_role_policy = data.aws_iam_policy_document.aws_batch_service_role_policy_document.json
}

resource "aws_iam_role_policy_attachment" "aws_batch_service_role_attachment" {
  role       = aws_iam_role.aws_batch_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

########################
# Lambda Function Role #
######################## 
data "aws_iam_policy_document" "lambda_function_assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    effect = "Allow"
    sid    = ""
  }
}

data "aws_iam_policy_document" "lambda_function_role_policy_document" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "batch:SubmitJob"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_role" "lambda_function_role" {
  name               = "lambda_function_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_function_assume_role_policy_document.json
}

resource "aws_iam_role_policy" "lambda_function_role_policy" {
  name   = "batch_lambda_function_role_policy"
  role   = aws_iam_role.lambda_function_role.id
  policy = data.aws_iam_policy_document.lambda_function_role_policy_document.json
}
