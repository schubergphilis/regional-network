include {
  path = find_in_parent_folders()
}

locals {
  layout                            = read_terragrunt_config("${get_parent_terragrunt_dir()}/layout.hcl").locals
  connectivity                      = read_terragrunt_config("${get_parent_terragrunt_dir()}/connectivity.hcl").locals
  vpcs                              = local.layout.vpcs
  configured_environments           = distinct([for vpc in local.vpcs : vpc.environment])
  region                            = local.layout.region
  flow_log_retention_period_in_days = local.layout.flow_log_retention_period_in_days
  egress_vpc                        = local.connectivity.egress_vpc
}

terraform {
  source = "github.com/schubergphilis/regional-network.git//external-connectivity?ref=0.1.0"
}

dependency "vpc_layout" {
  config_path = "../vpc-layout"
  mock_outputs = {
    vpcs_all = [for vpc in local.vpcs :
      merge(vpc,
        { id : "${vpc.name}-id-here",
          private_subnet_ids : [for zone in vpc.availability_zones : "${vpc.name}-${zone}-private-subnet-id-here"],
          private_route_table_ids : [for zone in vpc.availability_zones : "${vpc.name}-${zone}-private-route-table-id-here"]
    })]
  }
}

inputs = {
  cloudwatch_flow_log_group_name    = "vpc-flow-logs-${local.egress_vpc.name}-${local.region}"
  egress_vpc                        = local.egress_vpc
  flow_log_retention_period_in_days = local.flow_log_retention_period_in_days
  region                            = local.region
  deployed_vpcs                     = dependency.vpc_layout.outputs.vpcs_all
  transit_gateway_name              = "transit-gateway-${local.region}"
}