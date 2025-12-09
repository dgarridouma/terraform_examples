resource "kubernetes_namespace" "myapp" {
  metadata {
    name = "myapp"

    labels = {
      environment = "development"
    }
  }
}


variable "environment" {
  description = "Entorno"
  type        = string
  default     = "debug"
}


variable "db_username" {
  type = string
}


variable "db_password" {
  type      = string
  sensitive = true
}



resource "kubernetes_config_map" "app_config" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace.myapp.metadata[0].name
  }

  data = {
    database_host = "postgres.myapp.svc.cluster.local"
    database_port = "5432"
    log_level     = var.environment == "prod" ? "error" : "debug"
  }
}

resource "kubernetes_secret" "db_credentials" {
  metadata {
    name      = "db-credentials"
    namespace = kubernetes_namespace.myapp.metadata[0].name
  }

  type = "Opaque"

  data = {
    username = base64encode(var.db_username)
    password = base64encode(var.db_password)
  }
}


variable "app_replicas" {
  description = "Número de réplicas"
  type        = number
  default     = 3
}

resource "kubernetes_deployment" "app" {
  metadata {
    name      = "app"
    namespace = kubernetes_namespace.myapp.metadata[0].name
  }

  spec {
    replicas = var.app_replicas # Parametrizable

    selector {
      match_labels = {
        app = "myapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "myapp"
        }
      }

      spec {
        container {
          name  = "app"
          image = "nginx:alpine"

          port {
            container_port = 80
          }

          # Inyectar ConfigMap
          env_from {
            config_map_ref {
              name = kubernetes_config_map.app_config.metadata[0].name
            }
          }

          # Variable desde Secret
          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.db_credentials.metadata[0].name
                key  = "password"
              }
            }
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "app_external" {
  metadata {
    name      = "app-external"
    namespace = kubernetes_namespace.myapp.metadata[0].name
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = "myapp"
    }

    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
  }
}