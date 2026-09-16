
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/jenkins-terraform-hello-world"
  retention_in_days = 14 
}

resource "aws_lambda_function" "hello_world" {
  function_name = "jenkins-terraform-hello-world"
  role          = aws_iam_role.lambda_role.arn

  runtime = "python3.12"
  handler = "app.lambda_handler_v1"

  filename = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
  publish = true
  logging_config {
    log_format = "Text" # Or "JSON"
    log_group  = aws_cloudwatch_log_group.lambda_logs.name
  }

  # Ensure the log group is built before the Lambda executes to prevent auto-creation conflicts
  depends_on = [
    aws_cloudwatch_log_group.lambda_logs,
    aws_iam_role_policy_attachment.lambda_logs,
	]

  timeout = 10
}
