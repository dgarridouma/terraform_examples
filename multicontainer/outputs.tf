output "container_urls" {
  description = "URLs de acceso a los contenedores"
  value = {
    for k, v in docker_container.containers :
    k => "http://localhost:${v.ports[0].external}"
  }
}

output "network_info" {
  description = "Información de la red"
  value = {
    name = docker_network.app_network.name
    id   = docker_network.app_network.id
  }
}