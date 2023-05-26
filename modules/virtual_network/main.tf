resource "azurerm_virtual_network" "aks" {
  name                = var.name
  address_space       = var.address_space
  location            = var.resource_group_region
  resource_group_name = var.resource_group_name
}
