##################################################################################
### Terraform Provider Configuration ###
##################################################################################

terraform {
  # Required providers
  required_providers {
    aws = {
      source  = "hashicorp/aws" 
      version = "~> 5.90"        
    }
  }

  # Required Terraform version
  required_version = "1.9.8"  
}
