resource "local_file" "app_config" {
  filename = "${path.module}/${var.app_name}.conf"
  content  = <<-EOT
    app_name: ${var.app_name}
    max_connections: ${var.max_connections}
    logging_enabled: ${var.enable_logging}
  EOT
}
