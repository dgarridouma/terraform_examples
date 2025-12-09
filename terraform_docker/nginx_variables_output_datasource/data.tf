# Data source: consultar imagen Docker existente
data "docker_image" "nginx_info" {
  name = "nginx:latest"
}

# Data source: consultar la red bridge por defecto de Docker
data "docker_network" "bridge" {
  name = "bridge"
}