include {
  path = find_in_parent_folders()
}

locals {
  layout                   = read_terragrunt_config("${get_parent_terragrunt_dir()}/layout.hcl").locals
  resolving                = read_terragrunt_config("${get_parent_terragrunt_dir()}/resolving.hcl").locals
  vpcs                     = local.layout.vpcs
  dns_forwarding           = local.resolving.dns_forwarding
}

terraform {
  source = "github.com/schubergphilis/regional-network.git//dns-resolvers-associations?ref=0.1.0"
}

dependency "dns_resolvers" {
  config_path = "../dns-resolvers"
  mock_outputs = {
    resolver_rule_ids = [for rule in local.dns_forwarding.forward_domains: "${rule.rule_name}-id-here"]
  }
}

dependency "vpc_layout" {
  config_path = "../vpc-layout"
  mock_outputs = {
    vpcs_all = [for vpc in local.vpcs: merge(vpc, {"id": "${vpc.name}-id-here"})]
  }
}

inputs = {
  vpc_ids_to_associate = [for vpc in dependency.vpc_layout.outputs.vpcs_all : vpc.id]
  resolver_rule_ids    = dependency.dns_resolvers.outputs.resolver_rule_ids
}
