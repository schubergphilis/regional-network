variable "prepend_resource_type" {
  type        = bool
  default     = true
  description = "If set it will prepend the resource type on the name of the resource."
}

variable "vpc_pair" {
  type = map(object({
    id                      = string,
    name                    = string,
    environment             = string,
    availability_zones      = list(string),
    cidr_block              = string,
    peer_with_all           = bool,
    mesh                    = bool,
    cidr_block              = string,
    public_route_table_id   = string,
    private_route_table_ids = list(string)
  tags = map(string) }))
  description = "A map of VPC pairs to peer together."
}