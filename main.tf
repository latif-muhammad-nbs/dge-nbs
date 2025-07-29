# Configure the AzureRM Provider
provider "azurerm" {
  features {}
}

# Aliased Kubernetes Provider (for AKS)
provider "kubernetes" {
  alias                  = "aks"
  host                   = module.aks.kube_config.host
  client_certificate     = base64decode(module.aks.kube_config.client_certificate)
  client_key             = base64decode(module.aks.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config.cluster_ca_certificate)
}

# Aliased Helm Provider (for AKS)
provider "helm" {
  alias = "aks"
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
  tags   = var.tags
}

# Module: Network
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_name           = "aks-vnet"
  address_space       = ["10.99.0.0/16"]
  subnet_prefixes     = ["10.99.0.0/24","10.99.20.0/22"]
  subnet_names        = ["aks-subnet","app-subnet"]
  tags               = var.tags

}

# Module: AKS
module "aks" {
  source                  = "./modules/aks"
  resource_group_name     = azurerm_resource_group.main.name
  location                = azurerm_resource_group.main.location
  kubernetes_cluster_name = var.kubernetes_cluster_name
  kubernetes_version      = var.kubernetes_version
  dns_prefix              = var.dns_prefix
  vnet_subnet_id          = module.network.subnet_ids["aks-subnet"]
  agent_vm_size           = "Standard_D2s_v3"
  tags                    = var.tags

}

output "kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}

# Module: Grafana (uses Kubernetes and Helm)
module "grafana" {
  source               = "./modules/grafana"
  kubernetes_namespace = "monitoring"
  tags                  = var.tags
  providers = {
    kubernetes = kubernetes.aks
    helm       = helm.aks
  }
  
}

# Module: Front Door (does not use Kubernetes/Helm)
module "frontdoor" {
  source              = "./modules/frontdoor"
  resource_group_name = azurerm_resource_group.main.name
  frontdoor_name      = "grafana-frontdoor"
  origin_host_name    = module.grafana.grafana_public_ip
  origin_path         = "/"
  origin_ip           = module.grafana.grafana_public_ip
  location            = azurerm_resource_group.main.location
  tags                = var.tags
   
}

