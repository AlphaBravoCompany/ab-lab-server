resource "cloudflare_record" "lab_dns" {
  count  = "${var.digitalocean_server_count}"
  zone_id = var.cloudflare_zone_id
  name   = "${element(module.lab-server.*.droplet_name, count.index)}"
  value  = "${element(module.lab-server.*.droplet_ipv4_address, count.index)}"
  type   = "A"
  ttl = 600
}

resource "cloudflare_record" "lab_dns_wildcard" {
  count  = "${var.digitalocean_server_count}"
  zone_id = var.cloudflare_zone_id
  name   = "*.${element(module.lab-server.*.droplet_name, count.index)}"
  value  = "${element(module.lab-server.*.droplet_ipv4_address, count.index)}"
  type   = "A"
  ttl = 600
}