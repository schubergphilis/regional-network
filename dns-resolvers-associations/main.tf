resource "aws_route53_resolver_rule_association" "domain_forwarders" {
  for_each = { for pair in setproduct(var.vpc_ids_to_associate, var.resolver_rule_ids):
  "${pair[0]}.${pair[1]}" => {
    vpc_id           = pair[0]
    resolver_rule_id = pair[1]
    }
  }
  resolver_rule_id = each.value.resolver_rule_id
  vpc_id           = each.value.vpc_id
}
