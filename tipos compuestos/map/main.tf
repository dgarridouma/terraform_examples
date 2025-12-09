variable "files_content" {
  type = map(string)
  default = {
    "readme.txt"  = "Bienvenido al proyecto"
    "config.txt"  = "env=development"
    "version.txt" = "1.0.0"
  }
}

resource "local_file" "config_files" {
  for_each = var.files_content
  
  filename = "${path.module}/${each.key}"
  content  = each.value
}
