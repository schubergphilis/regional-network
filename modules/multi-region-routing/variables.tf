variable "consul_data_lookup" {
  type = bool
  description = "Use consul as a data source to determine routes to deploy."
  default = false
}

variable "transit_gateway_id" {
  type = string
  description = "The id of the transit gateway."
}

variable "peer_regions" {
  type = list(string)
  description = "A list of regions to calculate regional routing for."
}

variable "development_route_tables" {
  type = list(string)
  description = "A list of transit gateway route tables for the development environment."
}

variable "test_route_tables" {
  type = list(string)
  description = "A list of transit gateway route tables for the test environment."
}

variable "acceptance_route_tables" {
  type = list(string)
  description = "A list of transit gateway route tables for the acceptance environment."
}

variable "production_route_tables" {
  type = list(string)
  description = "A list of transit gateway route tables for the production environment."
}

variable "services_route_tables" {
  type = list(string)
  description = "A list of transit gateway route tables for the services environment."
}