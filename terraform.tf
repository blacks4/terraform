# terraform {
#   backend "s3" {}
# }

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

resource "aws_security_group" "SecurityGroup" {
  name        = "Windows_SecurityGroup"
  description = "Windows_SecurityGroup"
  vpc_id      = "vpc-a64f62c2"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["69.116.3.36/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["69.116.3.36/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Windows_SecurityGroup"
  }
}

resource "aws_instance" "instance1" {
  ami                    = "ami-f6529b8c"
  tenancy                = "default"
  instance_type          = "t2.medium"
  key_name               = "2017_key"
  subnet_id              = "subnet-58578d72"
  vpc_security_group_ids = ["${aws_security_group.SecurityGroup.id}"]
  user_data              = "${file("./user-data.ps1")}"

  tags {
    Name      = "test-instance-windows"
    "creator" = "Steve Tractenberg"
  }
}
