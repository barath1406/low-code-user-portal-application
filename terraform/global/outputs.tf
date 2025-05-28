##################################################################################
### Outputs of EKS Cluster Role ###
##################################################################################

# Outputs for the EKS Cluster IAM Role
output "eks_cluster_iam_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  value       = module.eks_cluster_iam_role.iam_role_arn
}

output "eks_cluster_iam_role_id" {
  description = "ID of the EKS cluster IAM role"
  value       = module.eks_cluster_iam_role.iam_role_id
}

output "eks_cluster_iam_role_name" {
  description = "Name of the EKS cluster IAM role"
  value       = module.eks_cluster_iam_role.iam_role_name
}

output "eks_cluster_iam_role_unique_id" {
  description = "Unique ID of the EKS cluster IAM role"
  value       = module.eks_cluster_iam_role.iam_role_unique_id
}

output "eks_cluster_iam_role_policy_names" {
  description = "Policy names attached to the EKS cluster IAM role"
  value       = module.eks_cluster_iam_role.iam_role_policy_names
}

output "eks_cluster_iam_role_policy_arns" {
  description = "Policy ARNs attached to the EKS cluster IAM role"
  value       = module.eks_cluster_iam_role.iam_role_policy_arns
}

output "eks_cluster_iam_role_custom_policy_arns" {
  description = "Custom policy ARNs attached to the EKS cluster IAM role"
  value       = module.eks_cluster_iam_role.iam_role_custom_policy_arns
}

output "eks_cluster_iam_instance_profile_name" {
  description = "Instance profile name of the EKS cluster IAM role"
  value       = module.eks_cluster_iam_role.iam_instance_profile_name
}

output "eks_cluster_iam_instance_profile_arn" {
  description = "Instance profile ARN of the EKS cluster IAM role"
  value       = module.eks_cluster_iam_role.iam_instance_profile_arn
}

##################################################################################
### Outputs of EKS Nodegroup Role ###
##################################################################################

# Outputs for the EKS Nodegroup IAM Role
output "eks_nodegroup_iam_role_arn" {
  description = "ARN of the EKS nodegroup IAM role"
  value       = module.eks_nodegroup_iam_role.iam_role_arn
}

output "eks_nodegroup_iam_role_id" {
  description = "ID of the EKS nodegroup IAM role"
  value       = module.eks_nodegroup_iam_role.iam_role_id
}

output "eks_nodegroup_iam_role_name" {
  description = "Name of the EKS nodegroup IAM role"
  value       = module.eks_nodegroup_iam_role.iam_role_name
}

output "eks_nodegroup_iam_role_unique_id" {
  description = "Unique ID of the EKS nodegroup IAM role"
  value       = module.eks_nodegroup_iam_role.iam_role_unique_id
}

output "eks_nodegroup_iam_role_policy_names" {
  description = "Policy names attached to the EKS nodegroup IAM role"
  value       = module.eks_nodegroup_iam_role.iam_role_policy_names
}

output "eks_nodegroup_iam_role_policy_arns" {
  description = "Policy ARNs attached to the EKS nodegroup IAM role"
  value       = module.eks_nodegroup_iam_role.iam_role_policy_arns
}

output "eks_nodegroup_iam_role_custom_policy_arns" {
  description = "Custom policy ARNs attached to the EKS nodegroup IAM role"
  value       = module.eks_nodegroup_iam_role.iam_role_custom_policy_arns
}

output "eks_nodegroup_iam_instance_profile_name" {
  description = "Instance profile name of the EKS nodegroup IAM role"
  value       = module.eks_nodegroup_iam_role.iam_instance_profile_name
}

output "eks_nodegroup_iam_instance_profile_arn" {
  description = "Instance profile ARN of the EKS nodegroup IAM role"
  value       = module.eks_nodegroup_iam_role.iam_instance_profile_arn
}

##################################################################################
### Outputs of Bastion Host Role ###
##################################################################################

# Outputs for the Bastion Host IAM Role
output "bastion_host_iam_role_arn" {
  description = "ARN of the bastion host IAM role"
  value       = module.bastion_host_iam_role.iam_role_arn
}

output "bastion_host_iam_role_id" {
  description = "ID of the bastion host IAM role"
  value       = module.bastion_host_iam_role.iam_role_id
}

output "bastion_host_iam_role_name" {
  description = "Name of the bastion host IAM role"
  value       = module.bastion_host_iam_role.iam_role_name
}

output "bastion_host_iam_role_unique_id" {
  description = "Unique ID of the bastion host IAM role"
  value       = module.bastion_host_iam_role.iam_role_unique_id
}

output "bastion_host_iam_role_policy_names" {
  description = "Policy names attached to the bastion host IAM role"
  value       = module.bastion_host_iam_role.iam_role_policy_names
}

output "bastion_host_iam_role_policy_arns" {
  description = "Policy ARNs attached to the bastion host IAM role"
  value       = module.bastion_host_iam_role.iam_role_policy_arns
}

output "bastion_host_iam_role_custom_policy_arns" {
  description = "Custom policy ARNs attached to the bastion host IAM role"
  value       = module.bastion_host_iam_role.iam_role_custom_policy_arns
}

output "bastion_host_iam_instance_profile_name" {
  description = "Instance profile name of the bastion host IAM role"
  value       = module.bastion_host_iam_role.iam_instance_profile_name
}

output "bastion_host_iam_instance_profile_arn" {
  description = "Instance profile ARN of the bastion host IAM role"
  value       = module.bastion_host_iam_role.iam_instance_profile_arn
}

##################################################################################
### Outputs of Lambda IAM Role ###
##################################################################################

# Outputs for the Lambda IAM Role
output "lambda_iam_role_arn" {
  description = "ARN of the lambda IAM role"
  value       = module.lambda_iam_role.iam_role_arn
}

output "lambda_iam_role_id" {
  description = "ID of the lambda IAM role"
  value       = module.lambda_iam_role.iam_role_id
}

output "lambda_iam_role_name" {
  description = "Name of the lambda IAM role"
  value       = module.lambda_iam_role.iam_role_name
}

output "lambda_iam_role_unique_id" {
  description = "Unique ID of the lambda IAM role"
  value       = module.lambda_iam_role.iam_role_unique_id
}

output "lambda_iam_role_policy_names" {
  description = "Policy names attached to the lambda IAM role"
  value       = module.lambda_iam_role.iam_role_policy_names
}

output "lambda_iam_role_policy_arns" {
  description = "Policy ARNs attached to the lambda IAM role"
  value       = module.lambda_iam_role.iam_role_policy_arns
}

output "lambda_iam_role_custom_policy_arns" {
  description = "Custom policy ARNs attached to the lambda IAM role"
  value       = module.lambda_iam_role.iam_role_custom_policy_arns
}

output "lambda_iam_instance_profile_name" {
  description = "Instance profile name of the lambda IAM role"
  value       = module.lambda_iam_role.iam_instance_profile_name
}

output "lambda_iam_instance_profile_arn" {
  description = "Instance profile ARN of the lambda IAM role"
  value       = module.lambda_iam_role.iam_instance_profile_arn
}

##################################################################################
### Outputs of RDS IAM Role ###
##################################################################################

# Outputs for the RDS IAM Role
output "rds_iam_role_arn" {
  description = "ARN of the RDS IAM role"
  value       = module.rds_iam_role.iam_role_arn
}

output "rds_iam_role_id" {
  description = "ID of the RDS IAM role"
  value       = module.rds_iam_role.iam_role_id
}

output "rds_iam_role_name" {
  description = "Name of the RDS IAM role"
  value       = module.rds_iam_role.iam_role_name
}

output "rds_iam_role_unique_id" {
  description = "Unique ID of the RDS IAM role"
  value       = module.rds_iam_role.iam_role_unique_id
}

output "rds_iam_role_policy_names" {
  description = "Policy names attached to the RDS IAM role"
  value       = module.rds_iam_role.iam_role_policy_names
}

output "rds_iam_role_policy_arns" {
  description = "Policy ARNs attached to the RDS IAM role"
  value       = module.rds_iam_role.iam_role_policy_arns
}

output "rds_iam_role_custom_policy_arns" {
  description = "Custom policy ARNs attached to the RDS IAM role"
  value       = module.rds_iam_role.iam_role_custom_policy_arns
}

output "rds_iam_instance_profile_name" {
  description = "Instance profile name of the RDS IAM role"
  value       = module.rds_iam_role.iam_instance_profile_name
}

output "rds_iam_instance_profile_arn" {
  description = "Instance profile ARN of the RDS IAM role"
  value       = module.rds_iam_role.iam_instance_profile_arn
}

##################################################################################
### Outputs of IRSA User Portal Policy ###
##################################################################################

# Outputs for the IRSA User Portal Policy
output "irsa_user_portal_policy_arn" {
  description = "ARN of the IRSA user portal policy"
  value       = module.irsa_user_portal.policy_arn
}

output "irsa_user_portal_policy_name" {
  description = "Name of the IRSA user portal policy"
  value       = module.irsa_user_portal.policy_name
}
