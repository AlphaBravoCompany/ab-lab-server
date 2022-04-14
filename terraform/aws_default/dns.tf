############# CLOUDFLARE RECORDS #############
resource "cloudflare_record" "cloudflare_lab_dns" {
  count  = "${var.dns_service == "cloudflare" && var.aws_server_count > 0 ? var.aws_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = "${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  value  = "${element(aws_eip.eip.*.public_ip, count.index)}"
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.lab-server]
}

resource "cloudflare_record" "cloudflare_lab_dns_wildcard" {
  count  = "${var.dns_service == "cloudflare" && var.aws_server_count > 0 ? var.aws_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = "*.${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  value  = "${element(aws_eip.eip.*.public_ip, count.index)}"
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.lab-server]
}

resource "cloudflare_record" "cloudflare_haproxy_dns" {
  count = "${var.dns_service == "cloudflare" && var.haproxy_server_count > 0 ? var.haproxy_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = aws_instance.haproxy-server.tags.Name
  value  = aws_eip.haproxy-eip.public_ip
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.haproxy-server]
}

resource "cloudflare_record" "cloudflare_code_dns" {
  count  = "${var.dns_service == "cloudflare" && var.aws_server_count > 0 ? var.aws_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = "code-${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  value  = aws_eip.haproxy-eip.public_ip
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.haproxy-server]
}

resource "cloudflare_record" "cloudflare_rancher_dns" {
  count  = "${var.dns_service == "cloudflare" && var.aws_server_count > 0 ? var.aws_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = "rancher-${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  value  = aws_eip.haproxy-eip.public_ip
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.haproxy-server]
}

resource "cloudflare_record" "cloudflare_portainer_dns" {
  count  = "${var.dns_service == "cloudflare" && var.aws_server_count > 0 ? var.aws_server_count:0}"
  zone_id = var.cloudflare_zone_id
  name   = "portainer-${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  value  = aws_eip.haproxy-eip.public_ip
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.haproxy-server]
}

############# ROUTE53 RECORDS #############
resource "aws_route53_record" "route53_lab_dns" {
  count  = "${var.dns_service == "route53" && var.aws_server_count > 0 ? var.aws_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = "${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  records = ["${element(aws_eip.eip.*.public_ip, count.index)}"]
  type    = "A"
  ttl     = "600"
  depends_on = [aws_instance.lab-server]
}

resource "aws_route53_record" "route53_lab_dns_wildcard" {
  count  = "${var.dns_service == "route53" && var.aws_server_count > 0 ? var.aws_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = "*.${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  records = ["${element(aws_eip.eip.*.public_ip, count.index)}"]
  type    = "A"
  ttl     = "600"
  depends_on = [aws_instance.lab-server]
}

resource "aws_route53_record" "route53_lab_haproxy_dns" {
  count  = "${var.dns_service == "route53" && var.haproxy_server_count > 0 ? var.haproxy_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = aws_instance.haproxy-server.tags.Name
  records = [aws_eip.haproxy-eip.public_ip]
  type    = "A"
  ttl     = "600"
  depends_on = [aws_instance.haproxy-server]
}

resource "aws_route53_record" "route53_code_dns" {
  count  = "${var.dns_service == "route53" && var.aws_server_count > 0 ? var.aws_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = "code-${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  records = [aws_eip.haproxy-eip.public_ip]
  type    = "A"
  ttl     = "600"
  depends_on = [aws_instance.haproxy-server]
}

resource "aws_route53_record" "route53_rancher_dns" {
  count  = "${var.dns_service == "route53" && var.aws_server_count > 0 ? var.aws_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = "rancher-${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  records = [aws_eip.haproxy-eip.public_ip]
  type    = "A"
  ttl     = "600"
  depends_on = [aws_instance.haproxy-server]
}

resource "aws_route53_record" "portainer_rancher_dns" {
  count  = "${var.dns_service == "route53" && var.aws_server_count > 0 ? var.aws_server_count:0}"
  zone_id = var.aws_route53_zone_id
  name    = "portainer-${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  records = [aws_eip.haproxy-eip.public_ip]
  type    = "A"
  ttl     = "600"
  depends_on = [aws_instance.haproxy-server]
}