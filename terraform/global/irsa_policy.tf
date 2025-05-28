##################################################################################
### Module for IRSA User Portal IAM Policy ###
##################################################################################

module "irsa_user_portal" {
  source = "../modules/iam/policy"

  # Required configuration
  policy_name        = var.irsa_user_portal_policy_name
  policy_description = var.irsa_user_portal_policy_description
  policy_path        = var.iam_role_path
  region             = data.aws_region.current.name
  tags               = var.tags
}
