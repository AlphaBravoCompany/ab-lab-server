resource "cloudflare_record" "lab_dns" {
  count  = var.aws_server_count
  zone_id = var.cloudflare_zone_id
  name   = "${element(aws_spot_instance_request.lab-server.*.tags.Name, count.index)}"
  value  = "${element(aws_spot_instance_request.lab-server.*.public_ip, count.index)}"
  type   = "A"
  ttl = 600
  depends_on = [aws_spot_instance_request.lab-server]
}

resource "cloudflare_record" "lab_dns_wildcard" {
  count  = var.aws_server_count
  zone_id = var.cloudflare_zone_id
  name   = "*.${element(aws_spot_instance_request.lab-server.*.tags.Name, count.index)}"
  value  = "${element(aws_spot_instance_request.lab-server.*.public_ip, count.index)}"
  type   = "A"
  ttl = 600
  depends_on = [aws_spot_instance_request.lab-server]
}