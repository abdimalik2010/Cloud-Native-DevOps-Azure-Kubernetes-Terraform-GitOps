
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  network_profile {
    network_plugin = "kubenet"
    service_cidr   = "10.0.0.0/16"
    dns_service_ip = "10.0.0.10"
    pod_cidr       = "10.244.0.0/16"
    network_policy = "calico"
  }

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

 service_principal {
    client_id     = var.ARM_CLIENT_ID
    client_secret = var.ARM_CLIENT_SECRET
  }
}
