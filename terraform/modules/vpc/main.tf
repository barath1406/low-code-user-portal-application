######################################################################
### VPC Setup: Create and Configure the VPC with CIDR, DNS, and Tags ###
######################################################################
locals {
  # Clean the name by removing trailing dashes if any
  clean_name = substr(var.name, length(var.name) - 1, 1) == "-" ? substr(var.name, 0, length(var.name) - 1) : var.name
}

# Create a new VPC with specified CIDR, DNS support, and optional IPv6
resource "aws_vpc" "vpc" {
  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6
  tags                             = merge(var.tags, { Name = "${local.clean_name}" })
}

######################################################################
### IPV6 CIDR Block Setup: Set IPv6 CIDR Block if enabled           ###
######################################################################
locals {
  # Determine IPv6 CIDR if IPv6 is enabled for the VPC
  ipv6_cidr = can(regex(".*::/56", aws_vpc.vpc.ipv6_cidr_block)) ? aws_vpc.vpc.ipv6_cidr_block : "IPV6_NOT_ENABLED"
}

######################################################################
### Subnet Configuration: Create Public and Private Subnets         ###
######################################################################

# Create private subnets in the VPC, with optional IPv6 addressing
resource "aws_subnet" "private" {
  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = cidrsubnet(var.cidr, var.private_subnet_newbits, count.index + 1 + length(var.azs))
  ipv6_cidr_block                 = var.enable_ipv6 ? cidrsubnet(local.ipv6_cidr, 8, count.index) : null
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  availability_zone               = element(var.azs, count.index)
  count                           = length(var.azs)
  tags                            = merge(var.tags, var.private_subnet_tags, tomap({ "Name" = format("%sPrivate-%s", var.name, element(var.azs, count.index)) }))
}

# Create public subnets in the VPC, with optional IPv6 addressing
resource "aws_subnet" "public" {
  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = cidrsubnet(var.cidr, var.public_subnet_newbits, count.index + 1)
  ipv6_cidr_block                 = var.enable_ipv6 ? cidrsubnet(local.ipv6_cidr, 8, count.index + length(var.azs)) : null
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  availability_zone               = element(var.azs, count.index)
  count                           = length(var.azs)
  tags                            = merge(var.tags, var.public_subnet_tags, tomap({ "Name" = format("%sPublic-%s", var.name, element(var.azs, count.index)) }))
  map_public_ip_on_launch         = var.map_public_ip_on_launch
}

######################################################################
### Elastic IP for NAT Gateway: Allocate Elastic IP for NAT Gateways ###
######################################################################
resource "aws_eip" "nateip" {
  vpc   = true
  count = length(var.azs) * (var.enable_nat_gateway ? 1 : 0)
  tags  = merge(var.tags, tomap({ "Name" = format("%s-%s-NAT-EIP", local.clean_name, element(var.azs, count.index)) }))

  lifecycle {
    prevent_destroy = true
  }
}

######################################################################
### Gateway Configuration: Internet and NAT Gateways Setup          ###
######################################################################

# Create an internet gateway for the VPC
resource "aws_internet_gateway" "vpc" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.tags, tomap({ "Name" = format("%s-IGW", local.clean_name) }))
}

# Create NAT Gateway for private subnets if enabled
resource "aws_nat_gateway" "natgw" {
  allocation_id = element(aws_eip.nateip.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  count         = length(var.azs) * (var.enable_nat_gateway ? 1 : 0)
  tags          = merge(var.tags, tomap({ "Name" = format("%s-%s-NAT-GW", local.clean_name, element(var.azs, count.index)) }))

  depends_on = [aws_internet_gateway.vpc]
}

# Create an egress-only internet gateway for IPv6 traffic (if IPv6 is enabled)
resource "aws_egress_only_internet_gateway" "ipv6_private_gw" {
  count  = var.enable_ipv6 ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.tags, tomap({ "Name" = format("%s-EOIGW", local.clean_name) }))
}

######################################################################
### Route Tables: Create Public and Private Route Tables             ###
######################################################################

# Route for public subnets to route traffic to the internet gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc.id
}

# Route for IPv6-enabled public subnets to route traffic to the internet gateway
resource "aws_route" "ipv6_public_internet_gateway" {
  count                       = var.enable_ipv6 ? 1 : 0
  route_table_id              = aws_route_table.public.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.vpc.id
}

# Route for private subnets to route traffic to NAT Gateway
resource "aws_route" "private_nat_gateway" {
  count                  = var.enable_nat_gateway ? length(aws_nat_gateway.natgw.*.id) : 0
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.natgw.*.id, count.index)
}

# Route for IPv6 traffic from private subnets to egress-only internet gateway
resource "aws_route" "ipv6_private_subnet_default" {
  count                       = var.enable_ipv6 ? length(aws_route_table.private.*.id) : 0
  route_table_id              = element(aws_route_table.private.*.id, count.index)
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.ipv6_private_gw[0].id
}

# Public route table for the VPC
resource "aws_route_table" "public" {
  vpc_id           = aws_vpc.vpc.id
  propagating_vgws = var.public_propagating_vgws
  tags             = merge(var.tags, { Name = format("%sPublic", var.name) })
}

# Private route table for the VPC
resource "aws_route_table" "private" {
  vpc_id           = aws_vpc.vpc.id
  propagating_vgws = var.private_propagating_vgws
  count            = length(var.azs)
  tags             = merge(var.tags, tomap({ "Name" = format("%sPrivate-%s", var.name, element(var.azs, count.index)) }))
}

######################################################################
### Route Table Associations: Assign Subnets to Route Tables        ###
######################################################################

# Associate private subnets with private route tables
resource "aws_route_table_association" "private" {
  count          = length(var.azs)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public" {
  count          = length(var.azs)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

######################################################################
### VPC Endpoint for S3: Setup S3 VPC Endpoint and Route Table Associations ###
######################################################################

# Create VPC endpoint for S3 if enabled
data "aws_vpc_endpoint_service" "s3" {
  count        = var.enable_s3_endpoint ? 1 : 0
  service      = "s3"
  service_type = "Gateway"
}

# Create the VPC endpoint for S3
resource "aws_vpc_endpoint" "s3" {
  count        = var.enable_s3_endpoint ? 1 : 0
  vpc_id       = aws_vpc.vpc.id
  service_name = data.aws_vpc_endpoint_service.s3[0].service_name
  tags         = merge(var.tags, tomap({ "Name" = format("%s-s3-endpoint", local.clean_name) }))
}

# Associate the S3 VPC endpoint with private subnets' route tables
resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  count           = length(aws_subnet.private) * (var.enable_s3_endpoint ? 1 : 0)
  vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
  route_table_id  = element(aws_route_table.private.*.id, count.index)
}

# Associate the S3 VPC endpoint with public subnets' route tables (if needed)
resource "aws_vpc_endpoint_route_table_association" "public_s3" {
  count           = length(var.public_subnets) * (var.enable_s3_endpoint ? 1 : 0)
  vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
  route_table_id  = aws_route_table.public.id
}
