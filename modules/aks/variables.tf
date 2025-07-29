# modules/aks/variables.tf

variable "resource_group_name" {
  description = "Name of the Azure Resource Group."
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
}

variable "kubernetes_cluster_name" {
  description = "Name of the Azure Kubernetes Service cluster."
  type        = string
}

variable "vnet_subnet_id" {
  description = "The ID of the subnet where AKS will be deployed (e.g., for node pools)."
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "The size of the Virtual Machine for AKS nodes (e.g., Standard_DS2_v2)."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "kubernetes_version" {
  description = "The Kubernetes version to use for the AKS cluster (e.g., '1.28.3')."
  type        = string
  default     = "1.28.3" 
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster."
  type        = string
}

variable "agent_vm_size" {
  description = "The size of the Virtual Machine for the AKS node pool."
  type        = string
  default     = "Standard_D2s_v3" 
}

variable "tags" {
  description = "Tags to be applied to resources in this module"
  type        = map(string)
}

