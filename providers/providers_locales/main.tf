
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "random" {}
provider "time" {}
provider "local" {}

# Generar un nombre aleatorio tipo "curious-cat"
resource "random_pet" "name" {
  length    = 2
  separator = "-"
}

# Generar una contraseña aleatoria segura
resource "random_password" "pwd" {
  length  = 16
  special = true
}

# Obtener la fecha y hora actual
resource "time_static" "now" {}

# Crear un fichero local con información pública
resource "local_file" "info" {
  filename = "${path.module}/info.txt"
  content  = <<EOT
Nombre generado: ${random_pet.name.id}
Fecha actual: ${time_static.now.rfc3339}
EOT
}

# Crear un fichero sensible con la contraseña
resource "local_sensitive_file" "secret" {
  filename = "${path.module}/secret.txt"
  content  = random_password.pwd.result
}

# Ejecutar un comando local usando null_resource
resource "null_resource" "echo" {
  provisioner "local-exec" {
    command = "echo 'Nombre: ${random_pet.name.id}, Contraseña: [oculta], Fecha: ${time_static.now.rfc3339}'"
  }
}

# Outputs para mostrar los valores
output "random_pet_name" {
  value = random_pet.name.id
}

output "random_password" {
  value     = random_password.pwd.result
  sensitive = true
}

output "current_time" {
  value = time_static.now.rfc3339
}
