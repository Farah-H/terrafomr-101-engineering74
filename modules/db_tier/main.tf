# this module creates db ec2 instance 
resource "aws_instance" "db_instance" {
    ami = var.db_ami
    subnet_id = var.private_subnet_id
    instance_type = var.inst_type
    associate_public_ip_address = true
    vpc_security_groups_ids = [var.db_sg_id]
    tags = {
        Name = "eng74-farah-db-instance-terraform"
    }

    key_name = var.ssh_key
}