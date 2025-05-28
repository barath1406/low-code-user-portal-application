##################################################################################
### Common Vars ###
##################################################################################

tags = {
  "Owner"        = "SRE Team"
  "Environment"  = "development"
  "AWSRegion"    = "Frankfurt"
  "Organization" = "barath SE"
}

environment = "development"
enabled     = true

# Optional configuration
assume_role_services = {
  lambda        = ["lambda.amazonaws.com"]
  eks_cluster   = ["eks.amazonaws.com"]
  eks_nodegroup = ["ec2.amazonaws.com"]
  bastion_host  = ["ec2.amazonaws.com"]
  rds           = ["monitoring.rds.amazonaws.com"]
}

iam_role_path        = "/"
disabled             = "false"
max_session_duration = "3600"

iam_description = {
  lambda        = "IAM role for Lambda"
  eks_cluster   = "IAM role for EKS cluster"
  eks_nodegroup = "IAM role for EKS Node group"
  bastion_host  = "IAM role for Bastion Host"
  rds           = "IAM role for RDS Monitoring"
}

##################################################################################
### Lambda Vars ###
##################################################################################

lambda_iam_role_name = "barath-lambda-execution-role-data-vpc"
s3_bucket_name       = "sre-falcon-secure-files"
lambda_function_name = "barath-data-vpc-lambda"
lambda_iam_managed_policies = []

##################################################################################
### EKS Cluster Vars ###
##################################################################################

eks_cluster_iam_role           = "barath-eks-cluster-role"
eks_cluster_iam_role_duration = "3600"
eks_service                   = "eks"

eks_cluster_iam_managed_policies = [
  "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
  "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
]

##################################################################################
### EKS Nodegroup Vars ###
##################################################################################

eks_nodegroup_iam_role           = "barath-eks-node-group-role"
eks_nodegroup_iam_role_duration = "3600"

eks_nodegroup_iam_managed_policies = [
  "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  "arn:aws:iam::144360205765:policy/barathHostSecurityResourcesAccessPolicy"
]

##################################################################################
### Bastion Host Vars ###
##################################################################################

bastion_host_iam_role           = "barath-bastion-host-role"
bastion_host_iam_role_duration = "3600"
bastion_service                 = "Bastion Host"

bastion_host_iam_managed_policies = [
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  "arn:aws:iam::aws:policy/ReadOnlyAccess",
  "arn:aws:iam::144360205765:policy/barathHostSecurityResourcesAccessPolicy"
]

##################################################################################
### RDS Role Vars ###
##################################################################################

rds_iam_role           = "barath-rds-role"
rds_iam_role_duration  = "3600"
rds_service            = "RDS"

rds_iam_managed_policies = [
  "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
]

##################################################################################
### IRSA Policy Vars ###
##################################################################################

irsa_user_portal_policy_name        = "barath-irsa-user-portal-policy"
irsa_user_portal_policy_description = "Policy for user portal IRSA"
