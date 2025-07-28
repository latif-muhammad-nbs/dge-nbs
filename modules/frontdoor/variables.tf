# modules/frontdoor/variables.tf

variable "resource_group_name" {
  description = "Name of the Azure Resource Group."
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
}

variable "frontdoor_name" {
  description = "Name of the Azure Front Door instance."
  type        = string
}

# variable "domain_name" {
#   description = "Your custom domain name for Azure Front Door."
#   type        = string
# }

variable "origin_ip" {
  description = "The public IP address of the origin server (e.g., Grafana Load Balancer)."
  type        = string
}

# Optional: Variables for WAF policy, custom HTTPS, etc.
/*
variable "waf_policy_mode" {
  description = "Mode for the Web Application Firewall policy (Prevention or Detection)."
  type        = string
  default     = "Prevention"
  validation {
    condition     = contains(["Prevention", "Detection"], var.waf_policy_mode)
    error_message = "waf_policy_mode must be 'Prevention' or 'Detection'."
  }
}
*/