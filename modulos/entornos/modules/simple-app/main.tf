resource "random_pet" "instance" {
  length = 2
}

resource "local_file" "config" {
  filename = "${path.root}/configs/${var.environment}-${var.app_name}.conf"
  
  content = <<-EOT
    environment=${var.environment}
    app_name=${var.app_name}
    port=${var.port}
    instance=${random_pet.instance.id}
  EOT
}