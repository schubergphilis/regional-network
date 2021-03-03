variable "dns_forwarders" {
  type        = list(string)
  default     = []
  description = "A list of DNS forwarder IPs to apply."
}

variable "domain_forwarder_tags" {
  type        = map(string)
  default     = {}
  description = "The tags of the domain forwarders."
}

variable "forward_domains" {
  type = list(object({
    name        = string
    rule_name   = string
    description = string
    rule_type   = string
  }))
  default     = []
  description = "A list of forward domains to deploy."
}

variable "forwarder_override_tags" {
  type        = map(string)
  default     = {}
  description = "The tags of the forwarder overrides."
}

variable "resolver_name" {
  type        = string
  default     = ""
  description = "The name for the resolver."
}

variable "resolver_tags" {
  type        = map(string)
  default     = {}
  description = "The tags of the resolver."
}

variable "resolver_type" {
  type        = string
  description = "The type of the resolver."
}


variable "security_group_resolver_name" {
  type        = string
  default     = ""
  description = "The name of the security group resolver."
}

variable "security_group_rule_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "The CIDR blocks for the security group."
}

variable "security_group_tags" {
  type        = map(string)
  default     = {}
  description = "The tags for the security group."
}

variable "security_group_vpc_id" {
  type        = string
  default     = ""
  description = "The VPC ID for the security group."
}

variable "subnet_ids_for_resolver_endpoints" {
  type        = list(string)
  default     = []
  description = "The subnet IDs for the resolver endpoints."
}