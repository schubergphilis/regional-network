locals {
  key_value_pairs_map = {for item in var.key_value_pairs: item.key_name => item}
}

resource "consul_keys" "default" {
  for_each = local.key_value_pairs_map
  key {
    path   = "${var.base_path}/${each.value.key_name}"
    value  = each.value.value
    delete = true
  }
}