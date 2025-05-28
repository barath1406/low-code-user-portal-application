##################################################################################
### Variables of S3                                                            ###
##################################################################################

# Variables related to the S3 bucket configuration
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "acl" {
  description = "The canned ACL to apply"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

# Variables related to account and enabled settings
variable "account_nbr" {
  description = "Self account number"
  type        = string
}

variable "enabled" {
  description = "Whether the peering connection should be enabled"
  type        = bool
}
