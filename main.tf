variable "name" {
  type    = "string"
}

variable "vpc_id" {
  type = "string"
  default = "vpc-58a29221"
}

variable "region" {
  default = "us-east-1"
  type = "string"
}

// Resolve existing network resources - START

data "aws_vpc" "default_vpc" {
  id = "${var.vpc_id}"
}

data "aws_subnet_ids" "default_vpc" {
  vpc_id = "${var.vpc_id}"
}

// Resolve existing network resources - END


// Create Firewall Rules to Permit Access - START

resource "aws_security_group" "public_web" {
  name        = "public-web-${var.name}"
  description = "Permits http and https access from the public Internet"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "public_web_ingress_4433" {
  from_port = 4433
  protocol = "tcp"
  security_group_id = "${aws_security_group.public_web.id}"
  to_port = 443
  type = "ingress"
}

resource "aws_security_group" "public_ssh" {
  name        = "public-ssh-${var.name}"
  description = "Permit ssh access from the public Internet"
  vpc_id      = "${var.vpc_id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internal_web" {
  name        = "internal-web-${var.name}"
  description = "Permits http access from the sources in the VPC"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.default_vpc.cidr_block}"]
    #cidr_blocks = ["172.31.0.0/16"]
  }
}

resource "aws_security_group" "outbound" {
  name        = "outbound-${var.name}"
  description = " permits access from the VPC to the Internet"
  vpc_id      = "${var.vpc_id}"

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Create Firewall Rules to Permit Access - END
