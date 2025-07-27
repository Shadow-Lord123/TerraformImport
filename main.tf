# Get reference to existing resource group
data "azurerm_resource_group" "storage_rg" {
  name = "StorageRG"
}

# Create a new resource group
resource "azurerm_resource_group" "aks_rg" {
  name     = "FL_StorageRG"
  location = "UK South"
}

# AKS cluster in new resource group
resource "azurerm_kubernetes_cluster" "aks_import" {
  name                = "aks-import-dns-e9kz5vj1" 
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  default_node_pool {
    name       = "nodepool1"
    vm_size    = "Standard_D4s_v4"
    node_count = 1
  }

  identity {
    type = "SystemAssigned"
  }

  dns_prefix = "aks-import-dns"
}

# Container Registry in existing resource group
resource "azurerm_container_registry" "kritagyacontainer" {
  name                = "kritagyacontainer"
  resource_group_name = data.azurerm_resource_group.storage_rg.name
  location            = data.azurerm_resource_group.storage_rg.location
  sku                 = "Standard"
}

# SQL Server in existing resource group
resource "azurerm_mssql_server" "sql_import" {
  name                         = "sql-import"
  resource_group_name          = data.azurerm_resource_group.storage_rg.name
  location                     = data.azurerm_resource_group.storage_rg.location
  version                      = "12.0"
  administrator_login          = "azureuser"
  administrator_login_password = "MahaPitaji82"  # Consider making this a sensitive variable!
}

# Elastic Pool in existing resource group
resource "azurerm_mssql_elasticpool" "sql_ep" {
  name                = "sql-ep"
  location            = data.azurerm_resource_group.storage_rg.location
  resource_group_name = data.azurerm_resource_group.storage_rg.name
  server_name         = azurerm_mssql_server.sql_import.name

  sku {
    name     = "GP_Gen5"
    tier     = "GeneralPurpose"
    family   = "Gen5"
    capacity = 2
  }

  max_size_gb = 32

  per_database_settings {
    min_capacity = 0
    max_capacity = 2
  }
}


