module "layout" {
  source                            = "../modules/vpc-stackable"
  for_each                          = { for vpc in var.vpcs : vpc.name => vpc }
  name                              = each.value.name
  environment                       = each.value.environment
  availability_zones                = each.value.availability_zones
  cidr_block                        = each.value.cidr_block
  public_subnet_bits                = each.value.public_subnet_bits
  private_subnet_bits               = each.value.private_subnet_bits
  peer_with_all                     = each.value.peer_with_all
  mesh                              = each.value.mesh
  tags                              = each.value.tags
  dhcp_options                      = each.value.dhcp_options
  region                            = var.region
  enable_nat_gateway                = var.enable_nat_gateways
  prepend_resource_type             = var.prepend_resource_type
  cloudwatch_flow_log_group_name    = "${var.prepend_resource_type ? "vpc-flow-logs-" : ""}${each.value.name}-${var.region}"
  flow_log_retention_period_in_days = var.flow_log_retention_period_in_days
}

locals {
  configured_environments = distinct([for vpc in var.vpcs : vpc.environment])
}

