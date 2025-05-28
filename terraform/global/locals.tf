# Create custom IAM policies configuration
locals {
  lambda_custom_policies = [
    {
      name            = "${var.lambda_function_name}-policy"
      description     = "S3, CWL, Secret Manager, access policy for Lambda function ${var.lambda_function_name}"
      policy_document = data.aws_iam_policy_document.lambda_policy_doc.json
      path            = var.iam_role_path
    }
  ]
}