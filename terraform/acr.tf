resource "azurerm_container_registry" "acr" {
  name                = "andreikubetestassignmentacr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "East US"
  sku                  = "Basic"

  admin_enabled        = true
}

resource "azurerm_role_assignment" "aks_to_acr" {
  principal_id   = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope           = azurerm_container_registry.acr.id
}