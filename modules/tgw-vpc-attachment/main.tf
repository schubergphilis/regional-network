resource "aws_ec2_transit_gateway_vpc_attachment" "default" {
  transit_gateway_id                              = var.transit_gateway_id
  vpc_id                                          = var.vpc_id
  subnet_ids                                      = var.subnet_ids
  dns_support                                     = "enable"
  ipv6_support                                    = "disable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  tags = merge(var.tags, {
    "Name" = "${var.prepend_resource_type ? "attachment-" : ""}${var.name}"
  })
}

resource "aws_ec2_transit_gateway_route_table" "default" {
  transit_gateway_id = var.transit_gateway_id
  tags = merge(var.tags, {
    Name = "${var.prepend_resource_type ? "route-table-" : ""}${var.name}"
  })
}

resource "aws_ec2_transit_gateway_route_table_association" "default" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.default.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.default.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "default" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.default.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.default.id
}

resource "aws_route" "vpc_to_tgw" {
  count                  = length(var.route_table_ids)
  route_table_id         = var.route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = var.transit_gateway_id
  depends_on             = [aws_ec2_transit_gateway_vpc_attachment.default]
}
