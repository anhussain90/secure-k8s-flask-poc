terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "poc"
      Project     = "secure-k8s-flask-poc"
      Repository  = "https://github.com/yourusername/secure-k8s-flask-poc"
    }
  }
}