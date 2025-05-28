##################################################################################
### Data Sources for EKS Cluster and Authentication                             ###
##################################################################################

# Fetching EKS Cluster information
data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.barath_eks_cluster.name
}

# Fetching EKS Cluster authentication details
data "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.barath_eks_cluster.name
}
