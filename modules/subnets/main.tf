# VPC
resource "aws_vpc" "app_vpc" {
  cidr_block       = "12.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "eng74_farah_vpc_terraform"
  }
}

# IGW
resource "aws_internet_gateway" "igw" {
  #reference vpc_id dynamically by:
  # calling the resource,
  # followed by the name of the resource
  # followed by the parameter you want
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "eng74_farah_igw_terraform"
  }
}