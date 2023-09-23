data "archive_file" "lambda_hello_world" {
  type        = "zip"
  source_file = "lambda_hello_world/index.mjs"
  output_path = "lambda_hello_world.zip"
}

resource "aws_lambda_function" "lambda_hello_world" {
  filename      = "lambda_hello_world.zip"
  function_name = "lambda_hello_world"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  description   = "Lambda returning 'Hello World !'."

  source_code_hash = data.archive_file.lambda_hello_world.output_base64sha256

  runtime = "nodejs18.x"
}