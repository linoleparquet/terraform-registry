resource "aws_api_gateway_rest_api" "this" {
  name        = "api_gateway_with_lambda_authorizer"
  body        = data.template_file.open_api.rendered
  description = "API Gateway exposing a endpoint secured by a lambda authorizer."
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "v1"
}

data "template_file" "open_api" {
  template = file("open_api.yaml")

  vars = {
    lambda_hello_world_invoke_arn = "${aws_lambda_function.lambda_hello_world.invoke_arn}",
    lambda_authorizer_invoke_arn  = "${aws_lambda_function.lambda_authorizer.invoke_arn}"
  }
}