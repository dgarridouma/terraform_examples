# Crear archivo
resource "local_file" "config" {
  filename = "config.txt"
  content  = "server=localhost"
}

# Leer archivo existente
data "local_file" "existing" {
  filename = "config.txt"
  depends_on = [local_file.config]
}

output "file_content" {
  value = data.local_file.existing.content
}