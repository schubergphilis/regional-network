locals {
  region_peers      = { for region in var.peer_routing_regions : region => data.consul_keys.region_peer[region].var.attachment-peer if data.consul_keys.region_peer[region].var.attachment-peer != "" }
  development_cidrs = { for region in var.peer_routing_regions : region => split(",", data.consul_keys.development_cidrs[region].var.cidrs) if data.consul_keys.development_cidrs[region].var.cidrs != "" }
  development_route_targets = { for region in var.peer_routing_regions : region => flatten([for data in [local.development_cidrs, local.services_cidrs] : data[region]]) }
  test_cidrs        = { for region in var.peer_routing_regions : region => split(",", data.consul_keys.test_cidrs[region].var.cidrs) if data.consul_keys.test_cidrs[region].var.cidrs != "" }
  test_route_targets = { for region in var.peer_routing_regions : region => flatten([for data in [local.test_cidrs, local.services_cidrs] : data[region]]) }
  acceptance_cidrs  = { for region in var.peer_routing_regions : region => split(",", data.consul_keys.acceptance_cidrs[region].var.cidrs) if data.consul_keys.acceptance_cidrs[region].var.cidrs != "" }
  acceptance_route_targets = { for region in var.peer_routing_regions : region => flatten([for data in [local.acceptance_cidrs, local.services_cidrs] : data[region]]) }
  production_cidrs  = { for region in var.peer_routing_regions : region => split(",", data.consul_keys.production_cidrs[region].var.cidrs) if data.consul_keys.production_cidrs[region].var.cidrs != "" }
  production_route_targets = { for region in var.peer_routing_regions : region => flatten([for data in [local.production_cidrs, local.services_cidrs] : data[region]]) }
  services_cidrs    = { for region in var.peer_routing_regions : region => split(",", data.consul_keys.services_cidrs[region].var.cidrs) if data.consul_keys.services_cidrs[region].var.cidrs != "" }
  services_route_targets  = {for region in var.peer_routing_regions : region => flatten([for data in local.all_environmental_cidrs : data[region]])}
  all_environmental_cidrs = [
    local.development_cidrs,
    local.test_cidrs,
    local.acceptance_cidrs,
    local.production_cidrs,
    local.services_cidrs
  ]

  regional_development_routes = { for region in var.peer_routing_regions : region => { for peer in setproduct(local.development_route_targets[region], toset(var.development_route_table_ids)) :
      format("%s-%s", peer[0], peer[1]) => {
        cidr_block     = peer[0],
        route_table_id = peer[1],
        attachment_id  = local.region_peers[region]
      }
    }
  }
  all_development_routes = merge(toset([for route, route_opts in local.regional_development_routes : route_opts])...)

  regional_test_routes = { for region in var.peer_routing_regions : region => { for peer in setproduct(local.test_route_targets[region], toset(var.test_route_table_ids)) :
      format("%s-%s", peer[0], peer[1]) => {
        cidr_block     = peer[0],
        route_table_id = peer[1],
        attachment_id  = local.region_peers[region]
      }
    }
  }
  all_test_routes = merge(toset([for route, route_opts in local.regional_test_routes : route_opts])...)

  regional_acceptance_routes = { for region in var.peer_routing_regions : region => { for peer in setproduct(local.acceptance_route_targets[region], toset(var.acceptance_route_table_ids)) :
      format("%s-%s", peer[0], peer[1]) => {
        cidr_block     = peer[0],
        route_table_id = peer[1],
        attachment_id  = local.region_peers[region]
      }
    }
  }
  all_acceptance_routes = merge(toset([for route, route_opts in local.regional_acceptance_routes : route_opts])...)

  regional_production_routes = { for region in var.peer_routing_regions : region => { for peer in setproduct(local.production_route_targets[region], toset(var.production_route_table_ids)) :
      format("%s-%s", peer[0], peer[1]) => {
        cidr_block     = peer[0],
        route_table_id = peer[1],
        attachment_id  = local.region_peers[region]
      }
    }
  }
  all_production_routes = merge(toset([for route, route_opts in local.regional_production_routes : route_opts])...)

  regional_services_routes = { for region in var.peer_routing_regions : region => { for peer in setproduct(local.services_route_targets[region], toset(var.services_route_table_ids)) :
      format("%s-%s", peer[0], peer[1]) => {
        cidr_block     = peer[0],
        route_table_id = peer[1],
        attachment_id  = local.region_peers[region]
      }
    }
  }
  all_services_routes = merge(toset([for route, route_opts in local.regional_services_routes : route_opts])...)
  all_routes = merge(local.all_development_routes,
    local.all_test_routes,
    local.all_acceptance_routes,
    local.all_production_routes,
  local.all_services_routes)
}

resource "aws_ec2_transit_gateway_route" "default" {
  for_each                       = local.all_routes
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = each.value.attachment_id
  transit_gateway_route_table_id = each.value.route_table_id
}
