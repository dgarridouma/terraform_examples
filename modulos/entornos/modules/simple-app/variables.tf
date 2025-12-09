variable "environment" {
  description = "Entorno (dev, staging, prod)"
  type        = string
}

variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
}

variable "port" {
  description = "Puerto de la aplicación"
  type        = number
  default     = 8080
}