# modules/simple-config/main.tf
resource "random_pet" "name" {
  length = 2
}

resource "local_file" "config" {
  filename = "${path.module}/../../configs/${var.service_name}.conf"
  content  = <<-EOT
    service=${var.service_name}
    port=${var.port}
    instance=${random_pet.name.id}
  EOT
}