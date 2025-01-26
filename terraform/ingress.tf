resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx-ingress"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  namespace  = kubernetes_namespace.nginx.metadata[0].name
  repository = "https://charts.nginx.com/stable"
  chart      = "nginx-ingress"
  version    = "3.35.0"

  set {
    name  = "controller.service.externalPorts[0].port"
    value = "80"
  }

  set {
    name  = "controller.service.externalPorts[1].port"
    value = "443"
  }

  set {
    name  = "controller.service.externalPorts[2].port"
    value = "8989"
  }

  depends_on = [azurerm_kubernetes_cluster.aks]
}
