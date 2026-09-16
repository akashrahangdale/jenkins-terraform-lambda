resource "aws_lambda_function" "hello_world" {
  function_name = "jenkins-terraform-hello-world"
  role          = aws_iam_role.lambda_role.arn

  runtime = "python3.12"
  handler = "app.lambda_handler_v1"

  filename = "${path.module}/lambda_function.zip"

  timeout = 10
}
