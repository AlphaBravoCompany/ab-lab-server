# https://github.com/syntaqx/terraform-digitalocean-firewall

resource "digitalocean_firewall" "firewall" {
  name        = var.name
  tags        = length(var.tags) > 0 ? var.tags : null
  droplet_ids = length(var.droplet_ids) > 0 ? var.droplet_ids : null

  dynamic "inbound_rule" {
    for_each = var.inbound_rules
    iterator = r
    content {
      protocol                  = lookup(r.value, "protocol", null)
      port_range                = lookup(r.value, "port_range", null)
      source_addresses          = lookup(r.value, "source_addresses", null)
      source_droplet_ids        = lookup(r.value, "source_droplet_ids", null)
      source_tags               = lookup(r.value, "source_tags", null)
      source_load_balancer_uids = lookup(r.value, "source_load_balancer_uids", null)
    }
  }

  dynamic "outbound_rule" {
    for_each = var.outbound_rules
    iterator = r
    content {
      protocol                       = lookup(r.value, "protocol", null)
      port_range                     = lookup(r.value, "port_range", null)
      destination_addresses          = lookup(r.value, "destination_addresses", null)
      destination_droplet_ids        = lookup(r.value, "destination_droplet_ids", null)
      destination_tags               = lookup(r.value, "destination_tags", null)
      destination_load_balancer_uids = lookup(r.value, "destination_load_balancer_uids", null)
    }
  }
}