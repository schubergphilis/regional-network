variable "peering_vpcs" {
  type = map(map(object({
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
  tags = map(string) })))
  description = "A map of VPCs pairs to peer."
}