resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.app_vpc.id
  cidr_block = "12.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "eng74_farah_subnet_public_terraform"
  }
}


resource "aws_route_table" "public_rt"{
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "eng74_farah_public_rt_terraform"
  }

}


resource "aws_route_table_association" "public_ra"{
  route_table_id = aws_route_table.public_ra.id
  subnet_id = aws_subnet.public_subnet.id
}



resource "aws_network_acl" "public_nacl" {
  vpc_id      = aws_vpc.app_vpc.id
  subnet_ids = [aws_subnet.public_subnet.id]

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