output "iam_test_batch_instance_profile" {
  value = aws_iam_instance_profile.test_batch_instance_profile
}

output "iam_test_batch_service_role" {
  value = aws_iam_role.test_batch_service_role
}
