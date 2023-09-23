data "archive_file" "lambda_authorizer" {
  type        = "zip"
  source_file = "lambda_authorizer/index.mjs"
  output_path = "lambda_authorizer.zip"
}

resource "aws_lambda_function" "lambda_authorizer" {
  filename      = "lambda_authorizer.zip"
  function_name = "lambda_authorizer"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  description   = "Lambda authorizing requests containing 'please-visit-https://linoleparquet.github.io' as their Authorization Header."

  source_code_hash = data.archive_file.lambda_authorizer.output_base64sha256

  runtime = "nodejs18.x"
}