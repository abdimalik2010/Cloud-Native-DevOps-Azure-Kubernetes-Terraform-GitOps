output "cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}
#output "cluster_kubelet_identity" {
# value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
#}
