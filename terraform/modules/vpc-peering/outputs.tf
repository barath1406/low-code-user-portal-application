##################################################################################
# OUTPUT: VPC Peering Connection ID
##################################################################################

# Outputs the ID(s) of the VPC peering connection(s) created by the requester.
output "peer_id" {
  description = "VPC peering connection ID"
  value       = aws_vpc_peering_connection.requester[*].id
}
