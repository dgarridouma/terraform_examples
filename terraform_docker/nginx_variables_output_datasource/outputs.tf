output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.nginx.id
}

output "image_id" {
  description = "ID of the Docker image"
  value       = docker_image.nginx.id
}

# Output: información del data source de la imagen
output "image_info" {
  description = "Información de la imagen Docker consultada"
  value = {
    id     = data.docker_image.nginx_info.id
    name   = data.docker_image.nginx_info.name
    digest = data.docker_image.nginx_info.repo_digest
  }
}

# Output: información de la red
output "network_info" {
  description = "Información de la red Docker"
  value = {
    name   = data.docker_network.bridge.name
    driver = data.docker_network.bridge.driver
    scope  = data.docker_network.bridge.scope
  }
}

