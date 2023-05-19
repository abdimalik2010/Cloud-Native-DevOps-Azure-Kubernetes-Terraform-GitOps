variable "name" {
  description = "The name of the network interface."
  type        = string
}

variable "location" {
  description = "The location of the network interface."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to associate with the network interface."
  type        = string
}

variable "ip_configuration" {
  description = "The IP configuration of the network interface."
  type = object({
    name                          = string
    private_ip_address_allocation = string
    public_ip_address_id          = string
  })
}
