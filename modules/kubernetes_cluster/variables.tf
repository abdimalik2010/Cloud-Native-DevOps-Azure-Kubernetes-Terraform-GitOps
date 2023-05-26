variable "name" {
  description = "The name of the Kubernetes cluster."
}

variable "location" {
  description = "The location of the Kubernetes cluster."
}

variable "resource_group_name" {
  description = "The name of the resource group where the Kubernetes cluster will be created."
}

variable "dns_prefix" {
  description = "The DNS prefix of the Kubernetes cluster."
}

variable "vnet_subnet_id" {
  description = "The ID of the subnet where the Kubernetes cluster will be deployed."

}

variable "AZURE_CLIENT_ID" {
  type = string
  sensitive = true
}
variable "AZURE_CLIENT_SECRET" {
  type = string
  sensitive = true


}