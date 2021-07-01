resource "digitalocean_loadbalancer" "loadbalancer" {
  name        = var.name
  region      = var.region
  vpc_uuid    = var.vpc_uuid

  dynamic "forwarding_rule" {
    iterator = port
    for_each = var.entry_ports
    content {
      entry_port          = port.value
      entry_protocol      = var.entry_protocol
      target_port         = port.value
      target_protocol     = var.target_protocol
    }
  }

    healthcheck {
      port                = var.port
      protocol            = var.protocol
    }

   droplet_tag = var.droplet_tag
}