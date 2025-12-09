variable "environment" {
  type = string
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser dev, staging o prod"
  }
}

# terraform apply -var="environment=test"
# Error: El entorno debe ser: dev, staging o prod