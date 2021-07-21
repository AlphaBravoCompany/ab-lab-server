resource "tls_private_key" "lab_server_key" {
  algorithm   = "RSA"
  rsa_bits = "4096"
}

resource "aws_key_pair" "lab_server_key" {
  key_name   = "${var.deployment_name}-ssh-key"
  public_key = tls_private_key.lab_server_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "../../ansible/files/${var.deployment_name}/${var.deployment_name}-private-key.pem"
  content = tls_private_key.lab_server_key.private_key_pem
  file_permission = "0600"
}

resource "aws_eip" "eip" {
  instance = "${element(aws_instance.lab-server.*.id, count.index)}"
  count    = var.aws_server_count
  vpc      = true
}


# Lab Environment Deployment.
resource "aws_instance" "lab-server" {
  count         = var.aws_server_count
  ami           = var.aws_instance_image
  instance_type = var.aws_lab_instance_size
  key_name = aws_key_pair.lab_server_key.key_name
  subnet_id = "${aws_subnet.public.id}"
  associate_public_ip_address = true
  root_block_device {
    volume_size = "100"
  }

  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  tags = {
    Name = "${var.deployment_name}-lab${count.index + 1}"
  }
}