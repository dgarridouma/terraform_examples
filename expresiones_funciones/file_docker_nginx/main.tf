resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_container" "app" {
  name  = "app"
  image = docker_image.nginx.name
  ports {
    internal = 80
    external = 8080
  }

  upload {
    content = file("${path.module}/index.html")
    file    = "/usr/share/nginx/html/index.html"
  }
}

