##################################################################################
#                          Module: S3 Bucket for Secure Data                     #
##################################################################################
module "s3_bucket" {
  source      = "../modules/s3"

  # Basic S3 configuration
  bucket_name = "${var.bucket_name}-${data.aws_caller_identity.current.account_id}"
  account_nbr = data.aws_caller_identity.current.account_id
  acl         = var.acl
  enabled     = var.enabled
  tags        = var.tags
}
