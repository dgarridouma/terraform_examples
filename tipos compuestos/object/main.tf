variable "server_config" {
  type = object({
    hostname = string
    ip       = string
    port     = number
  })
  default = {
    hostname = "webserver"
    ip       = "192.168.1.10"
    port     = 8080
  }
}

resource "local_file" "server_info" {
  filename = "${path.module}/server.txt"
  content  = <<-EOT
    Hostname: ${var.server_config.hostname}
    IP: ${var.server_config.ip}
    Port: ${var.server_config.port}
  EOT
}