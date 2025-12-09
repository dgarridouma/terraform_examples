
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "random" {}


module "random_string" {
  source          = "dgarridouma/string-generator/local"
  length          = 12
  include_special = false
}

output "generated_string" {
  value = module.random_string.random_string
}
