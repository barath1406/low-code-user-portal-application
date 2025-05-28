##################################################################################
### Outputs for Helm Module                                                     ###
##################################################################################

# Output the ARN of the IAM policy for the Load Balancer Controller
output "iam_policy_arn" {
  description = "ARN of the IAM policy for the Load Balancer Controller"
  value       = aws_iam_policy.lb_controller.arn
}

# Output the ARN of the IAM role for the Load Balancer Controller
output "iam_role_arn" {
  description = "ARN of the IAM role for the Load Balancer Controller"
  value       = module.lb_controller_role.iam_role_arn
}

# Output the name of the Kubernetes service account
output "service_account_name" {
  description = "Name of the Kubernetes service account"
  value       = var.service_account_name
}
