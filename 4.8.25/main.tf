module "nat_gateway" {
  source         = "../modules/nat_gateway"
  name           = "my-nat"
  location       = var.location
  resource_group = var.resource_group
}

module "nat_gateway_association" {
  source             = "../modules/nat_gateway_association"
  nat_gateway_id     = module.nat_gateway.nat_gateway_id

  subnets_to_associate = [
    {
      name                 = "build-agents"
      virtual_network_name = "ue2-mgt-dev-core-build-agents"
      resource_group_name  = "ue2-mgt-dev-core-build-agents"
    },
    {
      name                 = "mdp-poc"
      virtual_network_name = "ue2-mgt-dev-core-build-agents"
      resource_group_name  = "ue2-mgt-dev-core-build-agents"
    },
    {
      name                 = "impg-pe-sn"
      virtual_network_name = "ue2-mgt-dev-psig-ml-vnet"
      resource_group_name  = "ue2-mgt-dev-psig-ml"
    },
    {
      name                 = "impg-aml-sn"
      virtual_network_name = "ue2-mgt-dev-psig-ml-vnet"
      resource_group_name  = "ue2-mgt-dev-psig-ml"
    },
    {
      name                 = "AzureFirewallSubnet"
      virtual_network_name = "ue2-mgt-dev-psig-ml-vnet"
      resource_group_name  = "ue2-mgt-dev-psig-ml"
    }
  ]
}
