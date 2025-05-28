##################################################################################
### Providers Configuration for Kubernetes and Helm
##################################################################################

# Kubernetes provider configuration to interact with the EKS cluster
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_ca)

  # Use AWS CLI to authenticate with the EKS cluster
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      module.eks.cluster_name,
      "--region",
      var.region
    ]
  }
}

# Helm provider configuration using the same EKS cluster authentication
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_ca)

    # Use AWS CLI to get token for Helm to interact with EKS
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        module.eks.cluster_name,
        "--region",
        var.region
      ]
    }
  }
}

##################################################################################
### Module: AWS Load Balancer Controller Deployment using Helm
##################################################################################

module "aws_load_balancer_controller" {
  source = "../modules/lb_controller"

  # EKS cluster and namespace configuration
  eks_cluster_name          = var.eks_cluster_name
  namespace                 = var.namespace

  # Service account and IAM role configuration
  create_service_account    = var.create_service_account
  service_account_name      = var.service_account_name
  lb_controller_policy_name = var.lb_controller_policy_name
  create_role               = var.create_role

  # Networking configuration for load balancer controller
  subnet_ids                = module.vpc1.public_subnets
  oidc_issuer               = module.eks.oidc_issuer

  # Helm chart label for versioning or identification
  lb_controller_label       = var.lb_controller_label

  # Resource tagging
  tags                      = var.tags
}
