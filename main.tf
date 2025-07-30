resource "azurerm_public_ip" "nat_ip" {
  name                = "${var.name}-nat-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat" {
  name                = "${var.name}-nat"
  location            = var.location
  resource_group_name = var.resource_group
  sku_name            = "Standard"

  public_ip_ids = [azurerm_public_ip.nat_ip.id]
}