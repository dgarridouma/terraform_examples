variable "environments" {
  type    = set(string)
  default = ["dev", "staging", "prod"]
}

resource "random_id" "env_id" {
  for_each    = var.environments
  byte_length = 4
}

resource "local_file" "env_configs" {
  for_each = var.environments
  
  filename = "${path.module}/${each.key}-${random_id.env_id[each.key].hex}.conf"
  content  = "Environment: ${each.key}\nID: ${random_id.env_id[each.key].hex}"
}

# Crea: dev-a3b2c1d4.conf, staging-e5f6g7h8.conf, prod-i9j0k1l2.conf