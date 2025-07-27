#!/bin/bash

# Define your tag
TAG_NAME="environment"
TAG_VALUE="dev"

# Get all resources with that tag
az resource list --tag "$TAG_NAME=$TAG_VALUE" --query "[].{id:id,type:type}" -o tsv |
while read -r RESOURCE_ID RESOURCE_TYPE; do
    case $RESOURCE_TYPE in
        "Microsoft.Sql/servers")
            echo "terraform import azurerm_mssql_server.sql_import $RESOURCE_ID"
            ;;
        "Microsoft.Sql/servers/elasticPools")
            echo "terraform import azurerm_mssql_elasticpool.sql_ep $RESOURCE_ID"
            ;;
        "Microsoft.ContainerRegistry/registries")
            echo "terraform import azurerm_container_registry.kritagyacontainer $RESOURCE_ID"
            ;;
        "Microsoft.ContainerService/managedClusters")
            echo "terraform import azurerm_kubernetes_cluster.aks_import $RESOURCE_ID"
            ;;
        *)
            echo "# Unknown resource type: $RESOURCE_TYPE"
            ;;
    esac
done
