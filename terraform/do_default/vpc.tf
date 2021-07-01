resource "digitalocean_vpc" "vpc" {
  name     = "${var.deployment_name}-vpc"
  region   = var.digitalocean_region
  ip_range = var.digitalocean_vpc_cidr
}