# Obtener info de una red Docker
data "docker_network" "existing" {
  name = "bridge"
}

# Usar la info
resource "docker_container" "app" {
  name  = "app"
  image = "nginx:latest"
  
  networks_advanced {
    name = data.docker_network.existing.id
  }
}
