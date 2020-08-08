output "batch_job_definition_a" {
  value = aws_batch_job_definition.batch_jobA
}

output "batch_job_definition_b" {
  value = aws_batch_job_definition.batch_jobB
}

output "batch_compute_environment" {
  value = aws_batch_compute_environment.batch_job_compute_environment
}

output "batch_job_queue" {
  value = aws_batch_job_queue.batch_job_queue
}
