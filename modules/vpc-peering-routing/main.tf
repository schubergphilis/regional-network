resource "aws_vpc_peering_connection" "peering" {
  tags        = { Name = "${var.prepend_resource_type ? "vpc-peer-" : ""}${var.vpc_pair["vpc"].name}-to-${var.vpc_pair["peer_vpc"].name}" }
  auto_accept = true
  peer_vpc_id = var.vpc_pair["peer_vpc"].id
  vpc_id      = var.vpc_pair["vpc"].id
  accepter {
    allow_remote_vpc_dns_resolution = false
  }
  requester {
    allow_remote_vpc_dns_resolution = false
  }
}

locals {
  vpc_public_route_table_id      = try(var.vpc_pair["vpc"].public_route_table_id, null) == null ? [] : [var.vpc_pair["vpc"].public_route_table_id]
  vpc_peer_public_route_table_id = try(var.vpc_pair["peer_vpc"].public_route_table_id, null) == null ? [] : [var.vpc_pair["peer_vpc"].public_route_table_id]
}

resource "aws_route" "route_to" {
  for_each                  = toset(concat(var.vpc_pair["vpc"].private_route_table_ids, local.vpc_public_route_table_id))
  route_table_id            = each.value
  destination_cidr_block    = var.vpc_pair["peer_vpc"].cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

resource "aws_route" "route_from" {
  for_each                  = toset(concat(var.vpc_pair["peer_vpc"].private_route_table_ids, local.vpc_peer_public_route_table_id))
  route_table_id            = each.value
  destination_cidr_block    = var.vpc_pair["vpc"].cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}
