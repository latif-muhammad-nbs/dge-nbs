# variables.tf (Root Level)

variable "resource_group_name" {
  description = "Name of the Azure Resource Group."
  type        = string
  default     = "dge-rg"
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



variable "common_tags" {
  description = "A map of tags to apply to all resources where applicable."
  type        = map(string)
  default = {
    Environment = "Development"
    Project     = "aks-dge"
    Owner       = "DevOps"
  }
}

variable "kubernetes_version" {
  description = "Supported Kubernetes version for AKS cluster."
  type        = string
  default     = "1.30.0" 
}
variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster."
  type        = string
  default     = "dgeaks" 
}