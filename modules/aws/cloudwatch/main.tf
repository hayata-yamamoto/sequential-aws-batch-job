resource "aws_cloudwatch_event_rule" "lambda_invoke_event_rule" {
  name                = "lambda_invoke_event_rule"
  schedule_expression = "cron(0 0 1 * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_invoke_event_target" {
  rule = aws_cloudwatch_event_rule.lambda_invoke_event_rule.name
  arn  = var.lambda_batch_job_function.arn
}

