resource "aws_ec2_transit_gateway_route" "default_gateway" {
  for_each                       = toset(var.vpc_layout_attachment_route_table_ids)
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = var.egress_vpc_attachment_id
  transit_gateway_route_table_id = each.value
}

locals {
  all_tgw_route_table_ids = toset(
    concat(var.vpc_layout_attachment_route_table_ids,
      [var.external_route_table_id,
        var.non_production_route_table_id,
    var.egress_vpc_attachment_route_table_id])
  )
}

resource "aws_ec2_transit_gateway_route" "blackhole_rfc1918_10" {
  for_each                       = local.all_tgw_route_table_ids
  destination_cidr_block         = "10.0.0.0/8"
  blackhole                      = true
  transit_gateway_route_table_id = each.value
}

resource "aws_ec2_transit_gateway_route" "blackhole_rfc1918_172" {
  for_each                       = local.all_tgw_route_table_ids
  destination_cidr_block         = "172.16.0.0/12"
  blackhole                      = true
  transit_gateway_route_table_id = each.value
}

resource "aws_ec2_transit_gateway_route" "blackhole_rfc1918_192" {
  for_each                       = local.all_tgw_route_table_ids
  destination_cidr_block         = "192.168.0.0/16"
  blackhole                      = true
  transit_gateway_route_table_id = each.value
}

resource "aws_ec2_transit_gateway_route_table_propagation" "layout_vpcs_to_egress_vpc" {
  for_each                       = toset(var.vpc_layout_attachment_route_table_ids)
  transit_gateway_attachment_id  = var.egress_vpc_attachment_id
  transit_gateway_route_table_id = each.value
}

resource "aws_ec2_transit_gateway_route_table_propagation" "egress_vpc_to_layout_vpcs" {
  for_each                       = toset(var.vpc_layout_attachment_ids)
  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = var.egress_vpc_attachment_route_table_id
}

resource "aws_route" "egress_public_to_vpcs" {
  for_each               = toset(var.vpc_layout_cidr_blocks)
  route_table_id         = var.egress_vpc_public_route_table_id
  destination_cidr_block = each.value
  transit_gateway_id     = var.transit_gateway_id
  timeouts {
    create = "5m"
    delete = "5m"
  }
}

locals {
  egress_vpc_private_route_table_entries = { for pair in setproduct(var.egress_vpc_private_route_table_ids, var.vpc_layout_cidr_blocks)
    : "route-table-${pair[0]}-to-${pair[1]}" => {
      route_table_id = pair[0],
      cidr_block     = pair[1]
    }

  }
}

resource "aws_route" "egress_private_to_vpcs" {
  for_each               = local.egress_vpc_private_route_table_entries
  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.cidr_block
  transit_gateway_id     = var.transit_gateway_id
  timeouts {
    create = "5m"
    delete = "5m"
  }
}

resource "aws_ec2_transit_gateway_route_table_propagation" "non_production_domain_to_vpcs" {
  for_each                       = toset(var.vpc_layout_non_production_attachment_ids)
  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = var.non_production_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "external_domain_to_vpcs" {
  for_each                       = toset(var.vpc_layout_attachment_ids)
  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = var.external_route_table_id
}