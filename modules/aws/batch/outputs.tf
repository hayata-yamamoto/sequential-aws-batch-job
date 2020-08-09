output "job_a_definition" {
  value = aws_batch_job_definition.jobA
}

output "job_b_definition" {
  value = aws_batch_job_definition.jobB
}

output "compute_environment" {
  value = aws_batch_compute_environment.compute_environment
}

output "job_queue" {
  value = aws_batch_job_queue.job_queue
}
