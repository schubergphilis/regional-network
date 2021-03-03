locals {
  availability_zones                = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  region                            = "eu-west-1"
  flow_log_retention_period_in_days = 1
  global_dhcp_options = { # this can be null as long as there are no vpc specific overrides of dhcp options
  domain_name          = ""
  domain_name_servers  = ["AmazonProvidedDNS"]
  ntp_servers          = []
  netbios_name_servers = []
  netbios_node_type    = 2
  tags                 = {}
  }
  vpcs = [
    {
      name                = "development",
      environment         = "development",
      availability_zones  = local.availability_zones,
      cidr_block          = "10.16.0.0/17",
      public_subnet_bits  = 20,
      private_subnet_bits = 20,
      peer_with_all       = false,
      mesh                = false,
      tags                = {},
      dhcp_options        = local.global_dhcp_options

    },
    {
      name                = "test",
      environment         = "test",
      availability_zones  = local.availability_zones,
      cidr_block          = "10.16.128.0/17",
      public_subnet_bits  = 20,
      private_subnet_bits = 20,
      peer_with_all       = false,
      mesh                = false,
      tags                = {},
      dhcp_options        = local.global_dhcp_options
    },
    {
      name                = "acceptance",
      environment         = "acceptance",
      availability_zones  = local.availability_zones,
      cidr_block          = "10.17.0.0/17",
      public_subnet_bits  = 20,
      private_subnet_bits = 20,
      peer_with_all       = false,
      mesh                = false,
      tags                = {},
      dhcp_options        = local.global_dhcp_options
    },
    {
      name                = "production",
      environment         = "production",
      availability_zones  = local.availability_zones,
      cidr_block          = "10.17.128.0/17",
      public_subnet_bits  = 20,
      private_subnet_bits = 20,
      peer_with_all       = false,
      mesh                = false,
      tags                = {},
      dhcp_options        = local.global_dhcp_options

    },
    {
      name                = "services",
      environment         = "services",
      availability_zones  = local.availability_zones,
      cidr_block          = "10.18.0.0/17",
      public_subnet_bits  = 20,
      private_subnet_bits = 20,
      peer_with_all       = true,
      mesh                = false,
      tags                = {},
      dhcp_options        = local.global_dhcp_options
    },
    {
      name                = "development-mesh",
      environment         = "development",
      availability_zones  = local.availability_zones,
      cidr_block          = "10.18.128.0/17",
      public_subnet_bits  = 20,
      private_subnet_bits = 20,
      peer_with_all       = false,
      mesh                = true,
      tags                = {},
      dhcp_options        = local.global_dhcp_options
    },
    {
      name                = "test-mesh",
      environment         = "test",
      availability_zones  = local.availability_zones,
      cidr_block          = "10.19.0.0/17",
      public_subnet_bits  = 20,
      private_subnet_bits = 20,
      peer_with_all       = false,
      mesh                = true,
      tags                = {},
      dhcp_options        = local.global_dhcp_options
    },
    {
      name                = "acceptance-mesh",
      environment         = "acceptance",
      availability_zones  = local.availability_zones,
      cidr_block          = "10.19.128.0/17",
      public_subnet_bits  = 20,
      private_subnet_bits = 20,
      peer_with_all       = false,
      mesh                = true,
      tags                = {},
      dhcp_options        = local.global_dhcp_options
    },
    {
      name                = "production-mesh",
      environment         = "production",
      availability_zones  = local.availability_zones,
      cidr_block          = "10.20.0.0/17",
      public_subnet_bits  = 20,
      private_subnet_bits = 20,
      peer_with_all       = false,
      mesh                = true,
      tags                = {},
      dhcp_options        = local.global_dhcp_options
    }
  ]
}
