
resource "azurerm_resource_group" "aks" {
  name     = var.name
  location = var.location
}

