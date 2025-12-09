# main.tf
resource "local_file" "config" {
  filename = "${path.module}/config.txt"
  content  = "Puerto: 8080\nTimestamp: ${timestamp()}"
  
  lifecycle {
    ignore_changes = [content]
  }
}

resource "local_file" "datos_importantes" {
  filename = "${path.module}/datos.txt"
  content  = "Datos críticos del sistema"
  
  lifecycle {
    prevent_destroy = true
  }
}
