variable "nat_gateway_id" {
  description = "ID of the NAT Gateway to associate"
  type        = string
}

variable "subnets_to_associate" {
  description = "List of existing subnets to associate with NAT Gateway"
  type = list(object({
    name                 = string
    virtual_network_name = string
    resource_group_name  = string
  }))
}

data "azurerm_subnet" "existing_subnets" {
  for_each = {
    for subnet in var.subnets_to_associate : "${subnet.resource_group_name}-${subnet.virtual_network_name}-${subnet.name}" => subnet
  }

  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_subnet_nat_gateway_association" "associate_subnets" {
  for_each = data.azurerm_subnet.existing_subnets

  subnet_id      = each.value.id
  nat_gateway_id = var.nat_gateway_id
}
