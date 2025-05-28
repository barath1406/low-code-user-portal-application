##################################################################################
### Outputs of Lambda                                                         ###
##################################################################################

# CloudWatch Log Group Name for Lambda
output "lambda_log_group_name" {
  description = "Name of the CloudWatch Log Group for the Lambda function"
  value       = aws_cloudwatch_log_group.lambda_log_group.name
  sensitive   = false
}
