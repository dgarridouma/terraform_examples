module "app" {
  source = "../../modules/simple-app"
  
  environment = "prod"
  app_name    = "myapp"
  port        = 80
}

output "info" {
  value = {
    config   = module.app.config_path
    instance = module.app.instance_name
  }
}