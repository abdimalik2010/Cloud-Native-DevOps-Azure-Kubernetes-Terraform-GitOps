variable "name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the virtual machine"
  type        = string
}

variable "size" {
  description = "The size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "The admin username of the virtual machine"
  type        = string
}

variable "network_interface_ids" {
  description = "The network interface IDs associated with the virtual machine"
  type        = list(string)
}

variable "custom_data" {
  description = "The custom data for cloud-init"
  type        = string
}


variable "public_key" {

  type = string
}