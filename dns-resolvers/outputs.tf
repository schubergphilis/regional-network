output "resolver_rule_ids" {
  value       = try(module.outbound_resolver[0].resolver_rule_ids, [])
  description = "The IDs of the resolver rules."
}
