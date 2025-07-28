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
  version    = "6.50.0" # Use an appropriate Grafana Helm chart version

  values = [
    file("${path.module}/values.yaml")
  ]

  # This `wait` is crucial for the LoadBalancer IP to be assigned before we try to read it.
  # The `timeout` might need adjustment based on your cluster and network speed.
  wait       = true
  timeout    = "5"
}

# Data source to fetch the Kubernetes Service created by the Helm chart
# We need to wait for the LoadBalancer to get an ingress IP.
# This part is tricky because the IP is assigned asynchronously by Azure's Load Balancer controller.
# We'll use a local-exec provisioner to wait and then fetch, or rely on helm_release wait.
# A better, more robust way in production is to query Azure's Load Balancer public IP associated with the service.

data "kubernetes_service" "grafana_lb" {
  metadata {
    name      = "grafana" # Default service name from Grafana Helm chart
    namespace = kubernetes_namespace.grafana.metadata[0].name
  }
  # This 'depends_on' ensures the Helm release is applied before we try to read the service
  depends_on = [helm_release.grafana]

  # Polling mechanism to wait for the LoadBalancer Ingress IP to be assigned
  # This is a bit of a hack, a more robust solution might involve null_resource and local-exec loops
  # or dedicated `azurerm_public_ip` resources if you want a static IP for Grafana LB.
  # For the purpose of demonstration, this will try to read it.
  # In a real scenario, you might need to use `kubectl` in a `local-exec` to get it,
  # or query Azure's API for the Public IP associated with the AKS Load Balancer's frontend IP configuration.
}

output "grafana_public_ip" {
  value = coalesce(
    try(data.kubernetes_service.grafana_lb.status[0].load_balancer[0].ingress[0].ip, null),
    "waiting_for_ip" # Placeholder if IP isn't immediately available during plan
  )
  description = "The public IP address of the Grafana LoadBalancer service."
}