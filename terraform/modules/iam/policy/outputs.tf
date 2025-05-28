##################################################################################
### Outputs for IAM Policy                                                     ###
##################################################################################

# IAM Policy Information
output "policy_arn" {
  description = "ARN of the created IAM policy"
  value       = aws_iam_policy.irsa_user_portal_policy.arn
}

output "policy_name" {
  description = "Name of the created IAM policy"
  value       = aws_iam_policy.irsa_user_portal_policy.name
}
