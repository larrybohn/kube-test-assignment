resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx-ingress"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  namespace  = "nginx-ingress"
  repository = "oci://ghcr.io/nginx/charts/"
  chart      = "nginx-ingress"
  
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

  set {
    name = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  depends_on = [azurerm_kubernetes_cluster.aks]
}
