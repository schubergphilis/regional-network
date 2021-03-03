include {
  path = find_in_parent_folders()
}

locals {
  layout        = read_terragrunt_config("${get_parent_terragrunt_dir()}/layout.hcl").locals
  connectivity  = read_terragrunt_config("${get_parent_terragrunt_dir()}/connectivity.hcl").locals
}

terraform {
  source = "github.com/schubergphilis/regional-network.git//vpc-layout?ref=0.1.0"
}

inputs = {
  vpcs                              = local.layout.vpcs
  region                            = local.layout.region
  flow_log_retention_period_in_days = local.layout.flow_log_retention_period_in_days
  enable_nat_gateways               = try(local.connectivity.egress_vpc, null) != null ? false : true
}
