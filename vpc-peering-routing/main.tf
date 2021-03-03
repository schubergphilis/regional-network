module "peer_routing" {
  source = "../modules/vpc-peering-routing"
  for_each = var.peering_vpcs
  vpc_pair = each.value
}
