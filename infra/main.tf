terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "firewall"{
  name  = "cloud-native-firewall"
  description  = "Allow SSH and application traffic"

  ingress {
    description  = "SSH access"
    from_port  = 22
    to_port  = 22
    protocol  = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  ingress {
    description = "Application traffic"
    from_port  = 5000
    to_port  = 5000
    protocol  = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  egress {
    description  = "Allow all outbound traffic"
    from_port  = 0
    to_port  = 0
    protocol  = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }
}


data "aws_ami" "ubuntu"{
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "ec2" {
  ami  = data.aws_ami.ubuntu.id
  instance_type  = "t2.micro"

  key_name  = var.ssh_key_name

  vpc_security_group_ids  = [
    aws_security_group.firewall.id
  ]

  tags  = {
    Name  = "cloud-native-web-server"
  }
}
