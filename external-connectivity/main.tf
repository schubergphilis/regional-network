module "transit_gateway" {
  source                                 = "../modules/transit-gateway"
  name                                   = var.transit_gateway_name
  amazon_side_asn                        = var.transit_gateway_amazon_side_asn
  description                            = "Transit gateway for region ${var.region}"
  enable_default_route_table_association = false
  enable_default_route_table_propagation = false
  enable_auto_accept_shared_attachments  = false
  vpcs_to_attach                         = var.deployed_vpcs
  tags                                   = merge(var.tags, { Name = var.transit_gateway_name })
}

module "egress_vpc" {
  source                = "github.com/schubergphilis/terraform-aws-mcaf-vpc.git?ref=v1.17.0"
  name                  = var.egress_vpc.name
  cidr_block            = var.egress_vpc.cidr_block
  availability_zones    = var.egress_vpc.availability_zones
  tags                  = merge(var.tags, var.egress_vpc.tags, { environment = var.egress_vpc.environment })
  public_subnet_bits    = var.egress_vpc.public_subnet_bits
  private_subnet_bits   = var.egress_vpc.private_subnet_bits
  prepend_resource_type = true
  private_s3_endpoint   = false
  share_private_subnets = false
  share_public_subnets  = false
  enable_nat_gateway    = true
  flow_logs = {
    retention_in_days = var.flow_log_retention_period_in_days
    traffic_type      = "ALL"
    iam_role_name     = "${var.prepend_resource_type ? "vpc-flow-logs-" : ""}${var.egress_vpc.name}-${var.region}"
    log_group_name    = var.cloudwatch_flow_log_group_name
  }
}

module "egress_to_tgw_attachment" {
  source             = "../modules/tgw-vpc-attachment"
  environment        = var.egress_vpc.environment
  transit_gateway_id = module.transit_gateway.id
  vpc_id             = module.egress_vpc.id
  subnet_ids         = module.egress_vpc.private_subnet_ids
  route_table_ids    = []
  name               = module.egress_vpc.name
  depends_on         = [module.transit_gateway, module.egress_vpc]
}

resource "aws_ec2_transit_gateway_route_table" "external_route_table" {
  transit_gateway_id = module.transit_gateway.id
  tags = merge(var.tags, {
    Name = var.external_route_table_name
  })
}

resource "aws_ec2_transit_gateway_route_table" "non_production_route_table" {
  transit_gateway_id = module.transit_gateway.id
  tags = merge(var.tags, {
    Name = var.non_production_route_table_name
  })
}

module "consul_data_exports" {
  count           = var.export_data_to_consul ? 1 : 0
  source          = "../modules/consul-data-exports"
  key_value_pairs = local.data_exports
  base_path       = "${var.consul_export_base_path}/external-connectivity"
}

data "aws_ec2_transit_gateway_peering_attachment" "foreign_peer" {
  for_each = toset(var.peer_routing_regions)
  filter {
    name   = "tag:Name"
    values = [format("attachment-%s-peer", each.value)]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

locals {
  foreign_peers_map = { for peer in toset([for peer in data.aws_ec2_transit_gateway_peering_attachment.foreign_peer[*] : values(peer)][0]) : peer.id => peer }
}

resource "aws_ec2_transit_gateway_route_table_association" "external_route_domain_to_foreign_global" {
  for_each                       = local.foreign_peers_map
  transit_gateway_attachment_id  = each.value.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.external_route_table.id
}

locals {
  # Merge foreign routing information with any VPCs that match environment
  vpcs_with_foreign_routes = [for vpc in var.deployed_vpcs: merge(vpc, {for route in var.foreign_routes : "foreign_routes" => route... if route.environment == vpc.environment})]
  # Filter out any VPC information that does not contain foreign routing info
  filtered_vpcs_with_foreign_routes = [for vpc in local.vpcs_with_foreign_routes : vpc if lookup(vpc, "foreign_routes", false) != false]
  # Convert to map for module consumption
  vpcs_with_foreign_routes_map = {for vpc in local.filtered_vpcs_with_foreign_routes: vpc.name => vpc}
}

module "foreign_transit_gateway" {
  # If data is provided creates attachments and VPC routes to those attachments for specific cidrs
  for_each = local.vpcs_with_foreign_routes_map
  source = "../modules/foreign-transit-gateway"
  vpc_with_foreign_routes = each.value
}