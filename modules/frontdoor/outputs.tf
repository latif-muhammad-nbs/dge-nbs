output "frontdoor_endpoint" {
  description = "Public HTTPS endpoint for Grafana via Azure Front Door"
  value       = "https://${azurerm_cdn_frontdoor_endpoint.main.host_name}"
}