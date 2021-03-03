locals {
  system_overrides = { for domain_record in var.forward_domains : domain_record.name => domain_record if domain_record.rule_type == "SYSTEM" }
  forward_domains  = { for domain_record in var.forward_domains : domain_record.name => domain_record if domain_record.rule_type == "FORWARD" }
}

resource "aws_route53_resolver_endpoint" "default" {
  name      = var.resolver_name
  direction = var.resolver_type

  security_group_ids = [aws_security_group.default.id]
  dynamic "ip_address" {
    for_each = toset(var.subnet_ids_for_resolver_endpoints)
    content {
      subnet_id = ip_address.value
    }
  }
  tags = var.resolver_tags
}

resource "aws_security_group" "default" {
  vpc_id = var.security_group_vpc_id
  name   = var.security_group_resolver_name
  tags   = var.security_group_tags
}

resource "aws_security_group_rule" "default" {
  for_each          = toset(["tcp", "udp"])
  type              = var.resolver_type == "OUTBOUND" ? "egress" : "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = each.value
  security_group_id = aws_security_group.default.id
  cidr_blocks       = var.security_group_rule_cidr_blocks
}

resource "aws_route53_resolver_rule" "domain_forwarders" {
  for_each             = local.forward_domains
  domain_name          = each.value.name
  name                 = each.value.rule_name
  rule_type            = each.value.rule_type
  resolver_endpoint_id = aws_route53_resolver_endpoint.default.id

  dynamic "target_ip" {
    for_each = toset(var.dns_forwarders)
    content {
      ip = target_ip.value
    }
  }
  tags = var.domain_forwarder_tags
}

resource "aws_route53_resolver_rule" "forwarder_overrides" {
  for_each    = local.system_overrides
  domain_name = each.value.name
  name        = each.value.rule_name
  rule_type   = each.value.rule_type
  tags        = var.forwarder_override_tags
}

