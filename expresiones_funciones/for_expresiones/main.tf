variable "users" {
  default = ["alice", "bob", "charlie"]
}

variable "permissions" {
  default = {
    alice   = "admin"
    bob     = "user"
    charlie = "guest"
  }
}

resource "local_file" "user_configs" {
  for_each = toset(var.users)
  
  filename = "${path.module}/users/${each.value}.conf"
  content  = <<-EOT
    Username: ${upper(each.value)}
    Role: ${lookup(var.permissions, each.value, "unknown")}
    Email: ${lower(each.value)}@example.com
  EOT
}

# Lista de emails usando for
output "user_emails" {
  value = [for user in var.users : "${user}@example.com"]
}

# Map de roles en mayúsculas
output "roles_upper" {
  value = {for k, v in var.permissions : k => upper(v)}
}