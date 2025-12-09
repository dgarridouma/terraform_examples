variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
  default     = "myapp"
}

variable "max_connections" {
  description = "Máximo de conexiones"
  type        = number
  default     = 100
}

variable "enable_logging" {
  description = "Activar logs"
  type        = bool
  default     = true
}
