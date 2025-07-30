output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "public_subnet_ids" {
  value = azurerm_subnet.public[*].id
}

output "private_subnet_ids" {
  value = azurerm_subnet.private[*].id
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.nat.id
}