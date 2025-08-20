module "ecr" {
  source = "../../modules/ecr"

  repository_name = var.repository_name
  environment     = "poc"
}

module "github" {
  source = "../../modules/github"

  github_repository = var.github_repository
  aws_region        = var.aws_region
  repository_name   = var.repository_name
}