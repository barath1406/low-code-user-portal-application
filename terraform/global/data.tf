##################################################################################
### Data Sources ###
##################################################################################

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

##################################################################################
### Locals - IAM Assume Role Policy Definitions ###
##################################################################################

locals {
  assume_role_documents = {
    for key, services in var.assume_role_services :
    key => {
      name     = "${key}_assume_role_policy"
      services = services
    }
  }
}

##################################################################################
### Data Source - IAM Assume Role Policy Documents ###
##################################################################################

data "aws_iam_policy_document" "assume_role_policies" {
  for_each = local.assume_role_documents

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = each.value.services
    }
  }
}


##################################################################################
### Data Source - Lambda Role Policy Documents ###
##################################################################################

# Define S3 policy document
data "aws_iam_policy_document" "lambda_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}-${data.aws_caller_identity.current.account_id}",
      "arn:aws:s3:::${var.s3_bucket_name}-${data.aws_caller_identity.current.account_id}/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [
      "*"
    ]
  } 
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  } 
}


