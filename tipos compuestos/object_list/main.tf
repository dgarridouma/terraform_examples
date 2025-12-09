variable "servers" {
  type = list(object({
    name = string
    ip   = string
  }))
  default = [
    { name = "web1", ip = "10.0.1.10" },
    { name = "web2", ip = "10.0.1.11" },
    { name = "db1",  ip = "10.0.2.10" }
  ]
}

resource "local_file" "inventory" {
  count    = length(var.servers)
  filename = "${path.module}/${var.servers[count.index].name}.txt"
  content  = "Server IP: ${var.servers[count.index].ip}"
}