resource "kubernetes_namespace" "demo" {
  metadata {
    name = "demo-namespace"
  }
}


resource "kubernetes_manifest" "nginx_yaml" {
  manifest = yamldecode(file("${path.module}/nginx-deployment.yml"))
}
