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
      key_name = "development/vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "development"])
    },
    {
      key_name = "test/vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "test"])
    },
    {
      key_name = "acceptance/vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "acceptance"])
    },
    {
      key_name = "production/vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "production"])
    },
    {
      key_name = "services/vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "services"])
    },
    {
      key_name = "development/mesh-vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "development" && vpc.mesh == true])
    },
    {
      key_name = "test/mesh-vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "test" && vpc.mesh == true])
    },
    {
      key_name = "acceptance/mesh-vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "acceptance" && vpc.mesh == true])
    },
    {
      key_name = "production/mesh-vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "production" && vpc.mesh == true])
    },
    {
      key_name = "services/mesh-vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "services" && vpc.mesh == true])
    },
    {
      key_name = "development/non-mesh-vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "development" && vpc.mesh == false])
    },
    {
      key_name = "test/non-mesh-vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "test" && vpc.mesh == false])
    },
    {
      key_name = "acceptance/non-mesh-vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "acceptance" && vpc.mesh == false])
    },
    {
      key_name = "production/non-mesh-vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "production" && vpc.mesh == false])
    },
    {
      key_name = "services/non-mesh-vpc-cidrs"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.cidr_block if vpc.environment == "services" && vpc.mesh == false])
    },
    {
      key_name = "development/non-mesh-subnet-share-arn"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.subnet_share_arn if vpc.environment == "development" && vpc.mesh == false])
    },
    {
      key_name = "test/non-mesh-subnet-share-arn"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.subnet_share_arn if vpc.environment == "test" && vpc.mesh == false])
    },
    {
      key_name = "acceptance/non-mesh-subnet-share-arn"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.subnet_share_arn if vpc.environment == "acceptance" && vpc.mesh == false])
    },
    {
      key_name = "production/non-mesh-subnet-share-arn"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.subnet_share_arn if vpc.environment == "production" && vpc.mesh == false])
    },
    {
      key_name = "services/non-mesh-subnet-share-arn"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.subnet_share_arn if vpc.environment == "services" && vpc.mesh == false])
    },
    {
      key_name = "development/mesh-subnet-share-arn"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.subnet_share_arn if vpc.environment == "development" && vpc.mesh == true])
    },
    {
      key_name = "test/mesh-subnet-share-arn"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.subnet_share_arn if vpc.environment == "test" && vpc.mesh == true])
    },
    {
      key_name = "acceptance/mesh-subnet-share-arn"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.subnet_share_arn if vpc.environment == "acceptance" && vpc.mesh == true])
    },
    {
      key_name = "production/mesh-subnet-share-arn"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.subnet_share_arn if vpc.environment == "production" && vpc.mesh == true])
    },
    {
      key_name = "services/mesh-subnet-share-arn"
      value    = join(",", [for vpc in values(module.layout)[*] : vpc.subnet_share_arn if vpc.environment == "services" && vpc.mesh == true])
    },

  ]
  data_exports_map = { for item in local.data_exports : item.key_name => item }
}