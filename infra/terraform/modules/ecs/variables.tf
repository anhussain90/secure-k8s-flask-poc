variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "task_family" {
  description = "ECS task definition family"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_image" {
  description = "Container image URI"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
  default     = 5000
}

variable "cpu" {
  description = "Task CPU"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Task memory"
  type        = string
  default     = "512"
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 1
}

variable "service_name" {
  description = "ECS service name"
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

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "alb_security_group_id" {
  description = "ALB security group ID"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}