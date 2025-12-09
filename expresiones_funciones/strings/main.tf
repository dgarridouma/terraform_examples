variable "project" {
  default = "MyWebApp"
}

variable "environment" {
  default = "PRODUCTION"
}

resource "local_file" "normalized_config" {
  filename = "${path.module}/${lower(var.project)}-config.txt"
  content  = <<-EOT
    Project: ${title(var.project)}
    Environment: ${upper(var.environment)}
    Normalized: ${lower(replace(var.project, " ", "-"))}
  EOT
}
