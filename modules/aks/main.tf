resource "azurerm_kubernetes_cluster" "main" {
  name                = var.kubernetes_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = var.dns_prefix
  tags                = var.tags

  default_node_pool {
    name       = "default"
    vm_size    = var.agent_vm_size
    node_count = 1
    vnet_subnet_id = var.vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico" 
    load_balancer_sku  = "standard"
  }




}