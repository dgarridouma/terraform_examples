output "container_id" {
  description = "ID del contenedor"
  value       = docker_container.app.id
}

output "container_name" {
  description = "Nombre del contenedor"
  value       = docker_container.app.name
}

output "url" {
  description = "URL de acceso"
  value       = "http://localhost:${var.port_external}"
}