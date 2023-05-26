terraform {
  backend "azurerm" {
    #resource_group_name  = "StorageAccount-ResourceGroup"
    storage_account_name = "hasstorage123"
    container_name       = "tfterraform"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.56.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = "aks-resources"
  location = "West Europe"
}

module "virtual_network" {
  source                = "./modules/virtual_network"
  name                  = "aks-vnet"
  address_space         = ["192.168.0.0/16"]
  resource_group_name   = module.resource_group.name
  resource_group_region = module.resource_group.location
}

module "subnet" {
  source               = "./modules/subnet"
  address_prefixes     = ["192.168.1.0/24"]
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.virtual_network.name
}

module "kubernetes_cluster" {
  source              = "./modules/kubernetes_cluster"
  name                = "aks-aks1"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  dns_prefix          = "aksaks1"
  vnet_subnet_id      = module.subnet.subnet
  client_id     = var.ARM_CLIENT_ID
  client_secret = var.ARM_CLIENT_SECRET
  

}

module "kubernetes_cluster_node_pool" {
  source                = "./modules/kubernetes_cluster_node_pool"
  name                  = "internal"
  kubernetes_cluster_id = module.kubernetes_cluster.cluster_id
}

module "acr" {
  source              = "./modules/acr"
  acr_name            = "krooazurecontainerregistry"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku                 = "Standard"
  admin_enabled       = false
}
module "acr_aks_assignment" {
  source                           = "./modules/acr-aks-assignment"
  acr_id                           = module.acr.acr_id
  aks_principal_id                     = module.kubernetes_cluster.cluster_kubelet_identity
}



