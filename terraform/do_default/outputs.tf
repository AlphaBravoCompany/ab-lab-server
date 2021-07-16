output "lab_server_name" {
    value = module.lab-server[*].droplet_name
}

output "lab_server_public_ips" {
    value = module.lab-server[*].droplet_ipv4_address
}

output "lab_server_private_ips" {
    value = module.lab-server[*].droplet_ipv4_address_private
}

output "vpc_uuid" {
    value = digitalocean_vpc.vpc.id
}

resource "local_file" "k3s_inventory" {
  content  = templatefile("../templates/inventory.tmpl", {
      server_name = module.lab-server[*].droplet_name,
      lab_server_ips = module.lab-server[*].droplet_ipv4_address,
      private_key = var.digitalocean_ssh_path,
      ansible_user = var.ansible_do_user,
      deployment_name = var.deployment_name,
      private_key = var.digitalocean_ssh_path
      environment_domain = var.environment_domain
      }
    )
  filename = "../../ansible/inventory/${var.deployment_name}/${var.deployment_name}-inventory"
}

resource "local_file" "ansible_all" {
  content  = templatefile("../templates/all.tmpl", {
      deployment_name = var.deployment_name,
      letsencrypt_email = var.letsencrypt_email,
      letsencrypt_environment = var.letsencrypt_environment,
      environment_domain = var.environment_domain,
      addl_admin_user = var.ansible_addl_admin_user,
      ansible_user = var.ansible_do_user,
      environment_systemd_directory = var.environment_systemd_directory,
      docker_compose_version = var.docker_docker_compose_version,
      git_lab_url = var.git_lab_url,
      git_dotfiles_url = var.git_dotfiles_url,
      code_server_version = var.code_server_version,
      code_server_password = var.code_server_password,
      cloudflare_email = var.cloudflare_email,
      portainer_password = var.portainer_password
      rancher_password = var.rancher_password
      }
    )
  filename = "../../ansible/inventory/${var.deployment_name}/group_vars/all.yml"
}

resource "local_file" "ansible_config" {
  content  = templatefile("../templates/ansible.cfg.tmpl", {
      deployment_name = var.deployment_name
      }
    )
  filename = "../../ansible/ansible.cfg"
}

resource "local_file" "cloudflare_ini" {
  content  = templatefile("../templates/cloudflare.ini.tmpl", {
      cloudflare_email = var.cloudflare_email
      cloudflare_api_token = var.cloudflare_api_token
      }
    )
  filename = "../../ansible/files/${var.deployment_name}/cloudflare.ini"
}

resource "local_file" "lab_server_info" {
  content  = templatefile("../templates/lab-server-info.tmpl", {
      lab_servers = module.lab-server[*].droplet_name,
      environment_domain = var.environment_domain,
      deployment_name = var.deployment_name,
      addl_admin_user = var.ansible_addl_admin_user
      }
    )
  filename = "../../ansible/files/${var.deployment_name}/lab-server-info.txt"
}

resource "local_file" "portainer-password" {
  content  = templatefile("../templates/portainer-password.tmpl", {
      portainer_password = var.portainer_password
      }
    )
  filename = "../../ansible/files/${var.deployment_name}/portainer-password.txt"
}