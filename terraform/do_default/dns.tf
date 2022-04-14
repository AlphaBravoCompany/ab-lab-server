# resource "cloudflare_record" "lab_dns" {
#   count  = "${var.digitalocean_server_count}"
#   zone_id = var.cloudflare_zone_id
#   name   = "${element(module.lab-server.*.droplet_name, count.index)}"
#   value  = "${element(module.lab-server.*.droplet_ipv4_address, count.index)}"
#   type   = "A"
#   ttl = 600
#   #depends_on = [module.lab-server]
# }

# resource "cloudflare_record" "lab_dns_wildcard" {
#   count  = "${var.digitalocean_server_count}"
#   zone_id = var.cloudflare_zone_id
#   name   = "*.${element(module.lab-server.*.droplet_name, count.index)}"
#   value  = "${element(module.lab-server.*.droplet_ipv4_address, count.index)}"
#   type   = "A"
#   ttl = 600
# }

############# CLOUDFLARE RECORDS #############
resource "cloudflare_record" "cloudflare_lab_dns" {
  count  = "${var.dns_service == "cloudflare" && var.digitalocean_server_count > 0 ? var.digitalocean_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = "${element(module.lab-server.*.droplet_name, count.index)}"
  value  = "${element(module.lab-server.*.droplet_ipv4_address, count.index)}"
  type   = "A"
  ttl = 600
  depends_on = [module.lab-server]
}

resource "cloudflare_record" "cloudflare_lab_dns_wildcard" {
  count  = "${var.dns_service == "cloudflare" && var.digitalocean_server_count > 0 ? var.digitalocean_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = "*.${element(module.lab-server.*.droplet_name, count.index)}"
  value  = "${element(module.lab-server.*.droplet_ipv4_address, count.index)}"
  type   = "A"
  ttl = 600
  depends_on = [module.lab-server]
}

resource "cloudflare_record" "cloudflare_haproxy_dns" {
  count = "${var.dns_service == "cloudflare" && var.haproxy_server_count > 0 ? var.haproxy_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = "${element(module.haproxy-server.*.droplet_name, count.index)}"
  value  = module.haproxy-server.droplet_ipv4_address
  type   = "A"
  ttl = 600
  depends_on = [module.haproxy-server]
}

resource "cloudflare_record" "cloudflare_code_dns" {
  count  = "${var.dns_service == "cloudflare" && var.digitalocean_server_count > 0 ? var.digitalocean_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = "code-${element(module.lab-server.*.droplet_name, count.index)}"
  value  = module.haproxy-server.droplet_ipv4_address
  type   = "A"
  ttl = 600
  depends_on = [module.haproxy-server]
}

resource "cloudflare_record" "cloudflare_rancher_dns" {
  count  = "${var.dns_service == "cloudflare" && var.digitalocean_server_count > 0 ? var.digitalocean_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = "rancher-${element(module.lab-server.*.droplet_name, count.index)}"
  value  = module.haproxy-server.droplet_ipv4_address
  type   = "A"
  ttl = 600
  depends_on = [module.haproxy-server]
}

resource "cloudflare_record" "cloudflare_portainer_dns" {
  count  = "${var.dns_service == "cloudflare" && var.digitalocean_server_count > 0 ? var.digitalocean_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = "portainer-${element(module.lab-server.*.droplet_name, count.index)}"
  value  = module.haproxy-server.droplet_ipv4_address
  type   = "A"
  ttl = 600
  depends_on = [module.haproxy-server]
}

############# ROUTE53 RECORDS #############
resource "aws_route53_record" "route53_lab_dns" {
  count  = "${var.dns_service == "route53" && var.digitalocean_server_count > 0 ? var.digitalocean_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = "${element(module.lab-server.*.droplet_name, count.index)}"
  records = ["${element(module.lab-server.*.droplet_ipv4_address, count.index)}"]
  type    = "A"
  ttl     = "600"
  depends_on = [module.lab-server]
}

resource "aws_route53_record" "route53_lab_dns_wildcard" {
  count  = "${var.dns_service == "route53" && var.digitalocean_server_count > 0 ? var.digitalocean_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = "*.${element(module.lab-server.*.droplet_name, count.index)}"
  records = ["${element(module.lab-server.*.droplet_ipv4_address, count.index)}"]
  type    = "A"
  ttl     = "600"
  depends_on = [module.lab-server]
}

resource "aws_route53_record" "route53_lab_haproxy_dns" {
  count  = "${var.dns_service == "route53" && var.haproxy_server_count > 0 ? var.haproxy_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = module.haproxy-server.droplet_name
  records = [module.haproxy-server.droplet_ipv4_address]
  type    = "A"
  ttl     = "600"
  depends_on = [module.haproxy-server]
}

resource "aws_route53_record" "route53_code_dns" {
  count  = "${var.dns_service == "route53" && var.digitalocean_server_count > 0 ? var.digitalocean_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = "code-${element(module.lab-server.*.droplet_name, count.index)}"
  records = [module.haproxy-server.droplet_ipv4_address]
  type    = "A"
  ttl     = "600"
  depends_on = [module.haproxy-server]
}

resource "aws_route53_record" "route53_rancher_dns" {
  count  = "${var.dns_service == "route53" && var.digitalocean_server_count > 0 ? var.digitalocean_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = "rancher-${element(module.lab-server.*.droplet_name, count.index)}"
  records = [module.haproxy-server.droplet_ipv4_address]
  type    = "A"
  ttl     = "600"
  depends_on = [module.haproxy-server]
}

resource "aws_route53_record" "portainer_rancher_dns" {
  count  = "${var.dns_service == "route53" && var.digitalocean_server_count > 0 ? var.digitalocean_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = "portainer-${element(module.lab-server.*.droplet_name, count.index)}"
  records = [module.haproxy-server.droplet_ipv4_address]
  type    = "A"
  ttl     = "600"
  depends_on = [module.haproxy-server]
}