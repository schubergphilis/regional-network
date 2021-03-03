locals {
  enable_inbound_resolvers = true
  dns_forwarding = {
    dns_forwarders = []
    forward_domains = [
      {
        name        = ".example.domain.com",
        rule_name   = "example-rule-name",
        description = "This forwards the domain specified to the dns forwarders deployed.",
        rule_type   = "FORWARD"
      },
      {
        name        = "amazonaws.com",
        rule_name   = "override-amazonaws",
        description = "This overrides the forwarding rules for this domain.",
        rule_type   = "SYSTEM",
      }
    ]
  }
}
