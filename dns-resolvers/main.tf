
module "inbound_resolvers" {
  source                            = "../modules/route53-resolver"
  count                             = var.enable_inbound_resolvers == true ? 1 : 0
  subnet_ids_for_resolver_endpoints = var.subnet_ids_for_resolver_endpoints
  security_group_vpc_id             = var.security_group_vpc_id
  resolver_name                     = var.inbound_resolver_name
  resolver_type                     = "INBOUND"
  security_group_rule_cidr_blocks   = var.security_group_rule_cidr_blocks
  resolver_tags                     = var.inbound_resolver_tags
  security_group_tags               = var.inbound_security_group_tags
  security_group_resolver_name      = var.inbound_security_group_resolver_name
}

module "outbound_resolver" {
  source                            = "../modules/route53-resolver"
  count                             = length(var.dns_forwarding.dns_forwarders) > 0 ? 1 : 0
  subnet_ids_for_resolver_endpoints = var.subnet_ids_for_resolver_endpoints
  security_group_vpc_id             = var.security_group_vpc_id
  resolver_name                     = var.outbound_resolver_name
  resolver_type                     = "OUTBOUND"
  security_group_rule_cidr_blocks   = var.security_group_rule_cidr_blocks
  resolver_tags                     = var.outbound_resolver_tags
  security_group_tags               = var.outbound_security_group_tags
  dns_forwarders                    = var.dns_forwarding.dns_forwarders
  forward_domains                   = var.dns_forwarding.forward_domains
  security_group_resolver_name      = var.outbound_security_group_resolver_name
}

module "consul_data_exports" {
  count           = var.export_data_to_consul ? 1 : 0
  source          = "../modules/consul_data_exports"
  key_value_pairs = local.data_exports
  base_path       = "${var.consul_export_base_path}/dns-resolvers"
}