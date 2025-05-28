##################################################################################
### General Variables ###
##################################################################################

variable "region" {
  description = "AWS geographic region"
  default     = "us-east-1"
  type        = string
}

variable "environment" {
  description = "AWS environment (test, stage, prod, etc.)"
  type        = string
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
}

variable "enabled" {
  description = "Boolean value for enabling resources"
  type        = bool
}

variable "disabled" {
  description = "Boolean value for disabling resources"
  type        = bool
}

variable "assume_role_services" {
  description = "Map of assume role policies keyed by logical name"
  type        = map(list(string))
}

variable "iam_role_path" {
  description = "IAM Role Path"
  type        = string
}

variable "max_session_duration" {
  description = "Session duration of IAM Role"
  type        = string
}

variable "iam_description" {
  description = "Map of IAM role descriptions"
  type        = map(string)
}

##################################################################################
### Lambda Role Variables ###
##################################################################################

variable "lambda_iam_role_name" {
  description = "IAM Role name for Lambda"
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda Function Name"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 Bucket"
  type        = string
}

variable "lambda_iam_managed_policies" {
  description = "List of managed IAM policy ARNs to attach to Lambda role"
  type        = list(string)
}

##################################################################################
### EKS Cluster Role Variables ###
##################################################################################

variable "eks_cluster_iam_role" {
  description = "IAM Role name for EKS"
  type        = string
}

variable "eks_cluster_iam_managed_policies" {
  description = "List of managed IAM policies ARNs to attach to EKS role"
  type        = list(string)
}

variable "eks_service" {
  description = "Name of the service (e.g., EKS)"
  type        = string
}

##################################################################################
### EKS Nodegroup Role Variables ###
##################################################################################

variable "eks_nodegroup_iam_role" {
  description = "IAM Role name for EKS Nodegroup"
  type        = string
}

variable "eks_nodegroup_iam_managed_policies" {
  description = "List of managed IAM policies ARNs to attach to EKS Nodegroup role"
  type        = list(string)
}

##################################################################################
### Bastion Host Role Variables ###
##################################################################################

variable "bastion_host_iam_role" {
  description = "IAM Role name for Bastion Host"
  type        = string
}

variable "bastion_host_iam_managed_policies" {
  description = "List of managed IAM policies ARNs to attach to Bastion Host role"
  type        = list(string)
}

variable "bastion_service" {
  description = "Name of the service (e.g., Bastion Host)"
  type        = string
}

##################################################################################
### RDS Role Variables ###
##################################################################################

variable "rds_iam_role" {
  description = "IAM Role name for RDS"
  type        = string
}

variable "rds_iam_managed_policies" {
  description = "List of managed IAM policies ARNs to attach to RDS role"
  type        = list(string)
}

variable "rds_service" {
  description = "Name of the service (e.g., RDS)"
  type        = string
}

##################################################################################
### IRSA Policy Variables ###
##################################################################################

variable "irsa_user_portal_policy_name" {
  description = "Name of the IAM policy for user portal IRSA"
  type        = string
}

variable "irsa_user_portal_policy_description" {
  description = "Description for the IAM policy for user portal IRSA"
  type        = string
}
