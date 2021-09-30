output "id" {
  description = "EC2 Transit Gateway identifier."
  value       = aws_ec2_transit_gateway.default.id
}

output "vpc_layout_attachment_ids" {
  description = "The attachment IDs of the all VPCs attached to the transit gateway."
  value       = values(module.attachment_route_table)[*].attachment_id
}

output "vpc_layout_attachments_route_table_ids" {
  description = "The attachment route table IDs of the all VPCs attached to the transit gateway."
  value       = values(module.attachment_route_table)[*].route_table_id
}

output "vpc_layout_cidr_blocks" {
  description = "The cidr blocks of all the attached VPCs."
  value       = var.vpcs_to_attach[*].cidr_block
}

output "vpc_layout_non_production_attachment_ids" {
  description = "The attachment IDs of the non production VPCs attached to the transit gateway."
  value = [for attachment in values(module.attachment_route_table)[*] :
  attachment.attachment_id if attachment.environment != "production"]
}

output "vpc_layout_non_production_attachment_route_table_ids" {
  description = "The attachment route table IDs of the non production VPCs attached to the transit gateway."
  value = [for attachment in values(module.attachment_route_table)[*] :
  attachment.route_table_id if attachment.environment != "production"]
}

output "vpc_layout_production_attachment_ids" {
  description = "The attachment IDs of the production VPCs attached to the transit gateway."
  value = [for attachment in values(module.attachment_route_table)[*] :
  attachment.attachment_id if attachment.environment == "production"]
}

output "vpc_layout_development_attachment_route_table_ids" {
  description = "The attachment route table IDs of the development VPCs attached to the transit gateway."
  value       = [for attachment in values(module.attachment_route_table)[*] :
  attachment.route_table_id if attachment.environment == "development"]
}

output "vpc_layout_test_attachment_route_table_ids" {
  description = "The attachment route table IDs of the test VPCs attached to the transit gateway."
  value       = [for attachment in values(module.attachment_route_table)[*] :
  attachment.route_table_id if attachment.environment == "test"]
}

output "vpc_layout_acceptance_attachment_route_table_ids" {
  description = "The attachment route table IDs of the acceptance VPCs attached to the transit gateway."
  value       = [for attachment in values(module.attachment_route_table)[*] :
  attachment.route_table_id if attachment.environment == "acceptance"]
}

output "vpc_layout_production_attachment_route_table_ids" {
  description = "The attachment route table IDs of the production VPCs attached to the transit gateway."
  value = [for attachment in values(module.attachment_route_table)[*] :
  attachment.route_table_id if attachment.environment == "production"]
}

output "vpc_layout_services_attachment_route_table_ids" {
  description = "The attachment route table IDs of the services VPCs attached to the transit gateway."
  value       = [for attachment in values(module.attachment_route_table)[*] :
  attachment.route_table_id if attachment.environment == "services"]
}
