resource "aws_ec2_transit_gateway" "default" {
  description                     = coalesce(var.description, var.name)
  amazon_side_asn                 = var.amazon_side_asn
  default_route_table_association = var.enable_default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = var.enable_default_route_table_propagation ? "enable" : "disable"
  auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments ? "enable" : "disable"
  vpn_ecmp_support                = var.enable_vpn_ecmp_support ? "enable" : "disable"
  dns_support                     = var.enable_dns_support ? "enable" : "disable"
  tags = merge(var.tags, var.transit_gateway_tags, { Name = var.name })
}

resource "aws_ram_resource_share" "default" {
  count                     = var.enable_sharing ? 1 : 0
  name                      = coalesce(var.ram_share_name, var.name)
  allow_external_principals = var.ram_allow_external_principals
  depends_on                = [aws_ec2_transit_gateway.default]
  tags = merge(var.tags,
               var.ram_tags,
               { Name = "${length(var.ram_share_name) > 0 ? "${var.ram_share_name}-" : ""}${var.name}"})
}

resource "aws_ram_resource_association" "default" {
  count              = var.enable_sharing ? 1 : 0
  resource_arn       = aws_ec2_transit_gateway.default.arn
  resource_share_arn = aws_ram_resource_share.default[0].id
  depends_on         = [aws_ec2_transit_gateway.default]
}

resource "aws_ram_principal_association" "default" {
  count              = var.enable_sharing ? length(var.ram_principals) : 0
  principal          = var.ram_principals[count.index]
  resource_share_arn = aws_ram_resource_share.default[0].arn
}

module "attachment_route_table" {
  source             = "../tgw-vpc-attachment"
  for_each           = { for vpc in var.vpcs_to_attach : vpc.id => vpc }
  transit_gateway_id = aws_ec2_transit_gateway.default.id
  vpc_id             = each.value.id
  subnet_ids         = each.value.private_subnet_ids
  route_table_ids    = each.value.private_route_table_ids
  name               = each.value.name
  environment        = each.value.environment
  depends_on         = [aws_ec2_transit_gateway.default]
}
