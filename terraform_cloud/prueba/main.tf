terraform {
  cloud {

    organization = "terraform_uma"

    workspaces {
      name = "miworkspace"
    }
  }

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0.0"
    }
  }
}


provider "local" {}

resource "local_file" "example" {
  filename = "${path.module}/mensaje.txt"
  content  = "¡Hola desde Terraform Cloud!"
}