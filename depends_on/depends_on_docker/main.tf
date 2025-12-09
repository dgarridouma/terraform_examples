terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "app" {
  name = "app-network"
}

resource "docker_image" "postgres" {
  name = "postgres:15-alpine"
}

resource "docker_container" "db" {
  name  = "postgres"
  image = docker_image.postgres.image_id
  
  env = [
    "POSTGRES_PASSWORD=mypassword",
    "POSTGRES_DB=myapp"
  ]
  
  depends_on = [docker_network.app]
  
  networks_advanced {
    name = docker_network.app.name
  }
}

resource "docker_container" "app" {
  name  = "app"
  image = "nginx:alpine"
  
  env = [
    "DB_HOST=postgres"
  ]
  
  depends_on = [docker_container.db]
  
  networks_advanced {
    name = docker_network.app.name
  }
}