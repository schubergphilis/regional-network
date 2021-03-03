include {
  path = find_in_parent_folders()
}

locals {
  layout                  = read_terragrunt_config("${get_parent_terragrunt_dir()}/layout.hcl").locals
  connectivity            = read_terragrunt_config("${get_parent_terragrunt_dir()}/connectivity.hcl").locals
  vpcs                    = local.layout.vpcs
  configured_environments = distinct([for vpc in local.vpcs : vpc.environment])
  enable_public_subnets   = try(local.connectivity.egress_vpc, null) != null ? false : true
}

terraform {
  source = "github.com/schubergphilis/regional-network.git//vpc-peering-routing?ref=0.1.0"
}


dependency "vpc_layout" {
  config_path = "../vpc-layout"
  mock_outputs = {
    vpc_pairs_mesh = { for pair in
      [for distinct_pair in distinct(
        [for product_pair in setproduct(
          [for vpc in local.vpcs : vpc if vpc.mesh == true],
          [for vpc in local.vpcs : vpc if vpc.mesh == true])
        : sort(product_pair[*].name) if product_pair[0].name != product_pair[1].name])
      : [for vpc in local.vpcs : vpc if contains(distinct_pair, tostring(vpc.name))]]
      : "${pair[0].name}-to-${pair[1].name}" => {
        vpc = merge(pair[0],
          { id : "${pair[0].name}-id-here",
            public_route_table_id : local.enable_public_subnets ? "${pair[0].name}-public-route-table-id-here" : null,
            private_route_table_ids : [for zone in pair[0].availability_zones : "${pair[0].name}-${zone}-private-route-table-id-here"]
        })
        peer_vpc = merge(pair[1],
          { id : "${pair[1].name}-id-here",
            public_route_table_id : local.enable_public_subnets ? "${pair[1].name}-public-route-table-id-here" : null,
            private_route_table_ids : [for zone in pair[1].availability_zones : "${pair[1].name}-${zone}-private-route-table-id-here"]
        })
      }
    },
    vpc_pairs_same_environment = { for pair in
      { for environment in local.configured_environments : environment =>
        [for vpc in local.vpcs : vpc if vpc.environment == environment]
      if length([for vpc in local.vpcs : vpc if vpc.environment == environment]) == 2 }
      : "environment-${pair[0].environment}-pair" => {
        vpc = merge(pair[0],
          { id : "${pair[0].name}-id-here",
            public_route_table_id : local.enable_public_subnets ? "${pair[0].name}-public-route-table-id-here" : null,
            private_route_table_ids : [for zone in pair[0].availability_zones : "${pair[0].name}-${zone}-private-route-table-id-here"]
        })
        peer_vpc = merge(pair[1],
          { id : "${pair[1].name}-id-here",
            public_route_table_id : local.enable_public_subnets ? "${pair[1].name}-public-route-table-id-here" : null,
            private_route_table_ids : [for zone in pair[1].availability_zones : "${pair[1].name}-${zone}-private-route-table-id-here"]
        })
      }
    }
    vpc_pairs_services_to_all = { for pair in setproduct(
      [for vpc in local.vpcs : vpc if vpc.peer_with_all == true],
      [for vpc in local.vpcs : vpc if vpc.peer_with_all == false])
      : "services-pair-to-${pair[1].name}" => {
        vpc = merge(pair[0],
          { id : "${pair[0].name}-id-here",
            public_route_table_id : local.enable_public_subnets ? "${pair[0].name}-public-route-table-id-here" : null,
            private_route_table_ids : [for zone in pair[0].availability_zones : "${pair[0].name}-${zone}-private-route-table-id-here"]
        })
        peer_vpc = merge(pair[1],
          { id : "${pair[1].name}-id-here",
            public_route_table_id : local.enable_public_subnets ? "${pair[1].name}-public-route-table-id-here" : null,
            private_route_table_ids : [for zone in pair[1].availability_zones : "${pair[1].name}-${zone}-private-route-table-id-here"]
        })
      }
    }
  }
}

inputs = {
  peering_vpcs = merge(
    dependency.vpc_layout.outputs.vpc_pairs_mesh,
    dependency.vpc_layout.outputs.vpc_pairs_same_environment,
    dependency.vpc_layout.outputs.vpc_pairs_services_to_all
  )
}