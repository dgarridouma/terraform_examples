terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "app" {
  name         = var.image
  keep_locally = false
}

resource "docker_container" "app" {
  name  = var.app_name
  image = docker_image.app.image_id
  
  ports {
    internal = var.port_internal
    external = var.port_external
  }
  
  env = var.environment_vars
  
  networks_advanced {
    name = var.network_name
  }
  
  labels {
    label = "managed_by"
    value = "terraform"
  }
}