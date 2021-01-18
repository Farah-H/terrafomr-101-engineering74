resource "aws_security_group" "sg_app" {
  name        = "app_sg"
  description = "allows traffic to app"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # increment: make variable for my_ip
    description = "port 22 from my ip"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["2.28.154.108/32"]
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
    cidr_blocks = ["2.28.154.108/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eng74-farah-sg-app-terraform"
  }
}

# using the sg_app_id to make a DB sg
resource "aws_security_group" "sg_db"{
  name = "db_sg"
  description = "allows traffic to DB from app"
  vpc_id = var.vpc_id


  ingress {
    from_port = 27017
    to_port = 27017
    protoccol = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

	egress {
		description = "All traffic out"
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]

	}

  tags = {
    Name = "eng74-farah-terraform-db-sg"
  }
}