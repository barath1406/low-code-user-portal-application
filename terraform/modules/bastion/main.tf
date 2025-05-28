##################################################################################
### Resource for Bastion EC2 Instance ###
##################################################################################
resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = element(var.public_subnet_ids, 0)
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  tags                        = merge(var.tags, { Name = var.bastion_name })
  iam_instance_profile        = var.bastion_host_iam_instance_profile
}

##################################################################################
### Key Pair Creation for Bastion EC2 ###
##################################################################################
resource "tls_private_key" "bastion_ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

##################################################################################
### AWS Key Pair for Bastion EC2 Instance ###
##################################################################################
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.bastion_ec2_key.public_key_openssh
}

##################################################################################
### Local File Resource to Store Private Key ###
##################################################################################
resource "local_file" "private_key_pem" {
  content         = tls_private_key.bastion_ec2_key.private_key_pem
  filename        = "${path.module}/generated_keys/my-key.pem"
  file_permission = var.private_key_file_permission
}
