resource "azurerm_subnet_nat_gateway_association" "assoc" {
  for_each = {
    for s in var.subnet_ids :
    "${s.key}" => {
      subnet_id      = s.value
      nat_gateway_id = var.nat_gateway_id
    }
  }

  subnet_id      = each.value.subnet_id
  nat_gateway_id = each.value.nat_gateway_id
}
