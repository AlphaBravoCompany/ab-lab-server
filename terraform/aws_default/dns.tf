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