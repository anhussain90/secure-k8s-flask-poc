variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "secure-flask-poc"
}

variable "github_repository" {
  description = "GitHub repository in format owner/repo"
  type        = string
  default     = "anhussain90/secure-k8s-flask-poc"
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
  default     = "port8080"
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  type        = string
  default     = "XXXXXXXX"
}