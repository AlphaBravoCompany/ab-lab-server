resource "digitalocean_droplet" "droplet" {
    name     = var.droplet_name
    image    = var.droplet_image
    size     = var.droplet_size
    private_networking = true
    region   = var.do_region
    ssh_keys = var.ssh_keys
    tags     = var.droplet_tags
    resize_disk = var.resize_disk
    user_data = file("./cloud-init.yml")
    monitoring = true
    vpc_uuid = var.vpc_uuid
}