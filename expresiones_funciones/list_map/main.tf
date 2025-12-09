variable "servers" {
  default = ["web1", "web2", "db1", "web1"]  # Con duplicado
}

resource "local_file" "server_list" {
  filename = "${path.module}/servers.txt"
  content  = <<-EOT
    Total servers: ${length(var.servers)}
    Unique servers: ${length(distinct(var.servers))}
    Server list: ${join(", ", distinct(var.servers))}
    First server: ${element(var.servers, 0)}
  EOT
}
