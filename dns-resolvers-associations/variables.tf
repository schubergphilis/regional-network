variable "vpc_ids_to_associate" {
	type = list(string)
	default = []
	description = "The IDs of the VPCs to associate with the resolving rules."
}

variable "resolver_rule_ids" {
	type = list(string)
	default = []
	description = "The IDs of the resolving rules to associate with the VPCs."
}
