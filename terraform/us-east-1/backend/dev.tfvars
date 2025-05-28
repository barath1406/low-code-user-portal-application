### S3 Backend Configuration for Terraform State Management ###

# Name of the S3 bucket where the Terraform state file will be stored
bucket = "sre-falcon-tf-state"

# The path within the bucket where the state file will be saved
key = "us-east-1_barath_challenge.tfstate"

# AWS region where the S3 bucket and DynamoDB table are located
region = "us-east-1"

# Enable server-side encryption for the state file in the S3 bucket
encrypt = true

# Name of the DynamoDB table used for state locking and consistency
dynamodb_table = "terraform-state-lock"

