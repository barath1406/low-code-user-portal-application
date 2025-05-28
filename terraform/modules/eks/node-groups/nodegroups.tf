##################################################################################
### Resource for EKS Nodegroup                                                 ###
##################################################################################
resource "aws_eks_node_group" "barath_nodegroup" {
  # EKS node group configuration
  cluster_name    = var.eks_node_group_eks_cluster_name
  ami_type        = "CUSTOM"
  node_group_name = var.eks_node_group_name
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.eks_node_group_subnet_ids
  labels          = var.eks_node_group_labels
  capacity_type   = var.eks_node_group_capacity_type

  # Scaling configuration for the node group
  scaling_config {
    desired_size = var.eks_node_group_desired_size
    max_size     = var.eks_node_group_max_size
    min_size     = var.eks_node_group_min_size
  }

  # Launch template for EC2 instances in the node group
  launch_template {
    name    = aws_launch_template.barath_nodegroup_launch_template.name
    version = aws_launch_template.barath_nodegroup_launch_template.latest_version
  }

  # Tags for the node group
  tags = var.eks_node_group_tags
}

##################################################################################
### Key Pair Creation                                                          ###
##################################################################################
resource "tls_private_key" "new_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.eks_node_key_name
  public_key = tls_private_key.new_key.public_key_openssh
}

##################################################################################
### Local File for Private Key                                                 ###
##################################################################################
resource "local_file" "private_key_pem" {
  content         = tls_private_key.new_key.private_key_pem
  filename        = "${path.module}/generated_keys/my-key.pem"
  file_permission = "0400"
}
