variable "availability_zones" {
  type        = list(string)
  description = "A list of availability zones for the subnets."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "cloudwatch_flow_log_group_name" {
  type        = string
  description = "The name of the cloudwatch log group."
}

variable "dhcp_options" {
  type = object({
    domain_name          = string
    domain_name_servers  = list(string)
    ntp_servers          = list(string)
    netbios_name_servers = list(string)
    netbios_node_type    = number
  })
  description = "The dhcp options to apply to the VPC."
  default     = null
}

variable "ebs_interface_endpoints" {
  type = bool
  description = "Control deployment of ebs interface endpoints per private subnet in a vpc"
  default = true
}

variable "ec2_interface_endpoints" {
  type = bool
  description = "Control deployment of ec2 interface endpoints per private subnet in a vpc"
  default = true
}

variable "ec2messages_interface_endpoints" {
  type = bool
  description = "Control deployment of ec2messages interface endpoints per private subnet in a vpc"
  default = true
}

variable "enable_nat_gateway" {
  type        = bool
  default     = false
  description = "If set it will enable the nat gateways of the VPC."
}

variable "environment" {
  type        = string
  description = "The environment of the VPC."
}

variable "flow_log_retention_period_in_days" {
  type        = number
  description = "The retention period for a flow log in days, defaults to 1 day."
  default     = 1
}

variable "mesh" {
  type        = bool
  default     = false
  description = "A flag to peer the VPC with all other mesh VPCs."
}

variable "mgn_interface_endpoints" {
  type = bool
  description = "Control deployment of mgn interface endpoints per private subnet in a vpc"
  default = false
}

variable "name" {
  type        = string
  description = "Used as part of the resource names to indicate they are created and used within a specific name."
}

variable "peer_with_all" {
  type        = bool
  default     = false
  description = "A flag to peer the VPC with all other VPCs."
}

variable "prepend_resource_type" {
  type        = bool
  default     = true
  description = "If set it will prepend the resource type on the name of the resource."
}

variable "private_subnet_bits" {
  type        = number
  default     = null
  description = "The number of bits used for the subnet mask."
}

variable "public_subnet_bits" {
  type        = number
  default     = null
  description = "The number of bits used for the subnet mask."
}

variable "private_subnet_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to set on the private subnets"
}

variable "public_subnet_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to set on the public subnets"
}

variable "region" {
  type        = string
  description = "The region that the VPCs will be deployed in."
}

variable "ssm_interface_endpoints" {
  type = bool
  description = "Control deployment of ssm interface endpoints per private subnet in a vpc"
  default = true
}

variable "ssmmessages_interface_endpoints" {
  type = bool
  description = "Control deployment of ssmmessages interface endpoints per private subnet in a vpc"
  default = true
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources."
}

variable "s3_gateway_endpoint" {
  type = bool
  description = "Control deployment of s3 gateway endpoints in a vpc"
  default = true
}

variable "s3_interface_endpoints" {
  type = bool
  description = "Control deployment of s3 interface endpoints per private subnet in a vpc"
  default = false
}
