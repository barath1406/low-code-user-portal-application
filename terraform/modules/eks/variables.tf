##################################################################################
### Variables for EKS Cluster                                                    ###
##################################################################################

# EKS Cluster Basic Configuration
variable "eks_cluster_name" {
  description = "The name of the eks cluster."
  type        = string
}

variable "eks_cluster_version" {
  description = "Desired k8s version"
  type        = string
}

variable "eks_role_arn" {
  description = "ARN of the EKS role."
  type        = string
}

# User and Account Configuration
variable "user_access" {
  description = "IAM user name that will have access to EKS cluster"
  type        = string
}

variable "bastion_host_iam_role" {
  description = "IAM role that will have access to EKS cluster"
  type        = string
}

variable "account_nbr" {
  description = "Self account number"
  type        = string
}

# EKS Logging and Tagging
variable "eks_enabled_log_types" {
  description = "The enabled log types of the EKS cluster."
  type        = list(string)
}

variable "tags" {
  description = "Tags of the EKS Cluster."
  type        = map(string)
}

# Networking Configuration
variable "eks_network_config" {
  description = "Service IPv4 range."
  type        = string
}

variable "eks_subnet_ids" {
  description = "Subnet IDS of the eks subnet."
  type        = list(string)
}

variable "eks_endpoint_private_access" {
  description = "Make the private endpoints in EKS available."
  type        = bool
}

variable "eks_endpoint_public_access" {
  description = "Make the public endpoints in EKS available."
  type        = bool
}

variable "eks_public_access_cidrs" {
  description = "Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled."
  type        = list(string)
}

variable "eks_security_group_ids" {
  description = "EKS Security Groups"
  type        = list(string)
}

# VPC and Worker Configuration
variable "eks_vpc_id" {
  description = "EKS VPC id"
  type        = string
}

variable "eks_worker_vpc_cidr" {
  description = "CIDR of the EKS workers"
  type        = list(string)
}

# OIDC Configuration
variable "client_id_list" {
  description = "List of client IDs for the OIDC provider"
  type        = list(string)
}

variable "thumbprint_list" {
  description = "List of thumbprints for the OIDC provider"
  type        = list(string)
}

# EKS IAM Policy and Controller Configuration
variable "eks_admin_policy_arn" {
  description = "ARN of the EKS cluster admin policy"
  type        = string
}

variable "eks_type" {
  description = "The type of controller to deploy"
  type        = string
}

variable "authentication_mode" {
  description = "The authentication mode for the controller"
  type        = string
}
