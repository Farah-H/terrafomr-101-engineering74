resource "aws_subnet" "subnet-public" {
  vpc_id     = var.vpc-terraform-name-id
  cidr_block = "12.0.1.0/24"
  # map_public_ip_on_launch = true

  tags = {
    Name = "${var.eng_class_person}subnet_public_terraform"
  }
}

resource "aws_network_acl" "public_nacl" {
  vpc_id      = var.vpc-terraform-name-id
  subnet_ids = [aws_subnet.subnet-public.id]

  # OUT
  # port 80
  # port 443
  # Ephemeral ports 1024-65575
  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  # IN
  # Port 22
  # Port 80
  # Port 443
  # Ephemeral ports 1024-65575

  tags = {
    Name = "${var.eng_class_person}NACL_app_terraform"
  }
}

resource "aws_route_table" "route_public_table"{
  vpc_id = var.vpc-terraform-name-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gw_id
  }

  tags = {
    Name = "${var.eng_class_person}route_table_terraform"
  }

}

resource "aws_route_table" "route_public_table"{
  vpc_id = var.vpc-terraform-name-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gw_id
  }

  tags = {
    Name = "${var.eng_class_person}route_table_terraform"
  }

}

resource "aws_route_table_association" "route_public_association"{
  route_table_id = aws_route_table.route_public_table.id
  subnet_id = aws_subnet.subnet-public.id
}