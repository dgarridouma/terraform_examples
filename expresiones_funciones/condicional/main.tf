variable "environment" {
  default = "production"
}

resource "local_file" "config" {
  filename = "${path.module}/app.conf"
  content  = var.environment == "production" ? "mode=prod\ndebug=false" : "mode=dev\ndebug=true"
}
