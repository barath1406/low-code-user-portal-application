### S3 Backend Vars ### 
bucket         = "sre-falcon-tf-state"
key            = "global_barath_challenge.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-state-lock"
