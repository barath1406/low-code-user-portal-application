##################################################################################
### Outputs of IAM Role                                                        ###
##################################################################################

# IAM Role Information
output "iam_role_arn" {
  description = "The AWS ARN of the IAM Role"
  value       = aws_iam_role.iam_role.arn
}

output "iam_role_id" {
  description = "The ID of the IAM Role"
  value       = aws_iam_role.iam_role.id
}

output "iam_role_name" {
  description = "The name of the IAM Role"
  value       = aws_iam_role.iam_role.name
}

output "iam_role_unique_id" {
  description = "The stable and unique string identifying the role"
  value       = aws_iam_role.iam_role.unique_id
}

# IAM Role Policy Attachments
output "iam_role_policy_names" {
  description = "A list of IAM policy names attached to the IAM Role"
  value       = concat(aws_iam_policy.iam_policy.*.name, var.managed_iam_policies)
}

output "iam_role_policy_arns" {
  description = "A list of Amazon Resource Names (ARN) of the policies attached to the Role"
  value       = concat(aws_iam_policy.iam_policy.*.arn, var.managed_iam_policies)
}

output "iam_role_custom_policy_arns" {
  description = "ARNs of custom policies created in this module"
  value       = aws_iam_policy.iam_policy.*.arn
}

# IAM Instance Profile Information
output "iam_instance_profile_name" {
  value       = length(aws_iam_instance_profile.iam_instance_profile) > 0 ? aws_iam_instance_profile.iam_instance_profile[0].name : ""
  description = "The name of the IAM instance profile"
}

output "iam_instance_profile_arn" {
  value       = length(aws_iam_instance_profile.iam_instance_profile) > 0 ? aws_iam_instance_profile.iam_instance_profile[0].arn : ""
  description = "The ARN of the IAM instance profile"
}
