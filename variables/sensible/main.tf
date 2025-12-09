variable "database_password" {
  description = "Password de la base de datos"
  type        = string
  sensitive   = true  # ← Marca como sensible
}

variable "api_key" {
  description = "API key para servicio externo"
  type        = string
  sensitive   = true
}

output "db_connection" {
  description = "String de conexión (oculto)"
  value       = "postgres://user:${var.database_password}@host/db"
  sensitive   = true  # ← Output sensible también
}