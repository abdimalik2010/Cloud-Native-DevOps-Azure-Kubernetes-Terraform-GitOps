
output "vnet" {
  value = azurerm_virtual_network.k8

}
output "primary_subnet" {
  value = azurerm_subnet.primary_subnet

}
output "secondary_subnet" {
  value = azurerm_subnet.secondary_subnet

}