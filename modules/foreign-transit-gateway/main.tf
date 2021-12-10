locals {
  foreign_routes_map = { for route in var.vpc_with_foreign_routes.foreign_routes : route.environment => route }
  routes             = [for route in var.vpc_with_foreign_routes.foreign_routes : setproduct(route.target_cidr_ranges, var.vpc_with_foreign_routes.private_route_table_ids, [route.foreign_transit_gateway_id])][0]
  routes_map         = { for product in local.routes : format("%s-%s", product[0], product[1]) => { destination_cidr_block = product[0], route_table_id = product[1], transit_gateway_id = product[2] } }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "default" {
  for_each           = local.foreign_routes_map
  transit_gateway_id = each.value.foreign_transit_gateway_id
  subnet_ids         = var.vpc_with_foreign_routes.private_subnet_ids
  vpc_id             = var.vpc_with_foreign_routes.id
  tags = merge(var.tags, {
    Name = format("attachment-%s-foreign-%s", var.vpc_with_foreign_routes.environment, each.value.foreign_transit_gateway_id)
  })
}

resource "aws_route" "default" {
  for_each               = local.routes_map
  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.destination_cidr_block
  transit_gateway_id     = each.value.transit_gateway_id
  depends_on             = [aws_ec2_transit_gateway_vpc_attachment.default]
}
