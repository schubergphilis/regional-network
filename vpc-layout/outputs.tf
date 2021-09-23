output "configuration" {
  value       = var.vpcs
  description = "The VPCs provided as configuration"
}

output "configured_environments" {
  value       = local.configured_environments
  description = "All the distinct environments configured for the existing VPCs"
}

output "services_vpc" {
  value       = [for vpc in values(module.layout)[*] : vpc if vpc.peer_with_all == true][0]
  description = "All the VPCs created by the vpcs definition that acting as a service VPC with connectivity to all"
}

output "vpcs_all" {
  value       = values(module.layout)[*]
  description = "All the VPCs created by the network definition"
}

output "vpcs_mesh" {
  value       = [for vpc in values(module.layout)[*] : vpc if vpc.mesh == true]
  description = "All the VPCs created by the vpcs definition that are meshed peered"
}

output "vpcs_non_mesh" {
  value       = [for vpc in values(module.layout)[*] : vpc if vpc.mesh == false]
  description = "All the VPCs created by the vpcs definition that are properly segregated"
}

output "vpcs_non_services" {
  value       = [for vpc in values(module.layout)[*] : vpc if vpc.peer_with_all == false]
  description = "All the VPCs created by the vpcs definition that not marked as shared services VPCs"
}

output "vpc_pairs_mesh" {
  value = {
    for pair in
    [for distinct_pair in distinct(
      [for product_pair in setproduct(
        [for vpc in values(module.layout)[*] : vpc if vpc.mesh == true],
        [for vpc in values(module.layout)[*] : vpc if vpc.mesh == true])
      : sort(product_pair[*].id) if product_pair[0].id != product_pair[1].id])
    : [for vpc in values(module.layout)[*] : vpc if contains(distinct_pair, tostring(vpc.id))]]
    : "${pair[0].id}-to-${pair[1].id}" => {
      vpc      = pair[0],
      peer_vpc = pair[1]
    }
  }
}

output "vpc_pairs_same_environment" {
  value = { for pair in
    { for environment in local.configured_environments : environment =>
      [for vpc in values(module.layout)[*] : vpc if vpc.environment == environment]
    if length([for vpc in values(module.layout)[*] : vpc if vpc.environment == environment]) == 2 }
    : "environment-${pair[0].environment}-pair" => {
      vpc      = pair[0],
      peer_vpc = pair[1]
    }
  }
}

output "vpc_pairs_services_to_all" {
  value = { for pair in setproduct(
    [for vpc in values(module.layout)[*] : vpc if vpc.peer_with_all == true],
    [for vpc in values(module.layout)[*] : vpc if vpc.peer_with_all == false])
    : "services-pair-to-${pair[1].name}" => {
      vpc      = pair[0],
      peer_vpc = pair[1]
    }
  }
}

output "vpcs_services" {
  value       = [for vpc in values(module.layout)[*] : vpc if vpc.peer_with_all == true]
  description = "All the VPCs created by the vpcs definition that acting as a service VPC with connectivity to all"
}

locals {
  data_exports = [
    {
      key_name = "development-cidrs"
      value    = join(",", [for vpc in(module.layout)[*] : vpc.cidr_block if vpc.environment == "development"])
    },
    {
      key_name = "test-cidrs"
      value    = join(",", [for vpc in(module.layout)[*] : vpc.cidr_block if vpc.environment == "test"])
    },
    {
      key_name = "acceptance-cidrs"
      value    = join(",", [for vpc in(module.layout)[*] : vpc.cidr_block if vpc.environment == "acceptance"])
    },
    {
      key_name = "production-cidrs"
      value    = join(",", [for vpc in(module.layout)[*] : vpc.cidr_block if vpc.environment == "production"])
    },
    {
      key_name = "services-cidrs"
      value    = join(",", [for vpc in(module.layout)[*] : vpc.cidr_block if vpc.environment == "services"])
    }

  ]
  data_exports_map = { for item in local.data_exports : item.key_name => item }
}