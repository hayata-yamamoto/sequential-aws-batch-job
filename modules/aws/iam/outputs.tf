output "instance_profile" {
  value = aws_iam_instance_profile.instance_profile
}

output "aws_batch_service_role" {
  value = aws_iam_role.aws_batch_service_role
}

output "lambda_function_role" {
  value = aws_iam_role.lambda_function_role
}
