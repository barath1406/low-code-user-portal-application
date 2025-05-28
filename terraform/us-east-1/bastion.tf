##################################################################################
### Module for Bastion EC2 
##################################################################################
module "bastion" {
  source                             = "../modules/bastion"
  bastion_name                       = var.bastion_name
  vpc_id                             = module.vpc1.vpc_id
  public_subnet_ids                  = module.vpc1.public_subnets
  instance_type                      = var.bastion_instance_type
  ami_id                             = data.aws_ami.bastion.id
  key_name                           = var.bastion_key_name
  associate_public_ip_address        = var.associate_public_ip_address
  private_key_file_permission        = var.private_key_file_permission
  security_group_ids                 = [module.bastion_sg.security_group_id]
  bastion_host_iam_instance_profile  = data.aws_iam_instance_profile.bastion_host_instance_profile.role_name
  tags                               = merge(var.tags, var.bastion_patch_group_tags)
}

##################################################################################
### Module for Bastion EC2 Security Group 
##################################################################################
module "bastion_sg" {
  source         = "../modules/sg"
  sg_name        = var.bastion_sg_name
  sg_description = var.bastion_sg_description
  vpc_id         = module.vpc1.vpc_id
  ingress_rules  = var.bastion_sg_ingress_rules
  egress_rules   = var.bastion_sg_egress_rules
  tags           = var.tags
}