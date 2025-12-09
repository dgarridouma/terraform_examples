terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

module "naming" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace = "demo"
  name      = "app"
  stage     = "dev"
}

output "full_name" {
  value = module.naming.id
}
