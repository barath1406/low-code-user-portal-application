##################################################################################
### Security Group and Ingress/Egress Rules                                      ###
##################################################################################

# Create the security group
resource "aws_security_group" "aws_sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  # Merging tags for the security group
  tags = merge(
    {
      Name = var.sg_name
    },
    var.tags
  )

  # Ensuring that security group is created before any deletion
  lifecycle {
    create_before_destroy = true
  }
}

# Create ingress rules
resource "aws_vpc_security_group_ingress_rule" "aws_sg_ingress" {
  for_each = { for rule in var.ingress_rules : rule.description => rule }

  # Security group configuration for ingress traffic
  security_group_id = aws_security_group.aws_sg.id
  cidr_ipv4         = lookup(each.value, "cidr_ipv4", null)
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = each.value.ip_protocol
  description       = each.value.description

  # Allow referencing other security groups for source
  referenced_security_group_id = lookup(each.value, "source_security_group_id", null)
}

# Create egress rules
resource "aws_vpc_security_group_egress_rule" "aws_sg_egress" {
  for_each = { for rule in var.egress_rules : rule.description => rule }

  # Security group configuration for egress traffic
  security_group_id = aws_security_group.aws_sg.id
  cidr_ipv4         = lookup(each.value, "cidr_ipv4", null)
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = each.value.ip_protocol
  description       = each.value.description

  # Allow referencing other security groups for destination
  referenced_security_group_id = lookup(each.value, "destination_security_group_id", null)
}
