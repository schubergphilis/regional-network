module "layout" {
  source                            = "../modules/vpc-stackable"
  for_each                          = {for vpc in var.vpcs : vpc.name => vpc}
  availability_zones                = each.value.availability_zones
  cidr_block                        = each.value.cidr_block
  cloudwatch_flow_log_group_name    = "${var.prepend_resource_type ? "vpc-flow-logs-" : ""}${each.value.name}-${var.region}"
  dhcp_options                      = each.value.dhcp_options
  ebs_interface_endpoints           = each.value.ebs_interface_endpoints
  ec2_interface_endpoints           = each.value.ec2_interface_endpoints
  ec2messages_interface_endpoints   = each.value.ec2messages_interface_endpoints
  enable_nat_gateway                = var.enable_nat_gateways
  environment                       = each.value.environment
  flow_log_retention_period_in_days = var.flow_log_retention_period_in_days
  mesh                              = each.value.mesh
  mgn_interface_endpoints           = each.value.mgn_interface_endpoints
  name                              = each.value.name
  peer_with_all                     = each.value.peer_with_all
  prepend_resource_type             = var.prepend_resource_type
  private_subnet_bits               = each.value.private_subnet_bits
  private_subnet_tags               = each.value.private_subnet_tags
  public_subnet_bits                = each.value.public_subnet_bits
  public_subnet_tags                = each.value.public_subnet_tags
  region                            = var.region
  s3_gateway_endpoint               = each.value.s3_gateway_endpoint
  s3_interface_endpoints            = each.value.s3_interface_endpoints
  ssm_interface_endpoints           = each.value.ssm_interface_endpoints
  ssmmessages_interface_endpoints   = each.value.ssmmessages_interface_endpoints
  tags                              = each.value.tags
}

locals {
  configured_environments = distinct([for vpc in var.vpcs : vpc.environment])
}

module "consul_data_exports" {
  count           = var.export_data_to_consul ? 1 : 0
  source          = "../modules/consul-data-exports"
  key_value_pairs = local.data_exports
  base_path       = "${var.consul_export_base_path}/vpc-layout"
}
