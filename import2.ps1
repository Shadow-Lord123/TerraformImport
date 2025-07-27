# import2.ps1

$TagName = "environment"
$TagValue = "dev"

# Get resources with the tag
$resources = az resource list --tag "$TagName=$TagValue" | ConvertFrom-Json

foreach ($resource in $resources) {
    $id = $resource.id
    $type = $resource.type

    switch ($type) {
        "Microsoft.Sql/servers" {
            Write-Output "terraform import azurerm_mssql_server.sql_import $id"
        }
        "Microsoft.Sql/servers/elasticPools" {
            Write-Output "terraform import azurerm_mssql_elasticpool.sql_ep $id"
        }
        "Microsoft.ContainerRegistry/registries" {
            Write-Output "terraform import azurerm_container_registry.kritagyacontainer $id"
        }
        "Microsoft.ContainerService/managedClusters" {
            Write-Output "terraform import azurerm_kubernetes_cluster.aks_import $id"
        }
        default {
            Write-Output "# Unknown resource type: $type"
        }
    }
}

