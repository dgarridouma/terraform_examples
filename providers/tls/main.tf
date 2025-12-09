
terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "tls" {}
provider "local" {}

# 1. Generar clave privada RSA
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# 2. Crear certificado autofirmado
resource "tls_self_signed_cert" "example" {
  private_key_pem = tls_private_key.example.private_key_pem

  subject {
    common_name  = "example.local"
    organization = "MiOrganizacion"
  }

  validity_period_hours = 8760 # 1 año
  allowed_uses          = ["key_encipherment", "digital_signature", "server_auth"]
}

# 3. Guardar clave privada en fichero local (sensible)
resource "local_sensitive_file" "private_key" {
  filename = "${path.module}/private_key.pem"
  content  = tls_private_key.example.private_key_pem
}

# 4. Guardar certificado en fichero local
resource "local_file" "certificate" {
  filename = "${path.module}/certificate.pem"
  content  = tls_self_signed_cert.example.cert_pem
}

# 5. Outputs
output "certificate" {
  value = tls_self_signed_cert.example.cert_pem
}

output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}
