module "app" {
  source = "../../modules/simple-app"
  
  environment = "dev"
  app_name    = "myapp"
  port        = 3000
}

output "info" {
  value = {
    config   = module.app.config_path
    instance = module.app.instance_name
  }
}