locals {
  # Nombre normalizado
  normalized_name = lower(replace(var.app_name, " ", "-"))
  
  # Configuración calculada
  connection_pool_size = var.max_connections * 2
  
  # Path completo
  config_path = "${path.module}/configs/${local.normalized_name}.conf"
  
  # Metadata
  config_metadata = {
    app              = var.app_name
    max_conn         = var.max_connections
    logging          = var.enable_logging ? "enabled" : "disabled"
    generated_at     = timestamp()
  }
}

resource "local_file" "app_config" {
  filename = local.config_path
  content  = <<-EOT
    # Application Configuration
    app_name: ${var.app_name}
    normalized_name: ${local.normalized_name}
    
    # Connection Settings
    max_connections: ${var.max_connections}
    connection_pool_size: ${local.connection_pool_size}
    
    # Features
    logging_enabled: ${var.enable_logging}
    logging_status: ${local.config_metadata.logging}
    
    # Metadata
    generated_at: ${local.config_metadata.generated_at}
  EOT
  
  file_permission = "0644"
}




