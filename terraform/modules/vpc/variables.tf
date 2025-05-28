##################################################################################
### Variables of VPC ###
##################################################################################

# Control flag for VPC creation
variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

# CIDR block for the VPC
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

# Name to be used as an identifier for all resources
variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

# Instance tenancy option for the VPC (default is 'default', other option is 'dedicated')
variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

# List of Availability Zones in the region
variable "azs" {
  description = "A list of Availability zones in the region"
  type        = list(string)
}

# Enable or disable DNS hostnames in the VPC
variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  type        = bool
}

# Enable or disable DNS support in the VPC
variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  type        = bool
}

# Enable or disable the creation of NAT Gateways for private subnets
variable "enable_nat_gateway" {
  description = "should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
}

# Enable or disable IPv6 support for the VPC
variable "enable_ipv6" {
  description = "Enable/Disable IPV6 support"
  type        = bool
}

# Enable or disable auto-assigning IPv6 addresses to instances in subnets with IPv6 enabled
variable "assign_ipv6_address_on_creation" {
  description = "Enable/Disable auto assigning IPV6 addresses to instances on subnets with IPV6 enabled"
  type        = bool
}

# Control whether public IPs should be auto-assigned to instances in public subnets
variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  type        = bool
}

# List of VGWs to propagate with the private route table
variable "private_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  type        = list(string)
  default     = []
}

# List of VGWs to propagate with the public route table
variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  type        = list(string)
  default     = []
}

# Tags to be applied to all resources
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

# Additional tags for public subnets
variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

# Additional tags for private subnets
variable "private_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

# List of public subnets in the VPC
variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

# Enable or disable an S3 endpoint for the VPC
variable "enable_s3_endpoint" {
  description = "Should be true if you want to provision an S3 endpoint to the VPC"
  type        = bool
}

# Number of subnet bits for private subnets
variable "private_subnet_newbits" {
  description = "The new subnet bits for private subnets"
  type        = number
}

# Number of subnet bits for public subnets
variable "public_subnet_newbits" {
  description = "The new subnet bits for public subnets"
  type        = number
}
