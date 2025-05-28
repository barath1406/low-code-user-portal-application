#####################################################################################
# Locals : Base Helm `set` values to override defaults during Helm chart installation
#####################################################################################
locals {  
  base_helm_set_values = [
    {
      name  = "serviceAccount.iamRole"
      value = module.irsa_user_portal_role.iam_role_arn
    },
    {
      name  = "serviceAccount.name"
      value = var.app_service_account_name
    }
  ]

# Path to the Helm chart for the user portal
  chart_path = var.user_portal_chart_path
  
# Helm values files to use for deployment (base and environment-specific)
  values_files = [
    file("${local.chart_path}/values.yaml"),

    // Conditionally load environment-specific values file if it exists
    fileexists("${local.chart_path}/env_values/${var.environment}_values.yaml") ?
      file("${local.chart_path}/env_values/${var.environment}_values.yaml") : ""
  ]
}
