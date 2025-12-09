terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Red compartida
resource "docker_network" "app_network" {
  name = "myapp-network"
}

# Usar el módulo para nginx
module "web" {
  source = "./modules/docker-app"
  
  app_name       = "web-frontend"
  image          = "nginx:alpine"
  port_internal  = 80
  port_external  = 8080
  network_name   = docker_network.app_network.name
  
  environment_vars = [
    "ENV=production"
  ]
}

# Usar el módulo para API
module "api" {
  source = "./modules/docker-app"
  
  app_name       = "api-backend"
  image          = "httpd:alpine"
  port_internal  = 80
  port_external  = 8081
  network_name   = docker_network.app_network.name
}

# Acceder a outputs del módulo
output "web_url" {
  value = module.web.url
}

output "api_url" {
  value = module.api.url
}