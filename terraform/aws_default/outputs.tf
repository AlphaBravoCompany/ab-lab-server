resource "local_file" "k3s_inventory" {
  content  = templatefile("../templates/inventory.tmpl", {
      server_name = aws_instance.lab-server[*].tags.Name,
      lab_server_ips = aws_eip.eip[*].public_ip,
      haproxy_name = aws_instance.haproxy-server.tags.Name,
      haproxy_ip = aws_eip.haproxy-eip.public_ip,
      private_key = "./files/${var.deployment_name}/${var.deployment_name}-private-key.pem",
      ansible_user = var.ansible_aws_user,
      deployment_name = var.deployment_name,
      environment_domain = var.environment_domain
      }
    )
  filename = "../../ansible/inventory/${var.deployment_name}/${var.deployment_name}-inventory"
  depends_on = [aws_instance.lab-server]
}

resource "local_file" "haproxy_config" {
  content  = templatefile("../templates/haproxy.cfg.tmpl", {
      server_name = aws_instance.lab-server[*].tags.Name,
      lab_server_ips = aws_eip.eip[*].public_ip,
      deployment_name = var.deployment_name,
      environment_domain = var.environment_domain
      }
    )
  filename = "../../ansible/files/${var.deployment_name}/haproxy.cfg"
  depends_on = [aws_instance.haproxy-server]
}

resource "local_file" "ansible_all" {
  content  = templatefile("../templates/all.tmpl", {
      deployment_name = var.deployment_name,
      letsencrypt_email = var.letsencrypt_email,
      letsencrypt_environment = var.letsencrypt_environment,
      environment_domain = var.environment_domain,
      addl_admin_user = var.ansible_addl_admin_user,
      ansible_user = var.ansible_aws_user,
      environment_systemd_directory = var.environment_systemd_directory,
      docker_compose_version = var.docker_docker_compose_version,
      git_lab_url = var.git_lab_url,
      git_dotfiles_url = var.git_dotfiles_url,
      code_server_version = var.code_server_version,
      code_server_password = var.code_server_password,
      cloudflare_email = var.cloudflare_email,
      portainer_password = var.portainer_password,
      rancher_password = var.rancher_password
      dns_service = var.dns_service
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

resource "local_file" "aws_config" {
  content  = templatefile("../templates/aws-config.tmpl", {
      aws_access_key_id = var.aws_access_key
      aws_secret_access_key = var.aws_secret_key
      }
    )
  filename = "../../ansible/files/${var.deployment_name}/aws-config"
}

resource "local_file" "lab_server_info" {
  content  = templatefile("../templates/lab-server-info.tmpl", {
      lab_servers = aws_instance.lab-server.*.tags.Name,
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