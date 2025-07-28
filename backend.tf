terraform {
  backend "azurerm" {
    resource_group_name  = "dge-rg2"
    storage_account_name = "dgestoragenbs"
    container_name       = "dge-container"
    key                  = "aks-dge.tfstate"
  }
}