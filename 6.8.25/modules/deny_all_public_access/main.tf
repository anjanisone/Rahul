resource "azurerm_route_table" "deny_all" {
  name                = var.route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name                   = "deny-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "None"
  }

  disable_bgp_route_propagation = false
}

resource "azurerm_subnet_route_table_association" "associate" {
  for_each        = toset(var.subnet_ids)
  subnet_id       = each.value
  route_table_id  = azurerm_route_table.deny_all.id
}
