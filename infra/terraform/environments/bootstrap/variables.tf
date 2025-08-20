variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "secure-k8s-flask-poc"
}

variable "repository_url" {
  description = "Repository URL"
  type        = string
  default     = "https://github.com/anhussain90/secure-k8s-flask-poc"
}