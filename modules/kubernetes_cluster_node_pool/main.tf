
resource "azurerm_kubernetes_cluster_node_pool" "aks" {
  name                  = var.name
  kubernetes_cluster_id = var.kubernetes_cluster_id
  vm_size               = "Standard_DS2_v2"
  enable_auto_scaling   = true
  enable_node_public_ip = true
  node_count            = 1
  min_count             = 1
  max_count             = 2
  mode                  = "System"

  node_labels = {
    name = "APP"
    age  = "Blue"
  }

  os_sku           = "Ubuntu"
  os_type          = "Linux"
  scale_down_mode  = "Delete"
  workload_runtime = "OCIContainer"
}
