include {
  path = find_in_parent_folders()
}

locals {
  layout        = read_terragrunt_config("${get_parent_terragrunt_dir()}/layout.hcl").locals
  connectivity  = read_terragrunt_config("${get_parent_terragrunt_dir()}/connectivity.hcl").locals
  vpcs          = local.layout.vpcs
  egress_vpc    = local.connectivity.egress_vpc
}

terraform {
  source = "github.com/schubergphilis/regional-network.git//external-connectivity-egress-routing?ref=0.1.0"
}

dependency "external_connectivity" {
  config_path = "../external-connectivity"
  mock_outputs = {
    egress_private_route_table_ids                       = [for az in local.egress_vpc.availability_zones : "egress-private-route-table-${az}id-here"]
    egress_public_route_table_id                         = "egress-public-route-table-id-here"
    egress_vpc_attachment_id                             = "egress-vpc-attachment-id-here"
    egress_vpc_attachment_route_table_id                 = "egress-vpc-attachment-route-table-id-here"
    egress_vpc_cidr_block                                = local.egress_vpc.cidr_block
    external_route_table_id                              = "external-route-table-id-here"
    non_production_route_table_id                        = "non-production-route-table-id-here"
    transit_gateway_id                                   = "transit-gateway-id-here"
    vpc_layout_attachment_ids                            = [for vpc in local.vpcs : "${vpc.name}-attachment-id-here"]
    vpc_layout_attachment_route_table_ids                = [for vpc in local.vpcs : "${vpc.name}-tgw-attachment-route-table-id-here"]
    vpc_layout_cidr_blocks                               = [for vpc in local.vpcs : vpc.cidr_block]
    vpc_layout_production_attachment_ids                 = [for vpc in local.vpcs : "${vpc.name}-attachment-id-here" if vpc.environment == "production"]
    vpc_layout_production_attachment_route_table_ids     = [for vpc in local.vpcs : "${vpc.name}-route-table-attachment-id-here" if vpc.environment == "production"]
    vpc_layout_non_production_attachment_ids             = [for vpc in local.vpcs : "${vpc.name}-attachment-id-here" if vpc.environment != "production"]
    vpc_layout_non_production_attachment_route_table_ids = [for vpc in local.vpcs : "${vpc.name}-route-table-attachment-id-here" if vpc.environment != "production"]
  }
}

inputs = {
  egress_vpc_private_route_table_ids                   = dependency.external_connectivity.outputs.egress_private_route_table_ids
  egress_vpc_public_route_table_id                     = dependency.external_connectivity.outputs.egress_public_route_table_id
  egress_vpc_attachment_id                             = dependency.external_connectivity.outputs.egress_vpc_attachment_id
  egress_vpc_attachment_route_table_id                 = dependency.external_connectivity.outputs.egress_vpc_attachment_route_table_id
  egress_vpc_cidr_block                                = dependency.external_connectivity.outputs.egress_vpc_cidr_block
  external_route_table_id                              = dependency.external_connectivity.outputs.external_route_table_id
  non_production_route_table_id                        = dependency.external_connectivity.outputs.non_production_route_table_id
  transit_gateway_id                                   = dependency.external_connectivity.outputs.transit_gateway_id
  vpc_layout_attachment_ids                            = dependency.external_connectivity.outputs.vpc_layout_attachment_ids
  vpc_layout_attachment_route_table_ids                = dependency.external_connectivity.outputs.vpc_layout_attachment_route_table_ids
  vpc_layout_cidr_blocks                               = dependency.external_connectivity.outputs.vpc_layout_cidr_blocks
  vpc_layout_production_attachment_ids                 = dependency.external_connectivity.outputs.vpc_layout_production_attachment_ids
  vpc_layout_production_attachment_route_table_ids     = dependency.external_connectivity.outputs.vpc_layout_production_attachment_route_table_ids
  vpc_layout_non_production_attachment_ids             = dependency.external_connectivity.outputs.vpc_layout_non_production_attachment_ids
  vpc_layout_non_production_attachment_route_table_ids = dependency.external_connectivity.outputs.vpc_layout_non_production_attachment_route_table_ids
}
