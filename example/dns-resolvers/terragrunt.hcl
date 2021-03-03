include {
  path = find_in_parent_folders()
}

locals {
  layout                   = read_terragrunt_config("${get_parent_terragrunt_dir()}/layout.hcl").locals
  resolving                = read_terragrunt_config("${get_parent_terragrunt_dir()}/resolving.hcl").locals
  availability_zones       = local.layout.availability_zones
  vpcs                     = local.layout.vpcs
  enable_inbound_resolvers = local.resolving.enable_inbound_resolvers
  dns_forwarding           = local.resolving.dns_forwarding
}

terraform {
  source = "github.com/schubergphilis/regional-network.git//dns-resolvers?ref=0.1.0"
}

dependency "vpc_layout" {
  config_path = "../vpc-layout"
  mock_outputs = {
    services_vpc = {
      private_subnet_ids = [for az in local.availability_zones : "subnet-id-${az}-here"]
      id                 = "service-vpc-id-here"
    }
    vpcs_all = [for vpc in local.vpcs: merge(vpc, {"id": "${vpc.name}-vpc-id-here"})]
  }
}

inputs = {
  dns_forwarding                        = local.dns_forwarding
  enable_inbound_resolvers              = local.enable_inbound_resolvers
  inbound_resolver_name                 = "services-inbound-resolver"
  inbound_resolver_tags                 = { Name = "r53-inbound-resolver" }
  inbound_security_group_resolver_name  = "sgp-r53-inbound-resolver"
  inbound_security_group_tags           = { Name = "sgp-r53-inbound-resolver" }
  outbound_resolver_name                = "services-outbound-resolver"
  outbound_resolver_tags                = { Name = "r53-outbound-resolver" }
  outbound_security_group_resolver_name = "sgp-r53-outbound-resolver"
  outbound_security_group_tags          = { Name = "sgp-r53-outbound-resolver" }
  security_group_rule_cidr_blocks       = [for vpc in local.vpcs : vpc.cidr_block]
  security_group_vpc_id                 = dependency.vpc_layout.outputs.services_vpc.id
  subnet_ids_for_resolver_endpoints     = dependency.vpc_layout.outputs.services_vpc.private_subnet_ids
}
