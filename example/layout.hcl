locals {
  availability_zones                = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  region                            = "eu-west-1"
  flow_log_retention_period_in_days = 1
  global_dhcp_options               = {
    # this can be null as long as there are no vpc specific overrides of dhcp options
    domain_name          = ""
    domain_name_servers  = ["AmazonProvidedDNS"]
    ntp_servers          = []
    netbios_name_servers = []
    netbios_node_type    = 2
    tags                 = {}
  }
  vpcs                              = [
    {
      name                            = "development",
      environment                     = "development",
      availability_zones              = local.availability_zones,
      cidr_block                      = "10.16.0.0/17",
      dhcp_options                    = local.global_dhcp_options,
      ebs_interface_endpoints         = true,
      ec2_interface_endpoints         = true,
      ec2messages_interface_endpoints = true,
      mesh                            = false,
      mgn_interface_endpoints         = true,
      public_subnet_bits              = 20,
      private_subnet_bits             = 20,
      private_subnet_tags             = local.tags
      public_subnet_tags              = local.tags
      peer_with_all                   = false,
      s3_gateway_endpoint             = false,
      s3_interface_endpoints          = true,
      ssm_interface_endpoints         = true,
      ssmmessages_interface_endpoints = true,
      tags                            = {}
    },
    {
      name                            = "test",
      environment                     = "test",
      availability_zones              = local.availability_zones,
      cidr_block                      = "10.16.128.0/17",
      dhcp_options                    = local.global_dhcp_options,
      ebs_interface_endpoints         = true,
      ec2_interface_endpoints         = true,
      ec2messages_interface_endpoints = true,
      mesh                            = false,
      mgn_interface_endpoints         = true,
      public_subnet_bits              = 20,
      private_subnet_bits             = 20,
      private_subnet_tags             = local.tags
      public_subnet_tags              = local.tags
      peer_with_all                   = false,
      s3_gateway_endpoint             = false,
      s3_interface_endpoints          = true,
      ssm_interface_endpoints         = true,
      ssmmessages_interface_endpoints = true,
      tags                            = {}
    },
    {
      name                            = "acceptance",
      environment                     = "acceptance",
      availability_zones              = local.availability_zones,
      cidr_block                      = "10.17.0.0/17",
      dhcp_options                    = local.global_dhcp_options,
      ebs_interface_endpoints         = true,
      ec2_interface_endpoints         = true,
      ec2messages_interface_endpoints = true,
      mesh                            = false,
      mgn_interface_endpoints         = true,
      public_subnet_bits              = 20,
      private_subnet_bits             = 20,
      private_subnet_tags             = local.tags
      public_subnet_tags              = local.tags
      peer_with_all                   = false,
      s3_gateway_endpoint             = false,
      s3_interface_endpoints          = true,
      ssm_interface_endpoints         = true,
      ssmmessages_interface_endpoints = true,
      tags                            = {}
    },
    {
      name                            = "production",
      environment                     = "production",
      availability_zones              = local.availability_zones,
      cidr_block                      = "10.17.128.0/17",
      dhcp_options                    = local.global_dhcp_options,
      ebs_interface_endpoints         = true,
      ec2_interface_endpoints         = true,
      ec2messages_interface_endpoints = true,
      mesh                            = false,
      mgn_interface_endpoints         = true,
      public_subnet_bits              = 20,
      private_subnet_bits             = 20,
      private_subnet_tags             = local.tags
      public_subnet_tags              = local.tags
      peer_with_all                   = false,
      s3_gateway_endpoint             = false,
      s3_interface_endpoints          = true,
      ssm_interface_endpoints         = true,
      ssmmessages_interface_endpoints = true,
      tags                            = {}

    },
    {
      name                            = "services",
      environment                     = "services",
      availability_zones              = local.availability_zones,
      cidr_block                      = "10.18.0.0/17",
      dhcp_options                    = local.global_dhcp_options,
      ebs_interface_endpoints         = true,
      ec2_interface_endpoints         = true,
      ec2messages_interface_endpoints = true,
      mesh                            = false,
      mgn_interface_endpoints         = true,
      public_subnet_bits              = 20,
      private_subnet_bits             = 20,
      private_subnet_tags             = local.tags
      public_subnet_tags              = local.tags
      peer_with_all                   = false,
      s3_gateway_endpoint             = false,
      s3_interface_endpoints          = true,
      ssm_interface_endpoints         = true,
      ssmmessages_interface_endpoints = true,
      tags                            = {}
    },
    {
      name                            = "development-mesh",
      environment                     = "development",
      availability_zones              = local.availability_zones,
      cidr_block                      = "10.18.128.0/17",
      dhcp_options                    = local.global_dhcp_options,
      ebs_interface_endpoints         = true,
      ec2_interface_endpoints         = true,
      ec2messages_interface_endpoints = true,
      mesh                            = false,
      mgn_interface_endpoints         = true,
      public_subnet_bits              = 20,
      private_subnet_bits             = 20,
      private_subnet_tags             = local.tags
      public_subnet_tags              = local.tags
      peer_with_all                   = false,
      s3_gateway_endpoint             = false,
      s3_interface_endpoints          = true,
      ssm_interface_endpoints         = true,
      ssmmessages_interface_endpoints = true,
      tags                            = {}
    },
    {
      name                            = "test-mesh",
      environment                     = "test",
      availability_zones              = local.availability_zones,
      cidr_block                      = "10.19.0.0/17",
      dhcp_options                    = local.global_dhcp_options,
      ebs_interface_endpoints         = true,
      ec2_interface_endpoints         = true,
      ec2messages_interface_endpoints = true,
      mesh                            = false,
      mgn_interface_endpoints         = true,
      public_subnet_bits              = 20,
      private_subnet_bits             = 20,
      private_subnet_tags             = local.tags
      public_subnet_tags              = local.tags
      peer_with_all                   = false,
      s3_gateway_endpoint             = false,
      s3_interface_endpoints          = true,
      ssm_interface_endpoints         = true,
      ssmmessages_interface_endpoints = true,
      tags                            = {}
    },
    {
      name                            = "acceptance-mesh",
      environment                     = "acceptance",
      availability_zones              = local.availability_zones,
      cidr_block                      = "10.19.128.0/17",
      dhcp_options                    = local.global_dhcp_options,
      ebs_interface_endpoints         = true,
      ec2_interface_endpoints         = true,
      ec2messages_interface_endpoints = true,
      mesh                            = false,
      mgn_interface_endpoints         = true,
      public_subnet_bits              = 20,
      private_subnet_bits             = 20,
      private_subnet_tags             = local.tags
      public_subnet_tags              = local.tags
      peer_with_all                   = false,
      s3_gateway_endpoint             = false,
      s3_interface_endpoints          = true,
      ssm_interface_endpoints         = true,
      ssmmessages_interface_endpoints = true,
      tags                            = {}
    },
    {
      name                            = "production-mesh",
      environment                     = "production",
      availability_zones              = local.availability_zones,
      cidr_block                      = "10.20.0.0/17",
      dhcp_options                    = local.global_dhcp_options,
      ebs_interface_endpoints         = true,
      ec2_interface_endpoints         = true,
      ec2messages_interface_endpoints = true,
      mesh                            = false,
      mgn_interface_endpoints         = true,
      public_subnet_bits              = 20,
      private_subnet_bits             = 20,
      private_subnet_tags             = local.tags
      public_subnet_tags              = local.tags
      peer_with_all                   = false,
      s3_gateway_endpoint             = false,
      s3_interface_endpoints          = true,
      ssm_interface_endpoints         = true,
      ssmmessages_interface_endpoints = true,
      tags                            = {}
    }
  ]
}
