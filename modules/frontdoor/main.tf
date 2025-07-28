resource "azurerm_frontdoor" "main" {
  name                = var.frontdoor_name
  resource_group_name = var.resource_group_name

  frontend_endpoint {
    name      = "${var.frontdoor_name}-fe"
    host_name = "${var.frontdoor_name}.azurefd.net"
  }

  backend_pool_load_balancing {
    name = "${var.frontdoor_name}-lb"
  }

  backend_pool_health_probe {
    name                = "${var.frontdoor_name}-hp"
    protocol            = "Https"
    path                = "/"
    interval_in_seconds = 30
  }

  backend_pool {
    name                = "${var.frontdoor_name}-bp"
    load_balancing_name = "${var.frontdoor_name}-lb"
    health_probe_name   = "${var.frontdoor_name}-hp"
    backend {
      host_header = "${var.frontdoor_name}.azurefd.net"
      address     = var.origin_ip
      http_port   = 80
      https_port  = 443
    }
  }

  routing_rule {
    name               = "${var.frontdoor_name}-rr"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["${var.frontdoor_name}-fe"]

    forwarding_configuration {
      backend_pool_name    = "${var.frontdoor_name}-bp"
      forwarding_protocol  = "MatchRequest"
    }
  }
}

# resource "azurerm_web_application_firewall_policy" "main" {
#   name                = var.waf_policy_name
#   resource_group_name = var.resource_group_name
#   location              = var.location

#   custom_rules {
#     name      = "BlockSQLInjection"
#     priority  = 1
#     rule_type = "MatchRule"

#     match_conditions {
#       match_variable = "RequestUri"
#       operator        = "Contains"
#       value           = "union select"
#     }

#     action = "Block"
#   }

#   managed_rules {
#     type = "DefaultRuleSet"
#     version = "1.0"
#   }
# }