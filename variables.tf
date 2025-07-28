# variables.tf (Root Level)

variable "resource_group_name" {
  description = "Name of the Azure Resource Group."
  type        = string
  default     = "dge-rg2"
}

variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
  default     = "East US"
}

variable "kubernetes_cluster_name" {
  description = "Name of the Azure Kubernetes Service cluster."
  type        = string
  default     = "dge-aks-cluster2"
}

variable "frontdoor_name" {
  description = "Name of the Azure Front Door instance."
  type        = string
  default     = "dge-aks"
}

# variable "domain_name" {
#   description = "Your custom domain name for Azure Front Door (e.g., 'yourcompany.com')."
#   type        = string
#   # IMPORTANT: Replace with your actual domain or remove if not using custom domain initially
#   # You will need to configure CNAME record for this domain to your Front Door's default hostname.
#   default     = "yourcustomdomain.com"
# }

variable "common_tags" {
  description = "A map of tags to apply to all resources where applicable."
  type        = map(string)
  default = {
    Environment = "Development"
    Project     = "aks-dge"
    Owner       = "DevOps"
  }
}