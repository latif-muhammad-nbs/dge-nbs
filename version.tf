terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Use an appropriate version
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0" # Use an appropriate version
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0" # Use an appropriate version
    }
  }
}