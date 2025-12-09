# Primer recurso: archivo base
resource "local_file" "base" {
  filename = "${path.module}/base.txt"
  content  = "Este es el archivo base"
}

# Segundo recurso: archivo dependiente
resource "local_file" "dependiente" {
  filename = "${path.module}/dependiente.txt"
  content  = "Este archivo depende del base"

  # Forzamos la dependencia explícita
  depends_on = [local_file.base]
}
