output "masternode-ip" {
  value = azurerm_public_ip.k8[0].id

}
output "workernode-ip" {
  value = azurerm_public_ip.k8[1].id

}
