output "attachment_id" {
  description = "The ID of the attachment."
  value       = aws_ec2_transit_gateway_vpc_attachment.default.id
}

output "environment" {
  description = "The environment of the attachment."
  value       = var.environment
}

output "route_table_id" {
  description = "The ID of the attachment route table."
  value       = aws_ec2_transit_gateway_route_table.default.id
}