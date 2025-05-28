##################################################################################
### Resource for EKS Nodegroup Launch Template                                 ###
##################################################################################
resource "aws_launch_template" "barath_nodegroup_launch_template" {
  # Launch template name and block device mappings for root EBS volume
  name = var.eks_node_group_launch_template_name

  block_device_mappings {
    device_name           = var.device_name

    ebs {
      delete_on_termination = var.delete_on_termination
      volume_size           = var.volume_size
      volume_type           = var.volume_type
    }
  }

  # Instance configuration: type, security groups, and tags
  instance_type          = "t3.medium"
  vpc_security_group_ids = var.eks_node_group_security_group_ids

  tags = {
    "Name" = var.eks_node_group_launch_template_name
  }

  # AMI ID and key pair for SSH access
  image_id = var.eks_node_group_ami_id
  key_name = aws_key_pair.generated_key.key_name

  # Metadata options for the instance
  metadata_options {
    http_put_response_hop_limit = var.http_put_response_hop_limit
    http_endpoint               = var.http_endpoint
    http_tokens                 = var.http_tokens
  }

  # EC2 instance tag specifications
  tag_specifications {
    resource_type = "instance"
    tags = var.eks_node_group_tags
  }

  # User data script for instance initialization
  user_data = base64encode(<<-EOT
#!/bin/bash
set -o xtrace
iptables -F
/etc/eks/bootstrap.sh ${var.eks_cluster_name} --b64-cluster-ca "${var.eks_node_group_auth_base64}" --apiserver-endpoint "${var.eks_node_group_eks_endpoint}"
EOT
  )
}
