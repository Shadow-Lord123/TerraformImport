
terraform init

terraform state rm azurerm_resource_group.storage_rg
terraform state rm azurerm_mssql_server.sql_import
terraform state rm azurerm_mssql_elasticpool.sql_ep

#terraform import azurerm_resource_group.storage_rg /subscriptions/2981bf38-3a73-4a81-8373-416f0d45f251/resourceGroups/StorageRG
#terraform import azurerm_mssql_server.sql_import /subscriptions/2981bf38-3a73-4a81-8373-416f0d45f251/resourceGroups/StorageRG/providers/Microsoft.Sql/servers/sql-import
#terraform import azurerm_mssql_elasticpool.sql_ep /subscriptions/2981bf38-3a73-4a81-8373-416f0d45f251/resourceGroups/StorageRG/providers/Microsoft.Sql/servers/sql-import/elasticPools/sql-ep

# Remove and import Container Registry from 'DevRG'
terraform state rm azurerm_container_registry.kritagyacontainer
#terraform import azurerm_container_registry.kritagyacontainer "/subscriptions/2981bf38-3a73-4a81-8373-416f0d45f251/resourceGroups/DevRG/providers/Microsoft.ContainerRegistry/registries/kritagyacontainer"

# Remove and import AKS Cluster from 'FL_StorageRG'
terraform state rm azurerm_kubernetes_cluster.myakscluster
#terraform import azurerm_kubernetes_cluster.aks_import "/subscriptions/2981bf38-3a73-4a81-8373-416f0d45f251/resourceGroups/FL_StorageRG/providers/Microsoft.ContainerService/managedClusters/aks-import-dns-e9kz5vj1"
