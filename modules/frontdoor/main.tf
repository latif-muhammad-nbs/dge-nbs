resource "azurerm_cdn_frontdoor_profile" "main" {
  name                = var.frontdoor_name
  sku_name            = "Standard_AzureFrontDoor"
  resource_group_name = var.resource_group_name
}

resource "azurerm_cdn_frontdoor_endpoint" "main" {
  name                     = "${var.frontdoor_name}-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main.id
}

resource "azurerm_cdn_frontdoor_origin_group" "main" {
  name                     = "${var.frontdoor_name}-og"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main.id

  session_affinity_enabled = false
#   restore_traffic_time_to_healed_or_new_endpoint = "OneMinute"
  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 4
    successful_samples_required        = 3
  }

  health_probe {
    interval_in_seconds = 120
    path                = "/"
    protocol            = "Https"
    request_type        = "GET"
  }
}

resource "azurerm_cdn_frontdoor_origin" "main" {
  name                          = "${var.frontdoor_name}-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.main.id
  enabled                       = true
  host_name                     = var.origin_host_name
  http_port                     = 80
  https_port                    = 443
  certificate_name_check_enabled = false
}

resource "azurerm_cdn_frontdoor_route" "main" {
  name                          = "${var.frontdoor_name}-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.main.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.main.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.main.id]
#   cdn_frontdoor_profile_id      = azurerm_cdn_frontdoor_profile.main.id
  supported_protocols           = ["Http","Https"]
  patterns_to_match             = ["/*"]
  forwarding_protocol           = "HttpOnly"
  https_redirect_enabled        = true
  enabled                       = true
}
