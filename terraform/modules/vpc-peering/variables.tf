##################################################################################
### VARIABLES: VPC Peering Configuration
##################################################################################

# Core region and VPC identification for requester and accepter
variable "region" {
  description = "VPC Region"
  type        = string
}

variable "accepter_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection"
  type        = string
}

variable "accepter_account_id" {
  description = "The AWS account ID of the owner of the peer VPC"
  type        = string
}

variable "accepter_region_id" {
  description = "The region of the accepter VPC. Required if using aws_vpc_peering_connection_accepter"
  type        = string
}

variable "requester_vpc_id" {
  description = "The ID of the requester VPC"
  type        = string
}

variable "peering_name" {
  description = "Name tag applied to both requester and accepter sides"
  type        = string
}

# Route table references for both requester and accepter
variable "requester_vpc_private_rt_ids" {
  description = "List of private route table IDs for the requester VPC"
  type        = list(string)
}

variable "requester_vpc_public_rt_ids" {
  description = "List of public route table IDs for the requester VPC"
  type        = list(string)
}

variable "accepter_vpc_private_rt_ids" {
  description = "List of private route table IDs for the accepter VPC"
  type        = list(string)
}

variable "requester_vpc_rt_id" {
  description = "Public route table ID list for requester; only index 0 is used"
  type        = list(string)
}

# CIDR blocks for routing
variable "accepter_cidr" {
  description = "CIDR block of the accepter VPC"
  type        = string
}

variable "requester_cidr" {
  description = "CIDR block of the requester VPC"
  type        = string
}

# Metadata and control flags
variable "accepter_private_rt_count" {
  description = "Number of private route tables on the accepter side"
  type        = number
}

variable "tags" {
  description = "Map of tags to apply to peering resources"
  type        = map(string)
}

variable "enabled" {
  description = "Whether the VPC peering connection should be created"
  type        = bool
}
