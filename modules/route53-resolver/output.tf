output "resolver_rule_ids" {
  value = concat(
    values(aws_route53_resolver_rule.domain_forwarders)[*].id,
  values(aws_route53_resolver_rule.forwarder_overrides)[*].id)
  description = "The IDs of the resolver rules created."
}
