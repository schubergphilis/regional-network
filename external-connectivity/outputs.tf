output "egress_private_route_table_ids" {
  description = "The private route table IDs of the Egress VPC."
  value       = module.egress_vpc.private_route_table_ids
}

output "egress_public_route_table_id" {
  description = "The public route table ID of the Egress VPC."
  value       = module.egress_vpc.public_route_table_id
}

output "egress_vpc_attachment_id" {
  description = "The attachment ID of the Egress VPC."
  value       = module.egress_to_tgw_attachment.attachment_id
}

output "egress_vpc_attachment_route_table_id" {
  description = "The attachment route table ID of the Egress VPC."
  value       = module.egress_to_tgw_attachment.route_table_id
}

output "egress_vpc_cidr_block" {
  description = "The cidr block of the Egress VPC."
  value       = module.egress_vpc.cidr_block
}

output "external_route_table_id" {
  description = "The ID of the external route table."
  value = aws_ec2_transit_gateway_route_table.external_route_table.id
}

output "non_production_route_table_id" {
  description = "The ID of the non production route table."
  value = aws_ec2_transit_gateway_route_table.non_production_route_table.id
}

output "transit_gateway_id" {
  description = "EC2 Transit Gateway identifier"
  value       = module.transit_gateway.id
}

output "vpc_layout_attachment_ids" {
  description = "The attachment IDs of the all VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_attachment_ids
}

output "vpc_layout_attachment_route_table_ids" {
  description = "The attachment route table IDs of all the VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_attachments_route_table_ids
}

output "vpc_layout_cidr_blocks" {
  description = "The CIDR blocks of all the VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_cidr_blocks
}

output "vpc_layout_non_production_attachment_ids" {
  description = "The attachment IDs of the non production VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_non_production_attachment_ids
}

output "vpc_layout_non_production_attachment_route_table_ids" {
  description = "The attachment route table IDs of the non production VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_non_production_attachment_route_table_ids
}

output "vpc_layout_production_attachment_ids" {
  description = "The attachment IDs of the production VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_production_attachment_ids
}

output "vpc_layout_production_attachment_route_table_ids" {
  description = "The attachment route table IDs of the production VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_production_attachment_route_table_ids
}

locals {
  data_exports = {
    name = "transit_gateway_id"
    value = module.transit_gateway.id
  }
}

output "testing" {
  for_each = local.data_exports
  value = each.value
}