#!/bin/bash

# Usage: ./make_subnets_private.sh <subscription_id> <resource_group_name>

subscription_id=$1
resource_group_name=$2
location="eastus"  # Update this as needed
route_table_name="deny-all-rt"
route_name="deny-internet"

if [ -z "$subscription_id" ] || [ -z "$resource_group_name" ]; then
  echo "Usage: $0 <subscription_id> <resource_group_name>"
  exit 1
fi

echo "Setting subscription to $subscription_id"
az account set --subscription "$subscription_id"

echo "Creating route table: $route_table_name in resource group: $resource_group_name"
az network route-table create \
  --name "$route_table_name" \
  --resource-group "$resource_group_name" \
  --location "$location" \
  --only-show-errors

echo "Creating deny-all route: $route_name"
az network route-table route create \
  --resource-group "$resource_group_name" \
  --route-table-name "$route_table_name" \
  --name "$route_name" \
  --address-prefix "0.0.0.0/0" \
  --next-hop-type "None" \
  --only-show-errors

echo "Fetching all subnets in resource group: $resource_group_name"
subnets=$(az network vnet subnet list --resource-group "$resource_group_name" --query "[].{name:name, vnet:virtualNetworkName}" -o tsv)

while read -r subnet_name vnet_name; do
  echo "Associating route table with subnet: $subnet_name in VNet: $vnet_name"
  az network vnet subnet update \
    --resource-group "$resource_group_name" \
    --vnet-name "$vnet_name" \
    --name "$subnet_name" \
    --route-table "$route_table_name" \
    --only-show-errors
done <<< "$subnets"

echo "All subnets in $resource_group_name are now private (no outbound internet access)."
