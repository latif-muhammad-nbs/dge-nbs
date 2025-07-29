output "grafana_public_ip" {
  value = coalesce(
    try(data.kubernetes_service.grafana_lb.status[0].load_balancer[0].ingress[0].ip, null),
    "waiting_for_ip" 
  )
  description = "The public IP address of the Grafana LoadBalancer service."
}