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

module "alb" {
  source = "../../modules/alb"

  name              = "flask-poc-alb"
  vpc_id           = data.aws_vpc.default.id
  subnets          = data.aws_subnets.public.ids
  target_port      = 8080
  health_check_path = "/healthz"
}

module "ecs" {
  source = "../../modules/ecs"

  cluster_name           = "flask-poc"
  task_family           = "flask-app"
  service_name          = "flask-service"
  container_name        = "flask-app"
  container_image       = "${module.ecr.repository_url}:${var.image_tag}"
  container_port        = 8080
  vpc_id               = data.aws_vpc.default.id
  subnets              = data.aws_subnets.public.ids
  target_group_arn     = module.alb.target_group_arn
  alb_security_group_id = module.alb.security_group_id
  aws_region           = var.aws_region
}