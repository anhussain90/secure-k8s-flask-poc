variable "github_repository" {
  description = "GitHub repository in format owner/repo"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "repository_name" {
  description = "ECR repository name"
  type        = string
}