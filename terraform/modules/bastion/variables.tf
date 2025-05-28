##################################################################################
### Variables for Bastion EC2 Instance ###
##################################################################################

variable "bastion_name" {
  description = "Unique name prefix for bastion resources"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the bastion host will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to deploy the bastion host"
  type        = list(string)
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "bastion_host_iam_instance_profile" {
  description = "Name of the bastion host IAM profile"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for bastion host"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "security_group_ids" {
  description = "List of security group IDs for Lambda VPC configuration"
  type        = list(string)
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
}

variable "private_key_file_permission" {
  description = "File permission for the private key PEM file"
  type        = string
}
