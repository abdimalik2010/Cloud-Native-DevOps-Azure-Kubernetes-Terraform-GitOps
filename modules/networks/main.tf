resource "azurerm_virtual_network" "k8" {
  name                = "k8-network"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "primary_subnet" {
  name                 = "primary_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.k8.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "secondary_subnet" {
  name                 = "secondary_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.k8.name
  address_prefixes     = ["10.0.2.0/24"]
}
