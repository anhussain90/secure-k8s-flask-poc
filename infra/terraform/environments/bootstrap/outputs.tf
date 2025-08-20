output "s3_bucket_name" {
  description = "S3 bucket name for Terraform state"
  value       = module.remote_state.s3_bucket_name
}

output "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  value       = module.remote_state.dynamodb_table_name
}

output "backend_config" {
  description = "Backend configuration for other environments"
  value = {
    bucket         = module.remote_state.s3_bucket_name
    dynamodb_table = module.remote_state.dynamodb_table_name
    region         = "eu-west-2"
    encrypt        = true
  }
}