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



variable "tags" {
  type        = map(string)
  default = {
    Environment = "Dev"
    Project     = "DGE-NBS"
    Owner       = "latif"
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