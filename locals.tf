locals {
  default_dns_prefix = format("dns-%s", substr(replace(var.name, "/[^(a-z)+(A-Z)+(\\d)]/", ""), 0, 41))
}
