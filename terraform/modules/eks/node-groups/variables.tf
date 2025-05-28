##################################################################################
### Variables for EKS Nodegroup                                                  ###
##################################################################################

# EKS Cluster and Node Group Configuration
variable "eks_node_group_eks_cluster_name" {
  description = "The name of the eks cluster"
  type        = string
}

variable "eks_node_group_name" {
  description = "The name of the node group"
  type        = string
}

variable "eks_node_role_arn" {
  description = "Role ARN of the EKS nodes"
  type        = string
}

# Networking and Scaling Configuration
variable "eks_node_group_subnet_ids" {
  description = "Subnet IDs of the node groups"
  type        = list(string)
}

variable "eks_node_group_capacity_type" {
  description = "Type of capacity associated with the EKS Node Group."
  type        = string
}

variable "eks_node_group_desired_size" {
  description = "Desired size of the eks node group"
}

variable "eks_node_group_max_size" {
  description = "Max size of the node group"
}

variable "eks_node_group_min_size" {
  description = "Minimum size of the node group"
}

# Instance and Disk Configuration
variable "eks_node_group_instance_type" {
  description = "Instance types of the node group (t3.medium, c5.xlarge etc.)"
  type        = string
}

variable "eks_node_group_disk_size" {
  description = "Disk size of the node groups"
  type        = number
}

# Labels, Tags, and SSH Key
variable "eks_node_group_labels" {
  description = "Labels of the node group"
  type        = map(any)
}

variable "eks_node_key_name" {
  description = "SSH key for the nodes"
  type        = string
}

variable "eks_node_group_security_group_ids" {
  description = "Security groups for the node groups"
  type        = list(string)
}

variable "eks_node_group_ami_id" {
  description = "AMI ID of the eks node groups"
  type        = string
}

variable "eks_node_group_tags" {
  description = "Tags for the node groups"
  type        = map(string)
  default     = {}
}

# EKS Cluster Authentication and Endpoint Configuration
variable "eks_node_group_auth_base64" {
  description = "Cluster ca in base64"
  type        = string
}

variable "eks_node_group_eks_endpoint" {
  description = "Endpoint of the eks cluster"
  type        = string
}

# Cluster Name and Region Configuration
variable "eks_cluster_name" {
  description = "The name of the eks cluster."
  type        = string
}

variable "eks_region" {
  description = "The region of the eks cluster."
  type        = string
}

# Launch Template Configuration
variable "eks_node_group_launch_template_name" {
  description = "Name of the EKS Node group template"
  type        = string
}

variable "device_name" {
  description = "Name of the block device"
  type        = string
}

variable "delete_on_termination" {
  description = "Whether the volume should be deleted on instance termination"
  type        = bool
}

variable "volume_size" {
  description = "Size of the volume in GiB"
  type        = number
}

variable "volume_type" {
  description = "Type of volume (e.g. gp2, gp3)"
  type        = string
}

variable "http_put_response_hop_limit" {
  description = "The desired HTTP PUT response hop limit"
  type        = number
}

variable "http_endpoint" {
  description = "Enable or disable the IMDSv2 HTTP endpoint"
  type        = string
}

variable "http_tokens" {
  description = "State of IMDSv2 token requirement"
  type        = string
}
