module myip {
  source  = "4ops/myip/http"
  version = "1.0.0"
}

provider "aws" {

 region = "eu-west-1"
#access_key = "must not write the key here"
#secert_key = "must not write the key here"
}

#Instance EC"
resource "aws_instance" "nodejs_instance" {
  ami = var.nodejs_app
  instance_type = "t2.micro"
  associate_public_ip_address = true
  tags = {
  Name = "Filipe_eng74_webapp_terraform"
  }
  key_name = var.ssh_key
}


# Create a VPC
resource "aws_vpc" "vpc-terraform-name" {
  cidr_block       = "12.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${var.eng_class_person}vpc_terraform"
  }
}

# IGW
resource "aws_internet_gateway" "gw" {
  #reference vpc_id dynamically by:
  # calling the resource,
  # followed by the name of the resource
  # followed by the parameter you want
  vpc_id = aws_vpc.vpc-terraform-name.id

  tags = {
    Name = "${var.eng_class_person}igw_terraform"
  }
}

# Create a public subnet

resource "aws_subnet" "subnet-public" {
  vpc_id     = aws_vpc.vpc-terraform-name.id
  cidr_block = "12.0.1.0/24"
  # map_public_ip_on_launch = true

  tags = {
    Name = "${var.eng_class_person}subnet_public_terraform"
  }
}

# Create a SG

resource "aws_security_group" "sg_app" {
  name        = "public_sg_for_app_Filipe"
  description = "allows traffic to app"
  vpc_id      = aws_vpc.vpc-terraform-name.id

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Port 3000 for my ip"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["${module.myip.address}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.eng_class_person}sg_app_terraform"
  }
}


# NCLS. --- Task 1


# move the app into the subnet ad try to get tge 502 error on port 80


# ROUTES





