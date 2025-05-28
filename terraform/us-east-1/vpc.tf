##################################################################################
### Module for Compute VPC & Subnets ###
##################################################################################

module "vpc1" {
  source = "../modules/vpc/"

  # Required variables
  name = var.vpc1_name
  cidr = var.vpc1_cidr
  azs  = var.availability_zones
  tags = var.tags

  # Optional configuration
  enable_nat_gateway               = var.enable_nat_gateway
  enable_s3_endpoint               = var.enable_s3_endpoint
  public_subnet_tags               = merge(var.public_subnet_tags, var.alb_controller_public_subnet_tags)
  private_subnet_tags              = var.private_subnet_tags
  enable_dns_hostnames            = var.enable_dns_hostnames
  enable_dns_support              = var.enable_dns_support
  enable_ipv6                     = var.enable_ipv6
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  private_subnet_newbits          = var.private_subnet_newbits
  public_subnet_newbits           = var.public_subnet_newbits
}

##################################################################################
### Module for Data VPC & Subnets ###
##################################################################################

module "vpc2" {
  source = "../modules/vpc/"

  # Required variables
  name = var.vpc2_name
  cidr = var.vpc2_cidr
  azs  = var.availability_zones
  tags = var.tags

  # Optional configuration
  enable_nat_gateway               = var.enable_nat_gateway
  enable_s3_endpoint               = var.enable_s3_endpoint
  public_subnet_tags               = var.public_subnet_tags
  private_subnet_tags              = var.private_subnet_tags
  enable_dns_hostnames            = var.enable_dns_hostnames
  enable_dns_support              = var.enable_dns_support
  enable_ipv6                     = var.enable_ipv6
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  private_subnet_newbits          = var.private_subnet_newbits
  public_subnet_newbits           = var.public_subnet_newbits
}

##################################################################################
### Module for VPC Peering ###
##################################################################################

module "vpc_peering" {
  source = "../modules/vpc-peering/"

  providers = {
    aws.default = aws
  }

  region = data.aws_region.current.name

  # Requester VPC configuration
  requester_vpc_id             = module.vpc1.vpc_id
  requester_cidr               = module.vpc1.vpc_cidr_block
  requester_vpc_rt_id          = [module.vpc1.vpc_main_route_table_id]
  requester_vpc_public_rt_ids  = module.vpc1.public_route_table_ids
  requester_vpc_private_rt_ids = module.vpc1.private_route_table_ids

  # Accepter VPC configuration
  accepter_vpc_id             = module.vpc2.vpc_id
  accepter_account_id         = data.aws_caller_identity.current.account_id
  accepter_region_id          = data.aws_region.current.name
  accepter_cidr               = module.vpc2.vpc_cidr_block
  accepter_vpc_private_rt_ids = module.vpc2.private_route_table_ids
  accepter_private_rt_count   = length(module.vpc2.private_route_table_ids)

  # Peering configuration
  peering_name = var.peering_name
  enabled      = var.enabled
  tags         = var.tags
}
