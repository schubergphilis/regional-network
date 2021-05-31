variable "cloudwatch_flow_log_group_name" {
  type        = string
  description = "The name of the cloudwatch log group."
}

variable "deployed_vpcs" {
  type = list(object({
    id                 = string,
    name               = string,
    environment        = string,
    availability_zones = list(string),
    cidr_block         = string,
    peer_with_all      = bool,
    mesh               = bool,
    cidr_block         = string,
    private_subnet_ids = list(string)
    private_route_table_ids = list(string)
  tags = map(string) }))
  description = "A list of VPC that are deployed."
}

variable "egress_vpc" {
  type = object({
    cidr_block          = string
    name                = string
    environment         = string
    availability_zones  = list(string)
    public_subnet_bits  = number
    private_subnet_bits = number
    tags                = map(string)
  })
  description = "The name of the cloudwatch log group."
}

variable "external_route_table_name" {
  type        = string
  default     = "route-table-external"
  description = "The name of the external route table."
}

variable "flow_log_retention_period_in_days" {
  type        = number
  description = "The retention period for a flow log in days, defaults to 1 day."
  default     = 1
}

variable "non_production_route_table_name" {
  type        = string
  default     = "route-table-non-production"
  description = "The name of the non production route table."
}

variable "prepend_resource_type" {
  type        = bool
  default     = true
  description = "If set it will prepend the resource type on the name of the resource."
}

variable "region" {
  type        = string
  description = "The region that the VPCs will be deployed in."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources"
  default     = {}
}

variable "transit_gateway_name" {
  type        = string
  description = "The name of the transit gateway to deploy."
}

variable "transit_gateway_amazon_side_asn" {
  type        = string
  description = "The asn of to asign to the transit gateway."
  default     = "64512"
}
