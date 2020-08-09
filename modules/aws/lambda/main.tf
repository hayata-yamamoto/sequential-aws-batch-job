resource "aws_lambda_layer_version" "batch_job_function_layer" {
  layer_name       = "batch_job_function_layer"
  filename         = "${path.module}/functions/batch_job_function/build/layers.zip"
  source_code_hash = filebase64sha256("${path.module}/functions/batch_job_function/build/layers.zip")
}

resource "aws_lambda_function" "batch_job_function" {
  filename         = "${path.module}/functions/batch_job_function/build/function.zip"
  function_name    = "batch_job_function"
  handler          = "src/handler"
  role             = var.iam_lambda_function_role.arn
  memory_size      = 128
  runtime          = "python3.7"
  source_code_hash = filebase64sha256("${path.module}/functions/batch_job_function/build/function.zip")
  layers           = [aws_lambda_layer_version.batch_job_function_layer.arn]

  environment {
    variables = {
      BATCH_JOB_A_DEFINITION = "${var.batch_job_a_definition.name}:${var.batch_job_a_definition.revision}"
      BATCH_JOB_B_DEFINITION = "${var.batch_job_b_definition.name}:${var.batch_job_b_definition.revision}"
      BATCH_JOB_QUEUE        = var.batch_job_queue.name
    }
  }

  tags = {
    Name = "batch_job"
  }
}

resource "aws_lambda_permission" "lambda_invoke_permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.batch_job_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.cloudwatch_lambda_invoke_event_rule.arn
}
