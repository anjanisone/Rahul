module "nat_gateway_association_core" {
  source          = "../modules/nat_gateway_association"
  nat_gateway_id  = module.UE2-mgt-dev-nat-gw-core-build-agents.nat_gateway_id
  subnet_ids      = {
    build_agents = "/subscriptions/xxxx/resourceGroups/UE2-mgt-dev-core-build-agents/providers/Microsoft.Network/virtualNetworks/ue2-mgt-dev-core-build-agents/subnets/build-agents"
    mdp_poc      = "/subscriptions/xxxx/resourceGroups/UE2-mgt-dev-core-build-agents/providers/Microsoft.Network/virtualNetworks/ue2-mgt-dev-core-build-agents/subnets/mdp-poc"
  }
}

module "nat_gateway_association_psig" {
  source          = "../modules/nat_gateway_association"
  nat_gateway_id  = module.UE2-mgt-dev-nat-gw-psig-ml.nat_gateway_id
  subnet_ids      = {
    impg_pe_sn          = "/subscriptions/xxxx/resourceGroups/UE2-mgt-dev-psig-ml/providers/Microsoft.Network/virtualNetworks/ue2-mgt-dev-psig-ml/subnets/impg-pe-sn"
    impg_aml_sn         = "/subscriptions/xxxx/resourceGroups/UE2-mgt-dev-psig-ml/providers/Microsoft.Network/virtualNetworks/ue2-mgt-dev-psig-ml/subnets/impg-aml-sn"
    AzureFirewallSubnet = "/subscriptions/xxxx/resourceGroups/UE2-mgt-dev-psig-ml/providers/Microsoft.Network/virtualNetworks/ue2-mgt-dev-psig-ml/subnets/AzureFirewallSubnet"
  }
}
