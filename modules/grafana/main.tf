resource "kubernetes_namespace" "grafana" {
  metadata {
    name = var.kubernetes_namespace
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.grafana.metadata[0].name
  version    = "6.50.0" 
  

  values = [
    file("${path.module}/values.yaml")
  ]

  
  wait       = true
  timeout    = "600"
}



data "kubernetes_service" "grafana_lb" {
  metadata {
    name      = "grafana" 
    namespace = kubernetes_namespace.grafana.metadata[0].name
  }
  
  depends_on = [helm_release.grafana]
}
  

