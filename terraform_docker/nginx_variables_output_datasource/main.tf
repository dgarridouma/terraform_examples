resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Recurso: contenedor Docker
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name

  ports {
    internal = 80
    external = 8000
  }

  # Usar la red obtenida del data source
  networks_advanced {
    name = data.docker_network.bridge.name
  }
}
