##################################################################################
### Module for Aurora RDS Role ###
##################################################################################

module "rds_iam_role" {
  source = "../modules/iam/"

  # Required configuration
  role_name            = var.rds_iam_role
  description          = var.iam_description["rds"]
  max_session_duration = var.max_session_duration
  path                 = var.iam_role_path

  # Optional configuration
  create_instance_profile = var.disabled
  force_detach_policies   = var.enabled
  assume_role_policy      = data.aws_iam_policy_document.assume_role_policies["rds"].json
  managed_iam_policies    = var.rds_iam_managed_policies
  custom_iam_policies     = []
  tags                    = merge(var.tags, { Service = var.rds_service })
}
