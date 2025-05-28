##################################################################################
### Outputs for S3 Resources                                                   ###
##################################################################################

# Output for the S3 bucket ID
output "bucket_id" {
  description = "The ID of the bucket"
  value       = aws_s3_bucket.secure_s3.id
}

# Output for the S3 bucket ARN
output "bucket_arn" {
  description = "The ARN of the bucket"
  value       = aws_s3_bucket.secure_s3.arn
}
