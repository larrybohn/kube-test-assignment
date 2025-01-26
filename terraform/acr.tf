resource "azurerm_container_registry" "example" {
  name                = "andreikubetestassignmentacr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "East US"
  sku                  = "Basic"

  admin_enabled        = true
}