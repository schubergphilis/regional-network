variable "consul_base_path" {
  type        = string
  description = "The base path for consul kv lookups"
}

variable "transit_gateway_id" {
  type        = string
  description = "The id of the transit gateway."
}

variable "peer_routing_regions" {
  type        = list(string)
  description = "A list of regions to calculate regional routing for."
}

variable "development_route_table_ids" {
  type        = list(string)
  description = "A list of transit gateway route tables for the development environment."
}

variable "test_route_table_ids" {
  type        = list(string)
  description = "A list of transit gateway route tables for the test environment."
}

variable "acceptance_route_table_ids" {
  type        = list(string)
  description = "A list of transit gateway route tables for the acceptance environment."
}

variable "production_route_table_ids" {
  type        = list(string)
  description = "A list of transit gateway route tables for the production environment."
}

variable "services_route_table_ids" {
  type        = list(string)
  description = "A list of transit gateway route tables for the services environment."
}