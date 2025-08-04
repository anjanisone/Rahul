
variable "location" {
  type    = string
  default = "eastus2"
}

variable "resource_group_1" {
  type    = string
  default = "ue2-mgt-dev-psig-ml"
}

variable "resource_group_2" {
  type    = string
  default = "ue2-mgt-dev-core-build-agents"
}

resource "azurerm_network_security_group" "restrict_outbound_nsg" {
  name                = "nsg-restrict-outbound"
  location            = var.location
  resource_group_name = var.resource_group_1

  security_rule {
    name                       = "Deny-All-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Subnets from VNet: ue2-mgt-dev-psig-ml-vnet
data "azurerm_subnet" "subnet_azurefw" {
  name                 = "AzureFirewallSubnet"
  virtual_network_name = "ue2-mgt-dev-psig-ml-vnet"
  resource_group_name  = var.resource_group_1
}

data "azurerm_subnet" "subnet_pe" {
  name                 = "impg-pe-sn"
  virtual_network_name = "ue2-mgt-dev-psig-ml-vnet"
  resource_group_name  = var.resource_group_1
}

data "azurerm_subnet" "subnet_aml" {
  name                 = "impg-aml-sn"
  virtual_network_name = "ue2-mgt-dev-psig-ml-vnet"
  resource_group_name  = var.resource_group_1
}

# Subnets from VNet: ue2-mgt-dev-core-build-agents
data "azurerm_subnet" "subnet_build_agents" {
  name                 = "build-agents"
  virtual_network_name = "ue2-mgt-dev-core-build-agents"
  resource_group_name  = var.resource_group_2
}

data "azurerm_subnet" "subnet_mdp_poc" {
  name                 = "mdp-poc"
  virtual_network_name = "ue2-mgt-dev-core-build-agents"
  resource_group_name  = var.resource_group_2
}

resource "azurerm_subnet_network_security_group_association" "assoc_fw" {
  subnet_id                 = data.azurerm_subnet.subnet_azurefw.id
  network_security_group_id = azurerm_network_security_group.restrict_outbound_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "assoc_pe" {
  subnet_id                 = data.azurerm_subnet.subnet_pe.id
  network_security_group_id = azurerm_network_security_group.restrict_outbound_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "assoc_aml" {
  subnet_id                 = data.azurerm_subnet.subnet_aml.id
  network_security_group_id = azurerm_network_security_group.restrict_outbound_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "assoc_build_agents" {
  subnet_id                 = data.azurerm_subnet.subnet_build_agents.id
  network_security_group_id = azurerm_network_security_group.restrict_outbound_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "assoc_mdp_poc" {
  subnet_id                 = data.azurerm_subnet.subnet_mdp_poc.id
  network_security_group_id = azurerm_network_security_group.restrict_outbound_nsg.id
}
