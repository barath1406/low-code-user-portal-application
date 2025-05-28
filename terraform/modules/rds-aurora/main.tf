##################################################################################
### Resource for Aurora MySQL Cluster & Components                               ###
##################################################################################

# Random Password Generation for Aurora Master Password
resource "random_password" "master_password" {
  count            = var.create_random_password ? 1 : 0
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Secrets Manager Secret for Aurora Master Password
resource "aws_secretsmanager_secret" "aurora_master_password" {
  name                    = "${var.cluster_identifier}-master-password"
  description             = "Master password for Aurora MySQL cluster ${var.cluster_identifier}"
  recovery_window_in_days = var.secrets_recovery_window_in_days
  tags                    = var.tags
}

# Secrets Manager Secret Version to Store Password Details
resource "aws_secretsmanager_secret_version" "aurora_master_password" {
  secret_id = aws_secretsmanager_secret.aurora_master_password.id
  secret_string = jsonencode({
    username            = var.master_username
    password            = var.create_random_password ? random_password.master_password[0].result : var.master_password
    engine              = "aurora-mysql"
    host                = aws_rds_cluster.aurora_mysql_cluster.endpoint
    port                = aws_rds_cluster.aurora_mysql_cluster.port
    dbClusterIdentifier = aws_rds_cluster.aurora_mysql_cluster.cluster_identifier
  })
}

# Aurora MySQL Cluster Resource
resource "aws_rds_cluster" "aurora_mysql_cluster" {
  cluster_identifier              = var.cluster_identifier
  engine                          = "aurora-mysql"
  engine_version                  = var.engine_version
  database_name                   = var.database_name
  master_username                 = var.master_username
  master_password                 = var.create_random_password ? random_password.master_password[0].result : var.master_password
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  port                            = var.port
  db_subnet_group_name            = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids          = var.security_group_ids
  storage_encrypted               = var.storage_encrypted
  kms_key_id                      = var.kms_key_id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_parameter_group.name
  deletion_protection             = var.deletion_protection
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = var.skip_final_snapshot ? null : "${var.cluster_identifier}-final-snapshot-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  tags = var.tags

  depends_on = [random_password.master_password] # Ensure password is generated before the cluster creation
}

# Aurora MySQL Cluster Instances
resource "aws_rds_cluster_instance" "aurora_mysql_instances" {
  count                        = var.instance_count
  identifier                   = "${var.cluster_identifier}-instance-${count.index + 1}"
  cluster_identifier           = aws_rds_cluster.aurora_mysql_cluster.id
  instance_class               = var.instance_class
  engine                       = "aurora-mysql"
  engine_version               = var.engine_version
  publicly_accessible          = var.publicly_accessible
  db_subnet_group_name         = aws_db_subnet_group.aurora_subnet_group.name
  db_parameter_group_name      = aws_db_parameter_group.aurora_parameter_group.name
  apply_immediately            = var.apply_immediately
  monitoring_interval          = var.monitoring_interval
  monitoring_role_arn          = var.monitoring_interval > 0 ? var.monitoring_role_arn : null
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  promotion_tier               = count.index + 1
  performance_insights_enabled = var.performance_insights_enabled

  tags = var.tags
}

# Aurora Subnet Group for the Database Cluster
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name        = "${var.cluster_identifier}-subnet-group"
  description = "Subnet group for Aurora MySQL cluster ${var.cluster_identifier}"
  subnet_ids  = var.subnet_ids

  tags = var.tags
}

# Aurora MySQL Cluster Parameter Group
resource "aws_rds_cluster_parameter_group" "aurora_cluster_parameter_group" {
  name        = "${var.cluster_identifier}-param-group"
  family      = var.parameter_group_family
  description = "Cluster parameter group for Aurora MySQL cluster ${var.cluster_identifier}"

  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }

  tags = var.tags
}

# Aurora MySQL DB Instance Parameter Group
resource "aws_db_parameter_group" "aurora_parameter_group" {
  name        = "${var.cluster_identifier}-db-param-group"
  family      = var.parameter_group_family
  description = "Instance parameter group for Aurora MySQL cluster ${var.cluster_identifier}"

  dynamic "parameter" {
    for_each = var.instance_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }

  tags = var.tags
}
