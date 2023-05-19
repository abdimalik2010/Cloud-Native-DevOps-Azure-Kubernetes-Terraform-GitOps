variable "name" {
  description = "The name of the network security group."
  type        = string
}

variable "location" {
  description = "The location/region where the network security group will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the network security group will be created."
  type        = string
}

variable "security_rules" {
  description = "List of security rules for the network security group."
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "kubernetes-api-server"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "6443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "etcd-server-client-API"
      description                = "allow-http"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "2379-2380"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "Kubelet-api"
      description                = "allow-http"
      priority                   = 140
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "10250"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "kube-scheduler"
      description                = "allow-http"
      priority                   = 150
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "10259"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "kube-controller-manager"
      description                = "allow-http"
      priority                   = 160
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "10257"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "ssh"
      priority                   = 170
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "htp"
      priority                   = 180
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "https"
      priority                   = 190
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}
