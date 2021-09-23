output "resolver_rule_ids" {
  value       = try(module.outbound_resolver[0].resolver_rule_ids, [])
  description = "The IDs of the resolver rules."
}

locals {
  data_exports = [{
    key_name = "resolver-rule-ids"
    value = join(",", try(module.outbound_resolver[0].resolver_rule_ids, []))
  }]
  data_exports_map = { for item in local.data_exports : item.key_name => item }
}