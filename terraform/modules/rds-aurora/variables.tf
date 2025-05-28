##################################################################################
### Variables for Aurora RDS Cluster Configuration                           ###
##################################################################################

# Cluster Identifier and Engine
variable "cluster_identifier" {
  description = "The identifier for the RDS cluster"
  type        = string
}

variable "engine_version" {
  description = "The Aurora MySQL engine version"
  type        = string
}

variable "database_name" {
  description = "The name of the database to create when the cluster is created"
  type        = string
}

# Master DB Credentials (username & password)
variable "master_username" {
  description = "The username for the master DB user"
  type        = string
}

variable "master_password" {
  description = "The password for the master DB user. If create_random_password is true, this will be ignored."
  type        = string
  default     = ""
  sensitive   = true
}

variable "create_random_password" {
  description = "Whether to create a random password for the master DB user"
  type        = bool
}

# Secrets Manager & Backup Configuration
variable "secrets_recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret"
  type        = number
}

variable "backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
}

variable "preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur"
  type        = string
}

# Database Instance & Network Configuration
variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs to place the RDS instances in"
  type        = list(string)
}

variable "security_group_ids" {
  description = "A list of VPC security group IDs to associate with the cluster"
  type        = list(string)
}

# Monitoring & Encryption Configuration
variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = string
}

variable "storage_encrypted" {
  description = "Specifies whether the DB cluster is encrypted"
  type        = bool
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key if storage_encrypted is true"
  type        = string
}

# DB Instance Scaling and Parameters
variable "instance_count" {
  description = "The number of DB instances to create in the cluster"
  type        = number
}

variable "instance_class" {
  description = "The instance type to use for the DB instances"
  type        = string
}

variable "parameter_group_family" {
  description = "The family of the DB parameter group"
  type        = string
}

variable "cluster_parameters" {
  description = "A list of DB cluster parameters to apply"
  type        = list(map(string))
}

variable "instance_parameters" {
  description = "A list of DB instance parameters to apply"
  type        = list(map(string))
}

# Deletion, Snapshot & Public Access Settings
variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
  type        = bool
}

variable "publicly_accessible" {
  description = "Bool to control if instances are publicly accessible"
  type        = bool
}

# Cluster Modification & Monitoring Settings
variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  type        = bool
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for instances. 0 disables monitoring."
  type        = number
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
}

# CloudWatch Logs and Performance Insights
variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to cloudwatch"
  type        = list(string)
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
}

# IAM Database Authentication
variable "iam_database_authentication_enabled" {
  description = "Specifies whether IAM database authentication is enabled"
  type        = bool
}

# Tags for All Resources
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
