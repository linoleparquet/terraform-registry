output "unit_test" {
  description = "Command to test the deployed endpoint."
  value       = "curl -H 'Authorization: please-visit-https://linoleparquet.github.io' https://${aws_api_gateway_rest_api.this.id}.execute-api.ca-central-1.amazonaws.com/${aws_api_gateway_stage.this.stage_name}/lambda-authorizer-endpoint"
}
