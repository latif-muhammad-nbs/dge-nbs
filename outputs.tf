output "aks_kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}

output "grafana_public_ip" {
  value = module.grafana.grafana_public_ip
}

output "grafana_frontdoor_endpoint" {
  description = "Public HTTPS endpoint exposed via Azure Front Door"
  value       = module.frontdoor.frontdoor_endpoint
}