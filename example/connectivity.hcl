locals {
  layout                = read_terragrunt_config("${get_parent_terragrunt_dir()}/layout.hcl").locals
  egress_vpc = {
    cidr_block          = "10.20.128.0/17",
    name                = "egress",
    environment         = "egress",
    availability_zones  = local.layout.availability_zones,
    public_subnet_bits  = 27
    private_subnet_bits = 27
    tags                = {}
  }
}
