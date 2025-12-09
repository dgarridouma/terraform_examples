module "app" {
  source = "../../modules/simple-app"
  
  environment = "staging"
  app_name    = "myapp"
  port        = 8080
}

output "info" {
  value = {
    config   = module.app.config_path
    instance = module.app.instance_name
  }
}