# Global resources (for example IAM or Route53) should go in this section

This Terraform configuration provisions global AWS resources that are shared across regions and services, primarily focusing on IAM roles and policies.

## Global Infrastructure Resources Overview

### IAM Roles and Instance Profiles

- **Bastion Host IAM Role**: An IAM role and instance profile for the bastion host EC2 instance, allowing it to assume necessary permissions for secure access and management.
- **EKS Cluster IAM Role**: IAM role for the EKS cluster itself, granting permissions required for cluster operations.
- **EKS Node Group IAM Role**: IAM role and instance profile for the EKS worker nodes, enabling them to interact with AWS services securely.
- **Lambda IAM Role**: IAM role assigned to AWS Lambda functions, granting necessary permissions to execute and access other AWS resources.
- **Aurora RDS IAM Role**: IAM role for Aurora RDS monitoring and management, with appropriate assume role policies and managed policies.

### Data Sources

- **AWS Caller Identity**: Retrieves information about the AWS account and user executing Terraform.
- **AWS Region**: Retrieves the current AWS region.
- **IAM Policy Documents**: Defines assume role policies for the various IAM roles to specify trusted entities and permissions.

## Terraform Commands

Use the following commands to manage the global infrastructure:

```bash
# Initialize Terraform with backend configuration
terraform init --backend-config=backend/dev.tfvars

# Validate the configuration files
terraform validate

# Generate and show an execution plan using variable files
terraform plan --var-file=vars/dev.tfvars

# Apply the changes required to reach the desired state
terraform apply --var-file=vars/dev.tfvars

# Destroy the infrastructure managed by Terraform
terraform destroy --var-file=vars/dev.tfvars
