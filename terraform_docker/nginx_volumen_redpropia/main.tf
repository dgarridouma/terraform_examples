# Variable para el nombre del contenedor nginx
variable "container_name" {
  description = "Nombre del contenedor nginx"
  type        = string
  default     = "nginx"
}

# Red personalizada para los contenedores
resource "docker_network" "app_network" {
  name = "app_network"
}

# Volumen para persistir logs de nginx
resource "docker_volume" "nginx_logs" {
  name = "nginx_logs"
}

# Volumen para persistir datos de Redis
resource "docker_volume" "redis_data" {
  name = "redis_data"
}

# Imagen de nginx
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Imagen de Redis
resource "docker_image" "redis" {
  name         = "redis:alpine"
  keep_locally = false
}

# Contenedor Redis con persistencia
resource "docker_container" "redis" {
  image = docker_image.redis.image_id
  name  = "redis"

  volumes {
    volume_name    = docker_volume.redis_data.name
    container_path = "/data"
  }

  networks_advanced {
    name = docker_network.app_network.name
  }
}

# Contenedor nginx
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name

  ports {
    internal = 80
    external = 8000
  }

  # Volumen para persistir logs
  volumes {
    volume_name    = docker_volume.nginx_logs.name
    container_path = "/var/log/nginx"
  }

  # Conectar a la red personalizada (puede comunicarse con redis)
  networks_advanced {
    name = docker_network.app_network.name
  }
}

# Outputs
output "nginx_url" {
  description = "URL para acceder al servidor nginx"
  value       = "http://localhost:8000"
}

output "network_name" {
  description = "Nombre de la red Docker creada"
  value       = docker_network.app_network.name
}

output "volume_name" {
  description = "Nombre del volumen para logs"
  value       = docker_volume.nginx_logs.name
}

output "redis_volume_name" {
  description = "Nombre del volumen para datos de Redis"
  value       = docker_volume.redis_data.name
}