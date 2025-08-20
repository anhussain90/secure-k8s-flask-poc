module "remote_state" {
  source = "../../modules/remote-state"

  environment  = "bootstrap"
  project_name = "secure-k8s-flask-poc"
}