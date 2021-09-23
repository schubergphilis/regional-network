variable "dns_forwarding" {
	type = object({
		dns_forwarders = list(string)
		forward_domains = list(object({
			name = string
			rule_name = string
			description = string
			rule_type = string
		}))
	})
	default = {
		dns_forwarders = []
		forward_domains = []}
	description = "The definition of the dns forwarders and the forward domains to apply."
}

variable "enable_inbound_resolvers" {
	type        = bool
	default     = false
	description = "If set it will enable the inbound resolver."
}

variable "inbound_resolver_name" {
	type        = string
	default     = ""
	description = "The name of the inbound resolver."
}

variable "inbound_resolver_tags" {
	type        = map(string)
	default     = {}
	description = "The tags to attach to the inbound resolver."
}

variable "inbound_security_group_resolver_name" {
	type = string
	description = "The name of the inbound resolver security group."
}

variable "inbound_security_group_tags" {
	type        = map(string)
	default     = {}
	description = "The tags to attach to the inbound resolver security group."
}

variable "outbound_resolver_name" {
	type = string
	default = ""
	description = "The name of the outbound resolver."
}

variable "outbound_resolver_tags" {
	type        = map(string)
	default     = {}
	description = "The tags to attach to the outbound resolver."
}

variable "outbound_security_group_resolver_name" {
	type        = string
	description = "The name of the outbound resolver security group."
}

variable "outbound_security_group_tags" {
	type        = map(string)
	default     = {}
	description = "The tags to attach to the outbound resolver security group."
}

variable "security_group_rule_cidr_blocks" {
	type        = list(string)
	default     = []
	description = "The cidr blocks for the security group rule."
}

variable "security_group_vpc_id" {
	type        = string
	description = "The ID of the VPC for the security group."
}

variable "subnet_ids_for_resolver_endpoints" {
	type        = list(string)
	default     = []
	description = "A list of subnet IDs to assign to the resolver endpoints."
}

variable "consul_export_base_path" {
  type = string
  description = "The base path within consul KV store to export data to."
  default = null
}

variable "export_data_to_consul" {
  type = bool
  description = "If set will export all data to consul at specified base path."
  default = false
}