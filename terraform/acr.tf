resource "azurerm_container_registry" "acr" {
  name                = "andreikubetestassignmentacr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                  = "Basic"

  admin_enabled        = true
}

resource "azurerm_role_assignment" "aks_to_acr" {
  principal_id   = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope           = azurerm_container_registry.acr.id
}