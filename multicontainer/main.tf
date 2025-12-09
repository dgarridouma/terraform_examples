terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Crear red Docker
resource "docker_network" "app_network" {
  name = var.network_name
}

# Descargar imágenes
resource "docker_image" "images" {
  for_each     = var.containers
  name         = each.value.image
  keep_locally = false
}

# Crear contenedores
resource "docker_container" "containers" {
  for_each = var.containers
  
  name  = each.key
  image = docker_image.images[each.key].image_id
  
  ports {
    internal = each.value.internal
    external = each.value.external
  }
  
  networks_advanced {
    name = docker_network.app_network.name
  }
  
  labels {
    label = "managed_by"
    value = "terraform"
  }
}