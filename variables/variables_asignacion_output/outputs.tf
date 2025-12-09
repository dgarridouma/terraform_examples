output "config_file_path" {
  description = "Ruta del archivo de configuración"
  value       = local_file.app_config.filename
}

output "config_file_id" {
  description = "ID del recurso de archivo"
  value       = local_file.app_config.id
}

output "config_content_hash" {
  description = "Hash MD5 del contenido"
  value       = local_file.app_config.content_md5
}

output "app_settings" {
  description = "Resumen de la configuración"
  value = {
    name            = var.app_name
    max_connections = var.max_connections
    logging         = var.enable_logging
  }
}