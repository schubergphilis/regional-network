variable "enable_nat_gateways" {
  type        = bool
  default     = false
  description = "A flag to enable the nat gateways of the VPCs."
}

variable "flow_log_retention_period_in_days" {
  type        = number
  description = "The retention period for a flow log in days, defaults to 1 day."
  default     = 1
}

variable "prepend_resource_type" {
  type        = bool
  default     = true
  description = "If set it will prepend the resource type on the name of the resource."
}

variable "region" {
  type        = string
  description = "The region that the VPCs will be deployed in."
}

variable "vpcs" {
  type = list(object({
    name                = string
    environment         = string
    availability_zones  = list(string)
    cidr_block          = string
    public_subnet_bits  = number
    private_subnet_bits = number
    private_subnet_tags = map(string)
    public_subnet_tags  = map(string)
    peer_with_all       = bool
    mesh                = bool
    tags                = map(string)
    dhcp_options = object({
      domain_name          = string
      domain_name_servers  = list(string)
      ntp_servers          = list(string)
      netbios_name_servers = list(string)
      netbios_node_type    = number
    })
  }))
  description = "A list of VPC definitions to be deployed."
}


variable "consul_export_base_path" {
  type        = string
  description = "The base path within consul KV store to export data to."
  default     = ""
}

variable "export_data_to_consul" {
  type        = bool
  description = "If set will export all data to consul at specified base path."
  default     = false
}
