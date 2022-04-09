resource "cloudflare_record" "lab_dns" {
  count  = var.aws_server_count
  zone_id = var.cloudflare_zone_id
  name   = "${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  value  = "${element(aws_eip.eip.*.public_ip, count.index)}"
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.lab-server]
}

resource "cloudflare_record" "lab_dns_wildcard" {
  count  = var.aws_server_count
  zone_id = var.cloudflare_zone_id
  name   = "*.${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  value  = "${element(aws_eip.eip.*.public_ip, count.index)}"
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.lab-server]
}

resource "cloudflare_record" "haproxy_dns" {
  zone_id = var.cloudflare_zone_id
  name   = aws_instance.haproxy-server.tags.Name
  value  = aws_eip.haproxy-eip.public_ip
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.haproxy-server]
}

resource "cloudflare_record" "code_dns" {
  count  = var.aws_server_count
  zone_id = var.cloudflare_zone_id
  name   = "code.${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  value  = aws_eip.haproxy-eip.public_ip
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.haproxy-server]
}

resource "cloudflare_record" "rancher_dns" {
  count  = var.aws_server_count
  zone_id = var.cloudflare_zone_id
  name   = "rancher.${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  value  = aws_eip.haproxy-eip.public_ip
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.haproxy-server]
}

resource "cloudflare_record" "portainer_dns" {
  count  = var.aws_server_count
  zone_id = var.cloudflare_zone_id
  name   = "portainer.${element(aws_instance.lab-server.*.tags.Name, count.index)}"
  value  = aws_eip.haproxy-eip.public_ip
  type   = "A"
  ttl = 600
  depends_on = [aws_instance.haproxy-server]
}