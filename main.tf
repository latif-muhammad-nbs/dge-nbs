# Configure the AzureRM Provider
provider "azurerm" {
  features {}
}

# Configure the Kubernetes Provider (will depend on AKS output)
provider "kubernetes" {
  host                   = module.aks.kube_config.host
  client_certificate     = base64decode(module.aks.kube_config.client_certificate)
  client_key             = base64decode(module.aks.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config.cluster_ca_certificate)
}

# Configure the Helm Provider (will depend on AKS output)
provider "helm" {
  kubernetes {
    host                   = module.aks.kube_config.host
    client_certificate     = base64decode(module.aks.kube_config.client_certificate)
    client_key             = base64decode(module.aks.kube_config.client_key)
    cluster_ca_certificate = base64decode(module.aks.kube_config.cluster_ca_certificate)
  }
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Module: Network
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_name           = "aks-vnet"
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.0.0/24", "10.0.1.0/24"] # Example for AKS and other workloads
  subnet_names        = ["aks-subnet", "app-subnet"]
}

# Module: AKS
module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  kubernetes_cluster_name = var.kubernetes_cluster_name
  vnet_subnet_id      = module.network.subnet_ids["aks-subnet"]
  // ... other AKS specific variables (node pools, AAD integration, etc.)
}

output "kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}

# Module: Grafana
module "grafana" {
  source              = "./modules/grafana"
  kubernetes_namespace = "monitoring"
  # You might need to pass the KubeConfig from the AKS module if not using the default provider setup
}


# Module: Front Door
module "frontdoor" {
  source              = "./modules/frontdoor"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  frontdoor_name      = var.frontdoor_name
  origin_ip           = module.grafana.grafana_public_ip
}

