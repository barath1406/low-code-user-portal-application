##################################################################################
#                      Module: IRSA Role for User Portal                         #
##################################################################################
module "irsa_user_portal_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.20"

  role_name = var.irsa_user_portal_role_name

  # Attach IAM policy to the IRSA role
  role_policy_arns = {
    irsa_user_portal_policy = data.aws_iam_policy.irsa_user_portal_policy.arn
  }

  # OIDC configuration for EKS service account
  oidc_providers = {
    main = {
      provider_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(module.eks.oidc_issuer, "https://", "")}"
      namespace_service_accounts = ["${var.app_namespace}:${var.app_service_account_name}"]
    }
  }

  tags = merge(
    { Name = var.irsa_user_portal_role_name },
    var.tags
  )
}

##################################################################################
#                      Resource: Helm Release for User Portal                    #
##################################################################################
resource "helm_release" "user_portal" {
  name             = var.user_portal_name
  namespace        = var.user_portal_namespace
  create_namespace = var.user_portal_create_namespace
  chart            = var.user_portal_chart_path

  # Values files for Helm chart
  values = local.values_files

  # Dynamic set values for Helm
  dynamic "set" {
    for_each = local.base_helm_set_values
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  depends_on = [
    module.eks,
    module.aws_load_balancer_controller
  ]
}
