variable "name" {
  description = "The name of the virtual network."
}

variable "address_space" {
  description = "The address space of the virtual network."
  type        = list(string)
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be created."
}

variable "resource_group_region" {
  description = "The region of the resource group where the virtual network will be created."
}
