##################################################################################
### Module for EKS Cluster Role ###
##################################################################################

module "eks_cluster_iam_role" {
  source = "../modules/iam/"

  # Required configuration
  role_name            = var.eks_cluster_iam_role
  description          = var.iam_description["eks_cluster"]
  max_session_duration = var.max_session_duration
  path                 = var.iam_role_path

  # Optional configuration
  force_detach_policies   = var.enabled
  create_instance_profile = var.disabled
  assume_role_policy      = data.aws_iam_policy_document.assume_role_policies["eks_cluster"].json
  managed_iam_policies    = var.eks_cluster_iam_managed_policies
  custom_iam_policies     = []
  tags                    = merge(var.tags, { Service = var.eks_service })
}

##################################################################################
### Module for EKS Nodegroup Role ###
##################################################################################

module "eks_nodegroup_iam_role" {
  source = "../modules/iam/"

  # Required configuration
  role_name            = var.eks_nodegroup_iam_role
  description          = var.iam_description["eks_nodegroup"]
  max_session_duration = var.max_session_duration
  path                 = var.iam_role_path

  # Optional configuration
  create_instance_profile = var.enabled
  force_detach_policies   = var.enabled
  assume_role_policy      = data.aws_iam_policy_document.assume_role_policies["eks_nodegroup"].json
  managed_iam_policies    = var.eks_nodegroup_iam_managed_policies
  custom_iam_policies     = []
  tags                    = merge(var.tags, { Service = var.eks_service })
}
