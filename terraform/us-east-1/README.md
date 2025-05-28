# Regional and base infrastructure resources for the Frankfurt region

This section is configured to read outputs from the global section state file.

## Infrastructure Resources Overview

This Terraform configuration provisions the following AWS resources in the Frankfurt (us-east-1) region:

### Virtual Private Clouds (VPCs) and Networking
- **Compute VPC (vpc1)**: A VPC dedicated to compute resources, including public and private subnets, NAT gateways, and optionally S3 endpoints.
- **Data VPC (vpc2)**: A separate VPC for data-related resources, also with public and private subnets.
- **VPC Peering**: Establishes a peering connection between the compute and data VPCs to enable secure communication between resources in both VPCs.

### Amazon Elastic Kubernetes Service (EKS)
- **EKS Cluster**: A managed Kubernetes cluster deployed within the compute VPC private subnets.
- **EKS Node Group**: Worker nodes for the EKS cluster, configured with scaling parameters, instance types, and security groups.
- **Security Groups**: Dedicated security groups for the EKS cluster and node groups.
- **SSH Key Pair**: An SSH key pair generated for accessing the worker nodes.

### Amazon Aurora RDS
- **Aurora MySQL Cluster**: A highly available and scalable relational database cluster deployed in the data VPC private subnets.
- **RDS Security Group**: Controls network access to the Aurora cluster.

### AWS Lambda
- **Lambda Function**: A serverless function deployed within the data VPC private subnets, with environment variables configured for database and S3 access.
- **Lambda Security Group**: Controls network access for the Lambda function.

### Amazon S3
- **S3 Bucket**: A private S3 bucket for storing secure data, named using a combination of a variable and the AWS account ID.

### Bastion Host
- **Bastion EC2 Instance**: An EC2 instance deployed in the compute VPC public subnets to provide secure SSH access to private resources.
- **Bastion Security Group**: Controls network access to the bastion host.

### AWS Load Balancer Controller
- **Load Balancer Controller**: Deployed on the EKS cluster using Helm, manages AWS load balancers for Kubernetes services.
- **Kubernetes and Helm Providers**: Configured to interact with the EKS cluster.

## Terraform Commands

Use the following commands to manage the infrastructure:

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
