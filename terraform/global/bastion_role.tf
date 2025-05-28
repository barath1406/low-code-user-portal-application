##################################################################################
### Module for Bastion Host Instance Profile ###
##################################################################################

module "bastion_host_iam_role" {
  source = "../modules/iam/"

  # Required configuration
  role_name            = var.bastion_host_iam_role
  description          = var.iam_description["bastion_host"]
  max_session_duration = var.max_session_duration
  path                 = var.iam_role_path

  # Optional configuration
  create_instance_profile = var.enabled
  force_detach_policies   = var.enabled
  assume_role_policy      = data.aws_iam_policy_document.assume_role_policies["bastion_host"].json
  managed_iam_policies    = var.bastion_host_iam_managed_policies
  custom_iam_policies     = []
  tags                    = merge(var.tags, { Service = var.bastion_service })
}
