variable "filenames" {
  type    = list(string)
  default = ["config.txt", "data.txt", "log.txt"]
}

resource "local_file" "files" {
  count    = length(var.filenames)
  filename = "${path.module}/${var.filenames[count.index]}"
  content  = "Archivo número ${count.index + 1}"
}
