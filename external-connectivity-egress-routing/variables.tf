variable "external_route_table_id" {
  type        = string
  description = "The ID of the external route table."
}

variable "egress_vpc_attachment_id" {
  type        = string
  description = "The attachment ID of the Egress VPC."
}

variable "egress_vpc_attachment_route_table_id" {
  type        = string
  description = "The transit gateway attachment route table ID of the Egress VPC."
}

variable "egress_vpc_cidr_block" {
  type        = string
  description = "The cidr block of the Egress VPC."
}

variable "egress_vpc_private_route_table_ids" {
  type        = list(string)
  description = "The IDs of the private route tables of the Egress VPC."
}

variable "egress_vpc_public_route_table_id" {
  type        = string
  description = "The ID of the public route table of the Egress VPC."
}

variable "non_production_route_table_id" {
  type        = string
  description = "The transit gateway non production route table ID."
}

variable "transit_gateway_id" {
  type        = string
  description = "The transit gateway ID."
}

variable "vpc_layout_attachment_ids" {
  type        = list(string)
  description = "The transit gateway attachment IDs of the VPCs deployed in the layout."
}

variable "vpc_layout_attachment_route_table_ids" {
  type        = list(string)
  description = "The transit gateway attachment route table IDs of the VPCs deployed in the layout."
}

variable "vpc_layout_cidr_blocks" {
  type        = list(string)
  description = "The cidr blocks VPCs deployed in the layout."
}

variable "vpc_layout_non_production_attachment_ids" {
  type        = list(string)
  description = "The transit gateway attachment IDs of the non production VPCs deployed in the layout."
}

variable "vpc_layout_non_production_attachment_route_table_ids" {
  type        = list(string)
  description = "The transit gateway attachment route table IDs of the non production VPCs deployed in the layout."
}

variable "vpc_layout_production_attachment_ids" {
  type        = list(string)
  description = "The transit gateway attachment IDs of the production VPCs deployed in the layout."
}

variable "vpc_layout_development_attachment_route_table_ids" {
  type        = list(string)
  description = "The transit gateway attachment route table IDs of the development VPCs deployed in the layout."
}

variable "vpc_layout_test_attachment_route_table_ids" {
  type        = list(string)
  description = "The transit gateway attachment route table IDs of the test VPCs deployed in the layout."
}

variable "vpc_layout_acceptance_attachment_route_table_ids" {
  type        = list(string)
  description = "The transit gateway attachment route table IDs of the acceptance VPCs deployed in the layout."
}

variable "vpc_layout_production_attachment_route_table_ids" {
  type        = list(string)
  description = "The transit gateway attachment route table IDs of the production VPCs deployed in the layout."
}

variable "vpc_layout_services_attachment_route_table_ids" {
  type        = list(string)
  description = "The transit gateway attachment route table IDs of the services VPCs deployed in the layout."
}

variable "consul_data_lookup" {
  type = bool
  description = "Use consul as a data source to determine routes to deploy."
  default = false
}

variable "peer_routing_regions" {
  type = list(string)
  description = "A list of regions to calculate regional routing for."
  default = []
}