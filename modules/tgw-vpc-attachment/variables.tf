variable "environment" {
  description = "The environment label to use."
  type        = string
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "prepend_resource_type" {
  type        = bool
  default     = true
  description = "If set it will prepend the resource type on the name of the resource."
}

variable "route_table_ids" {
  description = "The IDs of the route tables."
  type        = list(string)
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resources."
}

variable "transit_gateway_id" {
  description = "The ID of the transit gateway."
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets."
  type        = list(string)
}

variable "vpc_id" {
  type        = string
  description = "The IDs VPC to attach."
}