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
      name                       = "kubelet-api"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "10250"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "nodeport-service"
      description                = "allow-http"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "30000-32767"
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
    }
  ]
}