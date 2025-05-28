##################################################################################
### Terraform Configuration - Required Versions ###
##################################################################################

# Define the required versions for Terraform and its providers
terraform {
  # Specify the required provider plugins
  required_providers {
    
    # AWS provider to interact with Amazon Web Services
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.90" 
    }

    # Kubernetes provider to manage Kubernetes resources
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20" 
    }

    # Helm provider to manage Helm charts in Kubernetes
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9" 
    }
  }

  # Specify the required version of Terraform itself
  required_version = "1.9.8"
}
