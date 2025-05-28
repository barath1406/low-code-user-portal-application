##################################################################################
### Module: Lambda Function Deployment
##################################################################################
module "lambda_function" {
  source = "../modules/lambda"

  # Lambda configuration
  function_name  = var.lambda_function_name
  handler        = var.lambda_handler
  runtime        = var.lambda_runtime
  source_zip     = data.archive_file.lambda_zip.output_path

  # KMS configuration
  use_default_kms = var.enabled
  kms_key_arn     = var.kms_key_arn

  # Networking
  vpc_id             = module.vpc2.vpc_id
  subnet_ids         = module.vpc2.private_subnets
  security_group_ids = [module.lambda_sg.security_group_id]
  vpc_cidr_block     = module.vpc2.vpc_cidr_block

  # Environment variables for Lambda
  environment_variables = {
    DB_HOST     = module.aurora_mysql.cluster_endpoint
    DB_USER     = var.master_username
    SECRET_NAME = module.aurora_mysql.secret_name
    S3_BUCKET   = "${var.bucket_name}-${data.aws_caller_identity.current.account_id}"
  }

  # IAM Role
  iam_role_arn = data.aws_iam_role.lambda_role.arn

  # Logging and monitoring
  log_group_retention_in_days = var.log_group_retention_in_days
  lambda_timeout              = var.lambda_timeout

  # S3 Event Trigger Config (optional)
  bucket_name = "${var.bucket_name}-${data.aws_caller_identity.current.account_id}"
  s3_prefix   = var.s3_prefix
  s3_suffix   = var.s3_suffix

  # Tags
  tags = var.tags
}

##################################################################################
### Module: Lambda Security Group
##################################################################################
module "lambda_sg" {
  source = "../modules/sg"

  # Security Group details
  sg_name        = var.lambda_sg_name
  sg_description = var.lambda_sg_description
  vpc_id         = module.vpc2.vpc_id

  # Ingress and egress rules
  ingress_rules = var.lambda_sg_ingress_rules
  egress_rules  = var.lambda_sg_egress_rules

  # Tags
  tags = var.tags
}
