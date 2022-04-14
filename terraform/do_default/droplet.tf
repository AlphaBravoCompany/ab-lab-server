resource "digitalocean_tag" "lab-server" {
  name = "${var.deployment_name}-lab"
}

resource "tls_private_key" "lab_server_key" {
  algorithm   = "RSA"
  rsa_bits = "4096"
}

resource "digitalocean_ssh_key" "lab_server_ssh_keys" {
  name       = "${var.deployment_name}-ssh-key"
  public_key = tls_private_key.lab_server_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "../../ansible/files/${var.deployment_name}/${var.deployment_name}-private-key.pem"
  content = tls_private_key.lab_server_key.private_key_pem
  file_permission = "0600"
}

# Lab Environment Deployment.
module "haproxy-server" {
    source = "../../modules/terraform/do/droplet"

    droplet_name       = "${var.deployment_name}-haproxy"
    droplet_image      = var.digitalocean_droplet_image
    droplet_size       = var.digitalocean_lab_droplet_size
    do_region          = var.digitalocean_region
    ssh_keys           = concat("${var.digitalocean_ssh_key}", ["${digitalocean_ssh_key.lab_server_ssh_keys.fingerprint}"])
    resize_disk        = false
    droplet_tags       = [digitalocean_tag.lab-server.id]
    vpc_uuid           = digitalocean_vpc.vpc.id
}


module "lab-server" {
    source = "../../modules/terraform/do/droplet"
    count  = var.digitalocean_server_count #This should be at least equal to number of students in the class

    droplet_name       = "${var.deployment_name}-lab${count.index + 1}"
    droplet_image      = var.digitalocean_droplet_image
    droplet_size       = var.digitalocean_lab_droplet_size
    do_region          = var.digitalocean_region
    ssh_keys           = concat("${var.digitalocean_ssh_key}", ["${digitalocean_ssh_key.lab_server_ssh_keys.fingerprint}"])
    resize_disk        = false
    droplet_tags       = [digitalocean_tag.lab-server.id]
    vpc_uuid           = digitalocean_vpc.vpc.id
}
