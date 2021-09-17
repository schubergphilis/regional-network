resource "consul_keys" "default" {
  for_each = var.key_value_pairs
  key {
    path   = "${var.base_path}/${each.key}"
    value  = each.value
    delete = true
  }
}