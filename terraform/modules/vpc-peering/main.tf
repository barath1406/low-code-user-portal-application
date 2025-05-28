##################################################################################
# VPC PEERING CONNECTION REQUESTER
##################################################################################
resource "aws_vpc_peering_connection" "requester" {
  # Define the VPC peering connection from the requester side, including the VPC IDs, peer account, and region.
  vpc_id        = var.requester_vpc_id
  peer_owner_id = var.accepter_account_id
  peer_vpc_id   = var.accepter_vpc_id
  peer_region   = var.accepter_region_id
  
  # Set auto_accept to false as the peering connection must be manually accepted by the accepter.
  auto_accept   = false
  
  # Assign the provider configuration for AWS (default configuration).
  provider      = aws.default
  
  # Merge common tags with a specific Name tag for identification of this peering connection.
  tags = merge(
    var.tags,
    {
      "Name" = var.peering_name
    },
  )
  
  # Use a conditional count to decide whether to create this resource based on the 'enabled' variable.
  count = var.enabled ? 1 : 0
}

##################################################################################
# VPC PEERING CONNECTION ACCEPTER
##################################################################################
resource "aws_vpc_peering_connection_accepter" "accepter" {
  # The accepter automatically accepts the peering connection initiated by the requester.
  vpc_peering_connection_id = aws_vpc_peering_connection.requester[0].id
  auto_accept               = true

  # Assign tags for identification, merging general tags with a specific Name tag.
  tags = merge(
    var.tags,
    {
      "Name" = var.peering_name
    },
  )

  # Use a conditional count to decide whether to create this resource based on the 'enabled' variable.
  count = var.enabled ? 1 : 0
}

##################################################################################
# ROUTE TABLES FOR ROUTING TRAFFIC BETWEEN REQUESTER AND ACCEPTER
##################################################################################
# Public route from the requester VPC to the accepter VPC using the peering connection.
resource "aws_route" "requester_vpc" {
  route_table_id            = element(var.requester_vpc_rt_id, 0)
  destination_cidr_block    = var.accepter_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.requester[0].id
  provider                  = aws.default
  
  # Create this route if 'enabled' is true.
  count                     = var.enabled ? 1 : 0
}

# Public route from the requester’s public subnet to the accepter VPC using the peering connection.
resource "aws_route" "requester_public_route" {
  route_table_id            = element(var.requester_vpc_public_rt_ids, 0)
  destination_cidr_block    = var.accepter_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.requester[0].id
  provider                  = aws.default
  
  # Create this route if 'enabled' is true.
  count                     = var.enabled ? 1 : 0
}

# Route from the requester’s private subnets to the accepter VPC through the peering connection.
resource "aws_route" "requester_private_route" {
  route_table_id            = element(var.requester_vpc_private_rt_ids, count.index)
  destination_cidr_block    = var.accepter_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.requester[0].id
  provider                  = aws.default

  # Create this route for each private route table in the requester VPC if 'enabled' is true.
  count                     = (var.enabled ? 1 : 0) * length(var.requester_vpc_private_rt_ids)
}

# Route from the accepter VPC to the requester’s private subnets using the peering connection.
resource "aws_route" "accepter_private_route" {
  count                     = var.accepter_private_rt_count * (var.enabled ? 1 : 0)
  route_table_id            = element(var.accepter_vpc_private_rt_ids, count.index)
  destination_cidr_block    = var.requester_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.requester[0].id
}
