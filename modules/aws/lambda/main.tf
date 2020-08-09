data "archive_file" "layer_zip" {
  type        = "zip"
  source_dir  = "${path.module}/functions/batch_job_function/build/layer"
  output_path = "${path.module}/build/batch_job_function/layer.zip"
}

data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "${path.module}/functions/batch_job_function/build/function"
  output_path = "${path.module}/build/batch_job_function/function.zip"
}

resource "aws_lambda_layer_version" "batch_job_function_layer" {
  layer_name       = "batch_job_function_layer"
  filename         = data.archive_file.layer_zip.output_path
  source_code_hash = data.archive_file.layer_zip.output_base64sha256
}

resource "aws_lambda_function" "batch_job_function" {
  filename         = data.archive_file.function_zip.output_path
  function_name    = "batch_job_function"
  handler          = "function.handler"
  role             = var.iam_lambda_function_role.arn
  memory_size      = 128
  runtime          = "python3.7"
  source_code_hash = data.archive_file.function_zip.output_base64sha256

  layers = [aws_lambda_layer_version.batch_job_function_layer.arn]

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
