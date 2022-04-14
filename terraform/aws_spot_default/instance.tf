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
  instance = "${element(aws_spot_instance_request.lab-server.*.spot_instance_id, count.index)}"
  count    = var.aws_server_count
  vpc      = true
}

resource "aws_eip" "haproxy-eip" {
  instance = aws_instance.haproxy-server.id
  vpc      = true
}

resource "aws_instance" "haproxy-server" {
  ami           = var.aws_instance_image
  instance_type = "m5a.large"
  key_name = aws_key_pair.lab_server_key.key_name
  subnet_id = "${aws_subnet.public.id}"
  associate_public_ip_address = true
  #user_data = "${file("../templates/userdata.tpl")}"
  root_block_device {
    volume_size = "100"
  }

  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  tags = {
    Name = "${var.deployment_name}-haproxy"
  }
}

resource "aws_spot_instance_request" "lab-server" {
  wait_for_fulfillment = true
  count         = var.aws_server_count
  ami           = var.aws_instance_image
  spot_price    = var.aws_spot_price
  instance_type = var.aws_lab_instance_size
  instance_interruption_behavior = "stop"
  key_name = aws_key_pair.lab_server_key.key_name
  subnet_id = "${aws_subnet.public.id}"
  associate_public_ip_address = true
  root_block_device {
    volume_size = "100"
  }

  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  provisioner "local-exec" {
    command = "AWS_ACCESS_KEY_ID=${var.aws_access_key} AWS_SECRET_ACCESS_KEY=${var.aws_secret_key} aws ec2 create-tags --resources ${self.spot_instance_id} --tags Key=Name,Value=${var.deployment_name}-lab${count.index + 1} --region ${var.aws_region}"
  }

  tags = {
    Name = "${var.deployment_name}-lab${count.index + 1}"
  }
}