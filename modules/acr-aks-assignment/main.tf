resource "azurerm_role_assignment" "acr_to_aks" {
  scope                            = var.acr_id
  role_definition_name             = "AcrPull"
  principal_id                     = var.aks_principal_id
  skip_service_principal_aad_check = true
}