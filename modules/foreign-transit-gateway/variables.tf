variable "vpc_with_foreign_routes" {
  type = object({
    id                      = string,
    name                    = string,
    environment             = string,
    availability_zones      = list(string),
    cidr_block              = string,
    peer_with_all           = bool,
    mesh                    = bool,
    cidr_block              = string,
    private_subnet_ids      = list(string)
    private_route_table_ids = list(string)
    foreign_routes          = list(object({
      environment                = string
      foreign_transit_gateway_id = string
      target_cidr_ranges         = list(string)
    }))
#    foreign_transit_gateway_id = string
#    target_cidr_ranges = list(string)
  tags = map(string) })
  description = "A list of all VPC's that are deployed."
}

variable "tags" {
  type = map(string)
  description = "Tags to apply to the resource"
  default = {}
}

