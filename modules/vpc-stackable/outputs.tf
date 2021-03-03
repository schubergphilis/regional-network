output "availability_zones" {
  value       = var.availability_zones
  description = "The availability zones provided."
}

output "environment" {
  value       = var.environment
  description = "The environment set for the VPC."
}

output "cidr_block" {
  value       = module.vpc.cidr_block
  description = "CIDR block of the VPC."
}

output "id" {
  value       = module.vpc.id
  description = "ID of the VPC."
}

output "igw_id" {
  value       = module.vpc.igw_id
  description = "ID of the Internet Gateway."
}

output "name" {
  value       = module.vpc.name
  description = "The name provided for the VPC."
}

output "nat_gateway_ids" {
  value       = module.vpc.nat_gateway_ids
  description = "IDs of the NAT gateways."
}

output "lambda_route_table_ids" {
  value       = module.vpc.lambda_route_table_ids
  description = "IDs of the Lambda route tables."
}

output "lambda_subnet_arns" {
  value       = module.vpc.lambda_subnet_arns
  description = "ARNs of the Lambda subnets."
}

output "lambda_subnet_cidr_blocks" {
  value       = module.vpc.lambda_subnet_cidr_blocks
  description = "CIDR blocks of the Lambda subnets."
}

output "lambda_subnet_ids" {
  value       = module.vpc.lambda_subnet_ids
  description = "IDs of the Lambda subnets."
}

output "mesh" {
  value       = var.mesh
  description = "If set the VPC will be peered with all other VPCs set as part of a full mesh network."
}

output "peer_with_all" {
  value       = var.peer_with_all
  description = "If set the VPC will be peered with all other existing VPCs."
}

output "private_subnet_arns" {
  value       = module.vpc.private_subnet_arns
  description = "ARNs of the private subnets."
}

output "private_subnet_cidr_blocks" {
  value       = module.vpc.private_subnet_cidr_blocks
  description = "CIDR blocks of the private subnets."
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "IDs of the private subnets."
}

output "private_route_table_ids" {
  value       = module.vpc.private_route_table_ids
  description = "IDs of the private route tables."
}

output "public_subnet_arns" {
  value       = module.vpc.public_subnet_arns
  description = "ARNs of the public subnets."
}

output "public_subnet_cidr_blocks" {
  value       = module.vpc.public_subnet_cidr_blocks
  description = "CIDR blocks of the public subnets."
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "IDs of the public subnets."
}

output "public_route_table_id" {
  value       = try(module.vpc.public_route_table_id, null)
  description = "ID of the public route table."
}

output "subnet_share_arn" {
  value       = try(module.vpc.subnet_share_arn, null)
  description = "The ARN of the subnet share in resource access manager if any."
}

output "subnet_share_id" {
  value       = try(module.vpc.subnet_share_id, null)
  description = "The ID of the subnet share in resource access manager if any."
}

output "tags" {
  value       = var.tags
  description = "The tags provided."
}

output "vpc" {
  value       = module.vpc
  description = "The deployed VPC."
}