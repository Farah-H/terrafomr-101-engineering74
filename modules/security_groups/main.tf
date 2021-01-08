resource "aws_security_group" "sg_app" {
  name        = "public_sg_for_app_Filipe"
  description = "allows traffic to app"
  vpc_id      = var.vpc-terraform-name-id

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 22 from my ip"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["85.240.168.69/32"]
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
    cidr_blocks = ["85.240.168.69/32"]
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

# using the sg_app_id to make a DB sg
resource {
  name = "db_sg_for_app_farah"
  description = "allows traffic to DB from app"
  vpc_id = aws_vpc.vpc-terraform-name.id


  ingress {
    from_port = 27017
    to_port = 27017
    protoccol = "tcp"
    security_groups = [module.app.security_groups]
  }
}