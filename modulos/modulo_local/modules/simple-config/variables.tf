# modules/simple-config/variables.tf
variable "service_name" {
  description = "Nombre del servicio"
  type        = string
}

variable "port" {
  description = "Puerto del servicio"
  type        = number
  default     = 8080
}