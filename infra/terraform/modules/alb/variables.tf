variable "name" {
  description = "ALB name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "target_port" {
  description = "Target group port"
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/healthz"
}

variable "certificate_arn" {
  description = "SSL certificate ARN"
  type        = string
  default     = null
}