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
  default     = "1.28.3" # Check available versions in your region
}

# Optional: Add variables for AAD integration, networking policies, etc.
/*
variable "enable_aad_integration" {
  description = "Whether to enable Azure AD integration for AKS."
  type        = bool
  default     = true
}

variable "aad_admin_group_object_id" {
  description = "Object ID of the Azure AD group that will have admin access to the cluster."
  type        = string
  # sensitive   = true # Mark as sensitive if it's an actual secret
  # validation {
  #   condition     = var.enable_aad_integration == false || (var.enable_aad_integration && var.aad_admin_group_object_id != "")
  #   error_message = "aad_admin_group_object_id must be set if enable_aad_integration is true."
  # }
}
*/