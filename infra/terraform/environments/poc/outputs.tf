output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

output "ecr_repository_arn" {
  description = "ECR repository ARN"
  value       = module.ecr.repository_arn
}

output "terraform_role_arn" {
  description = "GitHub Actions Terraform role ARN"
  value       = module.github.terraform_role_arn
}

output "ecr_role_arn" {
  description = "GitHub Actions ECR role ARN"
  value       = module.github.ecr_role_arn
}