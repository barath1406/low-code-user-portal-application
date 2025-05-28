##################################################################################
### Resource for IAM Policy - IRSA User Portal Policy                          ###
##################################################################################
resource "aws_iam_policy" "irsa_user_portal_policy" {
  
  # Policy Basic Information
  name        = var.policy_name
  description = var.policy_description
  path        = var.policy_path
  tags        = var.tags

  # Policy Document
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # Statement 1: SecretsManager actions (Allow)
      {
        Effect   = "Allow",
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = "*"
      },
      
      # Statement 2: KMS Decrypt action (Allow) with Condition
      {
        Effect   = "Allow",
        Action   = "kms:Decrypt",
        Resource = "*",
        Condition = {
          StringEquals = {
            "kms:ViaService" = "secretsmanager.${var.region}.amazonaws.com"
          }
        }
      }
    ]
  })
}
