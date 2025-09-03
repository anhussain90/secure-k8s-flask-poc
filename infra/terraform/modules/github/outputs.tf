output "terraform_role_arn" {
  description = "ARN of the GitHub Actions Terraform role"
  value       = aws_iam_role.github_actions_terraform.arn
}

output "ecr_role_arn" {
  description = "ARN of the GitHub Actions ECR role"
  value       = aws_iam_role.github_actions_ecr.arn
}

