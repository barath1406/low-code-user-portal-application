##################################################################################
### Outputs for Security Group                                                 ###
##################################################################################

# Output for the security group's ID
output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.aws_sg.id
}

# Output for the security group's name
output "security_group_name" {
  description = "The name of the security group"
  value       = aws_security_group.aws_sg.name
}
