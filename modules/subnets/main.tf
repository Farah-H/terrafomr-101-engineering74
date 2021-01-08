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