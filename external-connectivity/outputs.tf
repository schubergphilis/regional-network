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
  value       = aws_ec2_transit_gateway_route_table.external_route_table.id
}

output "non_production_route_table_id" {
  description = "The ID of the non production route table."
  value       = aws_ec2_transit_gateway_route_table.non_production_route_table.id
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

output "vpc_layout_development_attachment_route_table_ids" {
  description = "The attachment route table IDs of the development VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_development_attachment_route_table_ids
}

output "vpc_layout_test_attachment_route_table_ids" {
  description = "The attachment route table IDs of the test VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_test_attachment_route_table_ids
}

output "vpc_layout_acceptance_attachment_route_table_ids" {
  description = "The attachment route table IDs of the acceptance VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_acceptance_attachment_route_table_ids
}

output "vpc_layout_production_attachment_route_table_ids" {
  description = "The attachment route table IDs of the production VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_production_attachment_route_table_ids
}

output "vpc_layout_services_attachment_route_table_ids" {
  description = "The attachment route table IDs of the services VPCs deployed in the layout."
  value       = module.transit_gateway.vpc_layout_services_attachment_route_table_ids
}

locals {
  data_exports = [
    {
      key_name = "egress-private-route-table-ids"
      value    = join(",", module.egress_vpc.private_route_table_ids)
    },
    {
      key_name = "egress-public-route-table-id"
      value    = module.egress_vpc.public_route_table_id
    },
    {
      key_name = "egress-vpc-attachment-id"
      value    = module.egress_to_tgw_attachment.attachment_id
    },
    {
      key_name = "egress-vpc-attachment-route-table-id"
      value    = module.egress_to_tgw_attachment.route_table_id
    },
    {
      key_name = "egress-vpc-cidr-block"
      value    = module.egress_vpc.cidr_block
    },
    {
      key_name = "external-route-table-id"
      value    = aws_ec2_transit_gateway_route_table.external_route_table.id
    },
    {
      key_name = "non-production-route-table-id"
      value    = aws_ec2_transit_gateway_route_table.non_production_route_table.id
    },
    {
      key_name = "transit-gateway-id"
      value    = module.transit_gateway.id
    },
    {
      key_name = "vpc-layout-attachment-ids"
      value    = join(",", module.transit_gateway.vpc_layout_attachment_ids)
    },
    {
      key_name = "vpc-layout-attachment-route-table-ids"
      value    = join(",", module.transit_gateway.vpc_layout_attachments_route_table_ids)
    },
    {
      key_name = "vpc-layout-cidr-blocks"
      value    = join(",", module.transit_gateway.vpc_layout_cidr_blocks)
    },
    {
      key_name = "vpc-layout-non-production-attachment-ids"
      value    = join(",", module.transit_gateway.vpc_layout_non_production_attachment_ids)
    },
    {
      key_name = "vpc-layout-non-production-attachment-route-table-ids"
      value    = join(",", module.transit_gateway.vpc_layout_non_production_attachment_route_table_ids)
    },
    {
      key_name = "vpc-layout-production-attachment-ids"
      value    = join(",", module.transit_gateway.vpc_layout_production_attachment_ids)
    },
    {
      key_name = "vpc-layout-development-attachment-route-table-ids"
      value    = join(",", module.transit_gateway.vpc_layout_development_attachment_route_table_ids)
    },
    {
      key_name = "vpc-layout-test-attachment-route-table-ids"
      value    = join(",", module.transit_gateway.vpc_layout_test_attachment_route_table_ids)
    },
    {
      key_name = "vpc-layout-acceptance-attachment-route-table-ids"
      value    = join(",", module.transit_gateway.vpc_layout_acceptance_attachment_route_table_ids)
    },
    {
      key_name = "vpc-layout-production-attachment-route-table-ids"
      value    = join(",", module.transit_gateway.vpc_layout_production_attachment_route_table_ids)
    },
    {
      key_name = "vpc-layout-services-attachment-route-table-ids"
      value    = join(",", module.transit_gateway.vpc_layout_services_attachment_route_table_ids)
    }
  ]
  data_exports_map = { for item in local.data_exports : item.key_name => item }
}
