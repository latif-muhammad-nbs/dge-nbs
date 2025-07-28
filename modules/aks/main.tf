resource "azurerm_kubernetes_cluster" "main" {
  name                = var.kubernetes_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.kubernetes_cluster_name}-dns"
  kubernetes_version  = "1.28.3" # Specify a version

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico" # or "azure"
    load_balancer_sku  = "standard"
  }

  // Add AAD integration if needed
  // azure_active_directory_role_based_access_control {
  //   managed                = true
  //   azure_rbac_enabled     = true
  //   # ...
  // }

  tags = {
    Environment = "Dev"
  }
}