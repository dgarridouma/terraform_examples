variable "containers" {
  type = map(object({
    image    = string
    internal = number
    external = number
  }))
  default = {
    web = {
      image    = "nginx:latest"
      internal = 80
      external = 8080
    }
    api = {
      image    = "httpd:latest"
      internal = 80
      external = 8081
    }
    cache = {
      image    = "redis:alpine"
      internal = 6379
      external = 6379
    }
  }
}

variable "network_name" {
  type    = string
  default = "mi-red-docker"
}