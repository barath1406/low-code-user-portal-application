##################################################################################
#                                 Common Variables                               #
##################################################################################

variable "region" {
  description = "The AWS region where all Terraform operations are carried out."
  type        = string
}

variable "environment" {
  description = "Environment of the current account (e.g. Staging, Production)."
  type        = string
}

variable "tags" {
  description = "Tags for all resources."
  type        = map(string)
}


##################################################################################
#                               EKS Cluster Variables                            #
##################################################################################

variable "create_eks_cluster" {
  description = "Flag to enable or disable the EKS cluster creation."
  type        = bool
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "eks_cluster_version" {
  description = "Kubernetes cluster version."
  type        = string
}

variable "eks_enabled_log_types" {
  description = "List of EKS control plane logs to enable."
  type        = list(string)
}

variable "eks_patch_group_tags" {
  description = "Tags for the EKS nodegroup patch group."
  type        = map(string)
}

variable "eks_cluster_iam_role" {
  description = "IAM role for the EKS cluster."
  type        = string
}

variable "eks_nodegroup_iam_role" {
  description = "IAM role for the EKS nodegroup."
  type        = string
}

variable "eks_node_key_name" {
  description = "SSH key for the EKS worker nodes."
  type        = string
}

variable "user_access" {
  description = "IAM user with access to the EKS cluster."
  type        = string
}

variable "eks_cluster_sg_name" {
  description = "Name of the security group for the EKS cluster."
  type        = string
}

variable "eks_cluster_sg_description" {
  description = "Description of the EKS cluster security group."
  type        = string
}

variable "eks_endpoint_private_access" {
  description = "Enable private access to the EKS API server endpoint."
  type        = bool
}

variable "eks_endpoint_public_access" {
  description = "Enable public access to the EKS API server endpoint."
  type        = bool
}

variable "eks_public_access_cidrs" {
  description = "CIDRs allowed to access the EKS public API endpoint."
  type        = list(string)
}

variable "eks_network_config" {
  description = "CIDR block for the EKS service IP range."
}

variable "client_id_list" {
  description = "Client IDs for the OIDC provider."
  type        = list(string)
}

variable "thumbprint_list" {
  description = "Thumbprints for the OIDC provider."
  type        = list(string)
}

variable "eks_admin_policy_arn" {
  description = "ARN of the IAM policy granting admin access to EKS."
  type        = string
}

variable "eks_type" {
  description = "Type of EKS controller to deploy."
  type        = string
}

variable "authentication_mode" {
  description = "Authentication mode for the EKS controller."
  type        = string
}

variable "eks_cluster_sg_ingress_rules" {
  description = "Ingress rules for the EKS cluster security group."
  type = list(object({
    description              = string
    ip_protocol              = string
    from_port                = optional(number)
    to_port                  = optional(number)
    cidr_ipv4                = optional(string)
    source_security_group_id = optional(string)
  }))
  default = []
}

variable "eks_cluster_sg_egress_rules" {
  description = "Egress rules for the EKS cluster security group."
  type = list(object({
    description                   = string
    ip_protocol                   = string
    from_port                     = optional(number)
    to_port                       = optional(number)
    cidr_ipv4                     = optional(string)
    destination_security_group_id = optional(string)
  }))
  default = []
}


##################################################################################
#                              EKS NodeGroup Variables                           #
##################################################################################

variable "eks_nodegroup_sg_name" {
  description = "Name of the security group for the EKS nodegroup."
  type        = string
}

variable "eks_node_ami" {
  description = "AMI ID for EKS node group."
}

variable "eks_node_group_name" {
  description = "Name of the EKS node group."
}

variable "eks_node_name" {
  description = "Name for the individual EKS node."
}

variable "eks_node_group_launch_template_name" {
  description = "Name of the launch template used by the node group."
  type        = string
}

variable "eks_node_group_desired_size" {
  description = "Desired number of EKS worker nodes."
}

variable "eks_node_group_labels" {
  description = "Labels to apply to the EKS node group."
  type        = map(string)
}

variable "eks_node_group_max_size" {
  description = "Maximum number of EKS worker nodes."
}

variable "eks_node_group_min_size" {
  description = "Minimum number of EKS worker nodes."
}

variable "eks_node_group_capacity_type" {
  description = "Capacity type (e.g., ON_DEMAND or SPOT)."
}

variable "eks_node_group_instance_type" {
  description = "EC2 instance type for EKS nodes."
}

variable "eks_node_group_disk_size" {
  description = "Disk size (in GB) for EKS worker nodes."
}

variable "eks_nodegroup_sg_description" {
  description = "Description of the EKS nodegroup security group."
  type        = string
}

variable "device_name" {
  description = "Name of the block device"
  type        = string
}

variable "delete_on_termination" {
  description = "Whether the volume should be deleted on instance termination"
  type        = bool
}

variable "volume_size" {
  description = "Size of the volume in GiB"
  type        = number
}

variable "volume_type" {
  description = "Type of volume (e.g. gp2, gp3)"
  type        = string
}

variable "http_put_response_hop_limit" {
  description = "The desired HTTP PUT response hop limit"
  type        = number
}

variable "http_endpoint" {
  description = "Enable or disable the IMDSv2 HTTP endpoint"
  type        = string
}

variable "http_tokens" {
  description = "State of IMDSv2 token requirement"
  type        = string
}


variable "eks_nodegroup_sg_ingress_rules" {
  description = "Ingress rules for the EKS nodegroup security group."
  type = list(object({
    description              = string
    ip_protocol              = string
    from_port                = optional(number)
    to_port                  = optional(number)
    cidr_ipv4                = optional(string)
    source_security_group_id = optional(string)
  }))
  default = []
}

variable "eks_nodegroup_sg_egress_rules" {
  description = "Egress rules for the EKS nodegroup security group."
  type = list(object({
    description                   = string
    ip_protocol                   = string
    from_port                     = optional(number)
    to_port                       = optional(number)
    cidr_ipv4                     = optional(string)
    destination_security_group_id = optional(string)
  }))
  default = []
}


##################################################################################
#                                  VPC Variables                                 #
##################################################################################

variable "vpc1_name" {
  description = "Name tag for VPC1 resources."
  type        = string
}

variable "bastion_host_whitelist" {
  description = "List of IPs allowed to access the bastion host."
  type        = list(string)
}

variable "vpc1_cidr" {
  description = "CIDR block for VPC1."
  type        = string
}

variable "vpc2_name" {
  description = "Name tag for VPC2 resources."
  type        = string
}

variable "vpc2_cidr" {
  description = "CIDR block for VPC2."
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to be used in the region."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets."
  type        = bool
}

variable "enable_s3_endpoint" {
  description = "Enable an S3 VPC endpoint."
  type        = bool
}

variable "public_subnet_tags" {
  description = "Additional tags for public subnets."
  type        = map(string)
}

variable "alb_controller_public_subnet_tags" {
  description = "Tags for ALB controller's public subnets."
  type        = map(string)
}

variable "private_subnet_tags" {
  description = "Additional tags for private subnets."
  type        = map(string)
}

variable "peering_name" {
  description = "Name of the VPC peering connection."
  type        = string
}

variable "enabled" {
  description = "Enable/disable the VPC peering connection."
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable private DNS hostnames in the VPC."
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC."
  type        = bool
}

variable "enable_ipv6" {
  description = "Enable or disable IPv6 for the VPC."
  type        = bool
}

variable "assign_ipv6_address_on_creation" {
  description = "Automatically assign IPv6 addresses to instances on subnet creation."
  type        = bool
}

variable "map_public_ip_on_launch" {
  description = "Enable or disable automatic public IP assignment on launch."
  type        = bool
}

variable "private_subnet_newbits" {
  description = "Number of additional bits for private subnet CIDR blocks."
  type        = number
}

variable "public_subnet_newbits" {
  description = "Number of additional bits for public subnet CIDR blocks."
  type        = number
}

##################################################################################
# Bastion EC2 Variables
##################################################################################

# Unique name prefix for bastion resources
variable "bastion_name" {
  description = "Unique name prefix for bastion resources"
  type        = string
}

# SSH key pair name for connecting to bastion host
variable "bastion_key_name" {
  description = "SSH key pair name for bastion host"
  type        = string
}

# EC2 instance type (e.g., t3.micro)
variable "bastion_instance_type" {
  description = "EC2 instance type for bastion host"
  type        = string
}

# Tags to identify bastion hosts for patching
variable "bastion_patch_group_tags" {
  description = "Bastion Host Patch Group tag"
  type        = map(string)
}

# Whether to assign a public IP to bastion
variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
}

# File permission to apply to the PEM key (e.g., 0400)
variable "private_key_file_permission" {
  description = "File permission for the private key PEM file"
  type        = string
}

# IAM role for the bastion EC2 instance
variable "bastion_host_iam_role" {
  description = "Bastion Host IAM Role"
  type        = string
}

# Security Group (SG) name and description
variable "bastion_sg_name" {
  description = "Name for the Bastion EC2 SG"
  type        = string
}

variable "bastion_sg_description" {
  description = "Bastion SG description"
  type        = string
}

# Ingress/Egress rules for Bastion SG
variable "bastion_sg_ingress_rules" {
  description = "List of ingress rules for Bastion EC2"
  type = list(object({
    description              = string
    ip_protocol              = string
    from_port                = optional(number)
    to_port                  = optional(number)
    cidr_ipv4                = optional(string)
    source_security_group_id = optional(string)
  }))
  default = []
}

variable "bastion_sg_egress_rules" {
  description = "List of egress rules for Bastion EC2"
  type = list(object({
    description                   = string
    ip_protocol                   = string
    from_port                     = optional(number)
    to_port                       = optional(number)
    cidr_ipv4                     = optional(string)
    destination_security_group_id = optional(string)
  }))
  default = []
}


##################################################################################
# Lambda Variables
##################################################################################

# Lambda function basic configuration
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_handler" {
  description = "Lambda function handler"
  type        = string
}

variable "lambda_runtime" {
  description = "Lambda runtime environment"
  type        = string
}

variable "lambda_source_path" {
  description = "Path to the Lambda deployment package zip file"
  type        = string
}

variable "log_group_retention_in_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
}

variable "lambda_timeout" {
  description = "Timeout in seconds for the Lambda function"
  type        = number
}

# Lambda Security Group configuration
variable "lambda_sg_name" {
  description = "Name for the Lambda SG"
  type        = string
}

variable "lambda_sg_description" {
  description = "Description for Lambda security group"
  type        = string
}

# Optional encryption key for Lambda environment variables
variable "kms_key_arn" {
  description = "ARN of the KMS key to use for encrypting environment variables"
  type        = string
}

# Lambda SG ingress/egress rules
variable "lambda_sg_ingress_rules" {
  description = "List of ingress rules for Lambda"
  type = list(object({
    description              = string
    ip_protocol              = string
    from_port                = optional(number)
    to_port                  = optional(number)
    cidr_ipv4                = optional(string)
    source_security_group_id = optional(string)
  }))
  default = []
}

variable "lambda_sg_egress_rules" {
  description = "List of egress rules for Lambda"
  type = list(object({
    description                   = string
    ip_protocol                   = string
    from_port                     = optional(number)
    to_port                       = optional(number)
    cidr_ipv4                     = optional(string)
    destination_security_group_id = optional(string)
  }))
  default = []
}

# S3 path configuration for Lambda artifacts
variable "s3_prefix" {
  description = "S3 prefix path"
  type        = string
}

variable "s3_suffix" {
  description = "S3 suffix path"
  type        = string
}

# Access control for Lambda S3 bucket object
variable "acl" {
  description = "The canned ACL to apply (e.g., private, public-read, etc.)"
  type        = string
}


##################################################################################
# Lambda Role
##################################################################################

variable "lambda_iam_role_name" {
  description = "IAM Role name for Lambda"
  type        = string
}


##################################################################################
# S3 Bucket
##################################################################################

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}


##################################################################################
# RDS Database Variables
##################################################################################

# Core RDS configuration
variable "cluster_identifier" {
  description = "RDS cluster identifier"
  type        = string
}

variable "rds_monitoring_role" {
  description = "RDS Role Name"
  type        = string
}

variable "database_name" {
  description = "DB name"
  type        = string
}

variable "master_username" {
  description = "DB master username"
  type        = string
}

# RDS SG configuration
variable "rds_db_sg_name" {
  description = "Name for the RDS DB SG"
  type        = string
}

variable "rds_db_sg_description" {
  description = "RDS DB security group description"
  type        = string
}

# Optional ingress/egress rules for RDS SG
variable "rds_db_sg_ingress_rules" {
  description = "List of ingress rules for RDS DB SG"
  type = list(object({
    description              = string
    ip_protocol              = string
    from_port                = optional(number)
    to_port                  = optional(number)
    cidr_ipv4                = optional(string)
    source_security_group_id = optional(string)
  }))
  default = []
}

variable "rds_db_sg_egress_rules" {
  description = "List of egress rules for RDS DB SG"
  type = list(object({
    description                   = string
    ip_protocol                   = string
    from_port                     = optional(number)
    to_port                       = optional(number)
    cidr_ipv4                     = optional(string)
    destination_security_group_id = optional(string)
  }))
  default = []
}

# RDS cluster and instance parameters
variable "cluster_parameters" {
  description = "List of DB cluster parameters"
  type        = list(map(string))
}

variable "instance_parameters" {
  description = "List of DB instance parameters"
  type        = list(map(string))
}

# Monitoring, encryption, backup, and availability configuration
variable "monitoring_interval" {
  description = "Monitoring interval in seconds"
  type        = string
}

variable "create_random_password" {
  description = "Whether to create a random password"
  type        = bool
}

variable "secrets_recovery_window_in_days" {
  description = "Days AWS Secrets Manager waits before permanent delete"
  type        = number
}

variable "backup_retention_period" {
  description = "Days to retain RDS backups"
  type        = number
}

variable "port" {
  description = "Database port (e.g., 3306)"
  type        = number
}

variable "storage_encrypted" {
  description = "Whether storage is encrypted"
  type        = bool
}

variable "kms_key_id" {
  description = "KMS Key ARN for encryption"
  type        = string
}

variable "instance_count" {
  description = "Number of RDS instances"
  type        = number
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot before deletion"
  type        = bool
}

variable "publicly_accessible" {
  description = "Whether RDS is publicly accessible"
  type        = bool
}

variable "apply_immediately" {
  description = "Apply changes immediately or during next maintenance window"
  type        = bool
}

variable "auto_minor_version_upgrade" {
  description = "Enable automatic minor upgrades"
  type        = bool
}

variable "enabled_cloudwatch_logs_exports" {
  description = "CloudWatch logs to enable"
  type        = list(string)
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
}

variable "iam_database_authentication_enabled" {
  description = "Enable IAM DB authentication"
  type        = bool
}

variable "engine_version" {
  description = "Aurora MySQL engine version"
  type        = string
}

variable "preferred_backup_window" {
  description = "Daily backup window"
  type        = string
}

variable "preferred_maintenance_window" {
  description = "Weekly maintenance window"
  type        = string
}

variable "instance_class" {
  description = "DB instance type"
  type        = string
}

variable "parameter_group_family" {
  description = "DB parameter group family"
  type        = string
}


##################################################################################
# Helm / EKS Load Balancer Controller Variables
##################################################################################

variable "namespace" {
  description = "Kubernetes namespace for the Load Balancer Controller"
  type        = string
}

variable "service_account_name" {
  description = "Name of the service account"
  type        = string
}

variable "lb_controller_policy_name" {
  description = "IAM policy name for the controller"
  type        = string
}

variable "create_role" {
  description = "Whether to create IAM role"
  type        = bool
}

variable "lb_controller_label" {
  description = "Helm release name for the controller"
  type        = string
}

variable "app_namespace" {
  description = "Application namespace"
  type        = string
}

variable "create_service_account" {
  description = "Whether to create service account"
  type        = bool
}


##################################################################################
# Application ALB (User Portal)
##################################################################################

variable "user_portal_alb_name" {
  description = "ALB name for user portal"
  type        = string
}

variable "irsa_user_portal_policy_name" {
  description = "IAM policy name for user portal"
  type        = string
}

variable "irsa_user_portal_policy_description" {
  description = "Description for user portal IAM policy"
  type        = string
}

variable "irsa_user_portal_role_name" {
  description = "IAM role name for user portal"
  type        = string
}

variable "eks_cluster_iam_role_path" {
  description = "IAM role path for EKS cluster"
  type        = string
}


##################################################################################
# Route53 Variables
##################################################################################

variable "route53_zone_name" {
  description = "Route53 hosted zone domain name"
  type        = string
}

variable "record_type" {
  description = "DNS record type (e.g., A, CNAME)"
  type        = string
}

variable "evaluate_target_health" {
  description = "Whether to evaluate target health in Route53"
  type        = bool
}


##################################################################################
# WAF Web ACL Variables
##################################################################################

variable "whitelist_ips" {
  description = "List of IPs to whitelist"
  type        = list(string)
}

variable "waf_name" {
  description = "WAF Web ACL name"
  type        = string
}

variable "waf_description" {
  description = "WAF Web ACL description"
  type        = string
}

variable "ip_set_name" {
  description = "WAF IP set name"
  type        = string
}

variable "ip_set_description" {
  description = "WAF IP set description"
  type        = string
}

variable "metrics_enabled" {
  description = "Enable WAF metrics"
  type        = bool
}

variable "sampled_requests" {
  description = "Enable WAF sampled requests"
  type        = bool
}

variable "default_action" {
  description = "Default WAF action"
  type        = string
  validation {
    condition     = contains(["allow", "block"], var.default_action)
    error_message = "Default action must be either 'allow' or 'block'."
  }
}

# WAF Rule and Metric Names
variable "rule_whitelist_name" {
  description = "Whitelist rule name"
  type        = string
}

variable "rule_ip_rep_name" {
  description = "IP reputation rule name"
  type        = string
}

variable "rule_anon_ip_name" {
  description = "Anonymous IP rule name"
  type        = string
}

variable "rule_sqli_name" {
  description = "SQL injection rule name"
  type        = string
}

variable "metric_whitelist_name" {
  description = "Whitelist metric name"
  type        = string
}

variable "metric_ip_rep_name" {
  description = "IP reputation metric name"
  type        = string
}

variable "metric_anon_ip_name" {
  description = "Anonymous IP metric name"
  type        = string
}

variable "metric_sqli_name" {
  description = "SQLi metric name"
  type        = string
}

variable "metric_waf_name" {
  description = "WAF ACL metric name"
  type        = string
}


##################################################################################
# User Portal Application Variables
##################################################################################

variable "user_portal_name" {
  description = "User portal Helm release name"
  type        = string
}

variable "user_portal_namespace" {
  description = "User portal Kubernetes namespace"
  type        = string
}

variable "user_portal_create_namespace" {
  description = "Whether to create user portal namespace"
  type        = bool
}

variable "user_portal_chart_path" {
  description = "Path to Helm chart for user portal"
  type        = string
}

variable "app_service_account_name" {
  description = "Application service account name"
  type        = string
}
