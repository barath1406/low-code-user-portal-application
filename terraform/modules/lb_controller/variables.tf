##################################################################################
### Variables for Helm Module                                                   ###
##################################################################################

# Variables for network configuration and namespace
variable "subnet_ids" {
  description = "List of subnet IDs to tag for the load balancer"
  type        = list(string)
  default     = []
}

variable "namespace" {
  description = "Kubernetes namespace for the Load Balancer Controller"
  type        = string
}

# Variables for service account creation and IAM policy
variable "create_service_account" {
  description = "Whether to create a service account"
  type        = bool
}

variable "service_account_name" {
  description = "Name of the service account"
  type        = string
}

# IAM policy and role creation
variable "lb_controller_policy_name" {
  description = "Name of the IAM policy"
  type        = string
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

# Tags and OIDC settings for the EKS cluster
variable "tags" {
  description = "Tags for the EKS Cluster SG"
  type        = map(any)
}

variable "oidc_issuer" {
  description = "OIDC Issuer of the EKS cluster"
  type        = string
}

# Flags for role creation and Helm release label
variable "create_role" {
  description = "Whether to create the IAM role"
  type        = bool
}

variable "lb_controller_label" {
  description = "Helm release name of the AWS Load Balancer Controller"
  type        = string
}
