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

variable "origin_host_name" {
  description = "The host header sent to the backend (e.g., same as origin_ip or a custom domain)."
  type        = string
}

variable "origin_path" {
  description = "The path to use for health probes or origin route path."
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tags to be applied to resources in this module"
  type        = map(string)
}


