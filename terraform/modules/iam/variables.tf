##################################################################################
### Variables of IAM Role                                                      ###
##################################################################################

# IAM Role Basic Information
variable "role_name" {
  description = "The name of the IAM Role"
  type        = string
}

variable "assume_role_policy" {
  description = "The assume role policy for the IAM role"
  type        = string
}

variable "path" {
  type        = string
  description = "The path to the role"
}

variable "description" {
  description = "The description of the IAM role"
  type        = string
}

# IAM Instance Profile Configuration
variable "create_instance_profile" {
  description = "Whether to create an IAM instance profile for the role"
  type        = bool
}

# IAM Policy Configuration
variable "custom_iam_policies" {
  description = "The custom IAM policies to be attached with the IAM role"
  type = list(object({
    name            = string
    description     = string
    policy_document = string
  }))
  default = []
}

variable "managed_iam_policies" {
  description = "The list of managed policies that need to be attached to the IAM Role"
  type        = list(string)
}

# IAM Role Management
variable "force_detach_policies" {
  description = "Force detach policies when deleting the IAM Role"
  type        = bool
}

variable "max_session_duration" {
  description = "The maximum session duration for the role"
  type        = number
}

# IAM Tags
variable "tags" {
  description = "A map of tags"
  type        = map(string)
}
