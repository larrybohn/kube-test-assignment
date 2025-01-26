resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-nginx"
  
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B1s"
  }
  
  identity {
    type = "SystemAssigned"
  }
}
