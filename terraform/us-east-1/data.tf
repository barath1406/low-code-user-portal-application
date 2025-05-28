##################################################################################
# Data Definitions - General AWS Information
##################################################################################

# Get list of available availability zones in the current region
data "aws_availability_zones" "available" {}

# Get current AWS account ID and caller identity
data "aws_caller_identity" "current" {}

# Get the current AWS region in use
data "aws_region" "current" {}

##################################################################################
# Fetch the latest EKS Optimized AMI ID using SSM Parameter Store
##################################################################################

# Retrieve EKS-optimized Amazon Linux 2 AMI for Kubernetes version
data "aws_ssm_parameter" "node_ami" {
  name = var.eks_node_ami
}

##################################################################################
# Data Source: Fetching EKS Optimized AMI using Filters
##################################################################################

# Get the most recent Amazon EKS-optimized AMI using custom filters
data "aws_ami" "eks_optimized" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.eks_cluster_version}-v*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

##################################################################################
# Data Source: Fetching Latest Amazon Linux AMI for Bastion Host
##################################################################################

# Retrieve the latest available Amazon Linux 2 AMI for Bastion EC2
data "aws_ami" "bastion" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

##################################################################################
# Data Sources: IAM Roles and Instance Profiles
##################################################################################

# IAM role for Lambda functions
data "aws_iam_role" "lambda_role" {
  name = var.lambda_iam_role_name
}

# IAM role for EKS control plane
data "aws_iam_role" "eks_cluster_role" {
  name = var.eks_cluster_iam_role
}

# IAM role for EKS Node Group
data "aws_iam_role" "eks_nodegroup_role" {
  name = var.eks_nodegroup_iam_role
}

# IAM role for Bastion host
data "aws_iam_role" "bastion_host_role" {
  name = var.bastion_host_iam_role
}

# Instance profile associated with Bastion host role
data "aws_iam_instance_profile" "bastion_host_instance_profile" {
  name = data.aws_iam_role.bastion_host_role.name
}

# IAM role for RDS enhanced monitoring
data "aws_iam_role" "rds_monitoring_role" {
  name = var.rds_monitoring_role
}

# IAM policy for IRSA user portal access
data "aws_iam_policy" "irsa_user_portal_policy" {
  name        = var.irsa_user_portal_policy_name
  path_prefix = var.eks_cluster_iam_role_path
}

##################################################################################
# Data Sources: Application and Networking Resources
##################################################################################

# Kubernetes Ingress resource created by Helm release for the user portal
data "kubernetes_ingress_v1" "user_portal_ingress" {
  metadata {
    name      = "${helm_release.user_portal.name}"
    namespace = helm_release.user_portal.namespace
  }

  depends_on = [helm_release.user_portal]
}

# Fetch the ALB (Application Load Balancer) for the user portal
data "aws_lb" "app_alb" {
  name       = var.user_portal_alb_name
  depends_on = [helm_release.user_portal]
}

##################################################################################
# Data Sources: Route53 Hosted Zone
##################################################################################

# Retrieve the public Route53 hosted zone by name
data "aws_route53_zone" "barath_r53" {
  name         = var.route53_zone_name
  private_zone = false
}

##################################################################################
### Data Block: Create Lambda Deployment Package
##################################################################################
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = var.lambda_source_path
  output_path = "${path.module}/lambda_function_payload.zip"
}