# Lambda Function
resource "aws_lambda_function" "this" {
  filename         = var.source_code_path
  function_name    = "${var.function_name}-${var.environment}"
  role             = aws_iam_role.lambda_execution.arn
  handler          = var.handler
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  source_code_hash = filebase64sha256(var.source_code_path)

  environment {
    variables = {
      TENANT_ID      = var.azure_tenant_id
      CLIENT_ID      = var.azure_client_id
      CLIENT_SECRET  = var.azure_client_secret
      SENDER_USER_ID = var.sender_email
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.function_name}-${var.environment}"
    }
  )
}

# CloudWatch Log Group for Lambda
resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.function_name}-${var.environment}"
  retention_in_days = 14

  tags = merge(
    var.tags,
    {
      Name = "${var.function_name}-${var.environment}-logs"
    }
  )
}
