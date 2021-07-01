output "droplet_name" {
  value = digitalocean_droplet.droplet.name
}

output "droplet_ipv4_address" {
  value = digitalocean_droplet.droplet.ipv4_address
}

output "droplet_ipv4_address_private" {
    value = digitalocean_droplet.droplet.ipv4_address_private
}

output "droplet_id" {
    value = digitalocean_droplet.droplet.id
}