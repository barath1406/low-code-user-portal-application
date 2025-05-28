##################################################################################
### Module for Lambda Role ###
##################################################################################

module "lambda_iam_role" {
  source = "../modules/iam"

  # Required configuration
  role_name            = var.lambda_iam_role_name
  description          = var.iam_description["lambda"]
  max_session_duration = var.max_session_duration
  path                 = var.iam_role_path

  # Optional configuration
  create_instance_profile = var.disabled
  force_detach_policies   = var.disabled
  assume_role_policy      = data.aws_iam_policy_document.assume_role_policies["lambda"].json
  managed_iam_policies    = var.lambda_iam_managed_policies
  
  # Pass the custom policies
  custom_iam_policies     = local.lambda_custom_policies
  tags                    = var.tags
}
