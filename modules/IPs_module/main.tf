resource "azurerm_public_ip" "k8" {
  count               = 2
  name                = "static-ip-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"

}

