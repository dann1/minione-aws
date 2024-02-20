resource "aws_instance" "minione" {
  tags = {
    Name = "minione"
  }
  instance_type = var.instance_type
  ami           = var.ami_id
  root_block_device {
    volume_size = var.volume_size
  }

  subnet_id = var.subnet_id
  key_name = var.ssh_key
  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = file(var.ssh_key_path)
    host        = self.public_dns
  }

  # install minione
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y ca-certificates",
      "wget -O minione 'https://github.com/OpenNebula/minione/releases/latest/download/minione'",
      "chmod +x minione",
      "sudo ./minione ${var.one_ee} --password ${var.one_password} --yes --force --sunstone-port ${var.one_sunstone_port} --version ${var.one_version}"
    ]
  }

  # install one-apps and dependencies to build Linux based appliances
  provisioner "remote-exec" {
    inline = [
      "git clone https://github.com/OpenNebula/one-apps.git",
      "sudo apt install -y ${var.one-apps-deps-deb}",
      "wget https://releases.hashicorp.com/packer/${var.packer-version}/packer_${var.packer-version}_linux_amd64.zip",
      "unzip ${var.packer-version}/packer_${var.packer-version}_linux_amd64.zip /usr/local/bin/packer",
      "gem install --no-document backports fpm"
    ]
  }
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS"
    from_port   = var.one_fireedge_port
    to_port     = var.one_fireedge_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = var.one_sunstone_port
    to_port     = var.one_sunstone_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
