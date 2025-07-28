# modules/network/variables.tf

variable "resource_group_name" {
  description = "Name of the Azure Resource Group."
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network."
  type        = string
}

variable "address_space" {
  description = "The address space for the Virtual Network (e.g., [\"10.0.0.0/16\"])."
  type        = list(string)
}

variable "subnet_prefixes" {
  description = "A list of CIDR prefixes for the subnets within the VNet."
  type        = list(string)
}

variable "subnet_names" {
  description = "A list of names for the subnets, corresponding to subnet_prefixes."
  type        = list(string)
}