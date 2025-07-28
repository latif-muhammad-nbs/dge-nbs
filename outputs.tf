output "aks_kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}

output "grafana_public_ip" {
  value = module.grafana.grafana_public_ip
}