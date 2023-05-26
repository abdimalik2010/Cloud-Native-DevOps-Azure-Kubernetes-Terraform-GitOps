variable "name" {
  default     = "aks-subnet"
  description = "The name of the subnet."
}

variable "address_prefixes" {
  description = "The address prefixes of the subnet."
  type        = list(string)
}

variable "resource_group_name" {
  description = "The name of the resource group where the subnet will be created."
}

variable "virtual_network_name" {
  description = "The name of the virtual network where the subnet will be created."
}