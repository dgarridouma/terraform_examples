variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
}

variable "image" {
  description = "Imagen Docker a usar"
  type        = string
}

variable "port_internal" {
  description = "Puerto interno del contenedor"
  type        = number
  default     = 80
}

variable "port_external" {
  description = "Puerto externo expuesto"
  type        = number
}

variable "environment_vars" {
  description = "Variables de entorno"
  type        = list(string)
  default     = []
}

variable "network_name" {
  description = "Nombre de la red Docker"
  type        = string
}