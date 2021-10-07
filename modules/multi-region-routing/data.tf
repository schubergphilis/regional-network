data "aws_region" "current" {}

data "consul_keys" "region_peer" {
  for_each = toset(var.peer_regions)
  key {
    name = "attachment-peer"
    path = "${var.consul_base_path}/${data.aws_region.current.id}/external-connectivity/attachment-${each.value}-peer"
  }
}

data "consul_keys" "development_cidrs" {
  for_each = toset(var.peer_regions)
  key {
    name = "cidrs"
    path = "${var.consul_base_path}/${each.value}/vpc-layout/development/all-vpc-cidrs"
  }
}

data "consul_keys" "test_cidrs" {
  for_each = toset(var.peer_regions)
  key {
    name = "cidrs"
    path = "${var.consul_base_path}/${each.value}/vpc-layout/test/all-vpc-cidrs"
  }
}

data "consul_keys" "acceptance_cidrs" {
  for_each = toset(var.peer_regions)
  key {
    name = "cidrs"
    path = "${var.consul_base_path}/${each.value}/vpc-layout/acceptance/all-vpc-cidrs"
  }
}

data "consul_keys" "production_cidrs" {
  for_each = toset(var.peer_regions)
  key {
    name = "cidrs"
    path = "${var.consul_base_path}/${each.value}/vpc-layout/production/all-vpc-cidrs"
  }
}

data "consul_keys" "services_cidrs" {
  for_each = toset(var.peer_regions)
  key {
    name = "cidrs"
    path = "${var.consul_base_path}/${each.value}/vpc-layout/services/all-vpc-cidrs"
  }
}