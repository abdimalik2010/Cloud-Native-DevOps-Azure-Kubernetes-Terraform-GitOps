variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the Azure Container Registry"
  type        = string
}

variable "sku" {
  description = "Pricing tier for the Azure Container Registry"
  type        = string
}

variable "admin_enabled" {
  description = "Enable admin user for the Azure Container Registry"
  type        = bool
}
