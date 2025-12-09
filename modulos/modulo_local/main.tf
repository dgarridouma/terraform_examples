# main.tf
module "web" {
  source = "./modules/simple-config"
  
  service_name = "web"
  port         = 80
}

module "api" {
  source = "./modules/simple-config"
  
  service_name = "api"
  port         = 3000
}

output "configs" {
  value = {
    web = module.web.config_path
    api = module.api.config_path
  }
}