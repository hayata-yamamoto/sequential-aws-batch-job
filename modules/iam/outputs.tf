output "batch_instance_profile" {
  value = aws_iam_instance_profile.batch_instance_profile
}

output "batch_service_role" {
  value = aws_iam_role.batch_service_role
}

output "batch_service_role_policy_attachment" {
  value = aws_iam_role_policy_attachment.batch_service_role_attachment
}
