##################################################################################
### Outputs of Aurora RDS Cluster & Components                                 ###
##################################################################################

# Cluster Information
output "cluster_id" {
  description = "The ID of the cluster"
  value       = aws_rds_cluster.aurora_mysql_cluster.id
}

output "cluster_endpoint" {
  description = "The cluster endpoint"
  value       = aws_rds_cluster.aurora_mysql_cluster.endpoint
}

output "cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = aws_rds_cluster.aurora_mysql_cluster.reader_endpoint
}

output "cluster_port" {
  description = "The port on which the DB accepts connections"
  value       = aws_rds_cluster.aurora_mysql_cluster.port
}

# Cluster Instances Information
output "cluster_instance_ids" {
  description = "The IDs of the cluster instances"
  value       = aws_rds_cluster_instance.aurora_mysql_instances[*].id
}

# Additional Cluster Information
output "cluster_arn" {
  description = "Amazon Resource Name (ARN) of the cluster"
  value       = aws_rds_cluster.aurora_mysql_cluster.arn
}

output "database_name" {
  description = "The database name"
  value       = aws_rds_cluster.aurora_mysql_cluster.database_name
}

# Secrets Manager Information
output "secret_arn" {
  description = "The ARN of the Secrets Manager secret storing the database credentials"
  value       = aws_secretsmanager_secret.aurora_master_password.arn
}

output "secret_name" {
  description = "The name of the Secrets Manager secret storing the database credentials"
  value       = aws_secretsmanager_secret.aurora_master_password.name
}

# DB Subnet Group Information
output "subnet_group_id" {
  description = "The ID of the DB subnet group"
  value       = aws_db_subnet_group.aurora_subnet_group.id
}

# Parameter Group Information
output "cluster_parameter_group_id" {
  description = "The ID of the DB cluster parameter group"
  value       = aws_rds_cluster_parameter_group.aurora_cluster_parameter_group.id
}

output "parameter_group_id" {
  description = "The ID of the DB parameter group"
  value       = aws_db_parameter_group.aurora_parameter_group.id
}
