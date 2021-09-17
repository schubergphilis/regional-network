variable "key_value_pairs" {
  type = list(object({
    key_name  = string
    value     = string
  }))
  description = "List of key value pairs to write to the consul key value store"
}

variable "base_path" {
  type = string
  description = "The consul KV store base path to write values to"
}