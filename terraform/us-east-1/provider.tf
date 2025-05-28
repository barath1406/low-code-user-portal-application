##################################################################################
# PROVIDERS
##################################################################################

# This block configures the AWS provider
# The AWS region is dynamically set via the variable `var.region`
provider "aws" {
  region = var.region
}
