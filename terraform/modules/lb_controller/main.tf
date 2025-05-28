##################################################################################
### Helm Module                                                                 ###
##################################################################################

# Load the IAM policy document from remote source
data "http" "iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"
}

# Create IAM role for the service account
module "lb_controller_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "~> 5.1"

  create_role = var.create_role
  role_name   = "${var.service_account_name}-${var.eks_cluster_name}"

  provider_url                  = replace(var.oidc_issuer, "https://", "")
  role_policy_arns              = [aws_iam_policy.lb_controller.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${var.service_account_name}"]
  tags                          = var.tags
}

# Create the IAM policy for the Load Balancer Controller
resource "aws_iam_policy" "lb_controller" {
  name        = var.lb_controller_policy_name
  description = "IAM policy for AWS Load Balancer Controller"
  policy      = data.http.iam_policy.body
  tags        = var.tags
}

# Create the Kubernetes service account
resource "kubernetes_service_account" "lb_controller" {
  count = var.create_service_account ? 1 : 0

  metadata {
    name      = var.service_account_name
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = module.lb_controller_role.iam_role_arn
    }
    labels = {
      "app.kubernetes.io/name"      = var.service_account_name
      "app.kubernetes.io/component" = var.lb_controller_label
    }
  }
}

# Install the Load Balancer Controller using Helm
resource "helm_release" "lb_controller" {
  name       = var.service_account_name
  repository = "https://aws.github.io/eks-charts"
  chart      = var.service_account_name
  namespace  = var.namespace
  depends_on = [kubernetes_service_account.lb_controller]

  set {
    name  = "clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = tostring(!var.create_service_account)
  }

  set {
    name  = "serviceAccount.name"
    value = var.service_account_name
  }
}
