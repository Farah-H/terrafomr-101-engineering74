# this module creates app ec2 instance and starts the node.js app

#Instance EC2
resource "aws_instance" "app_instance" {
  ami = var.app_ami
  instance_type = var.inst_type
  associate_public_ip_address = true

  # placing instance in correct subnet
  subnet_id = aws_subnet.subnet-public.id

  # Attaching correct SG
  security_groups = [var.app_sg_id]

  
  tags = {
  Name = "eng74_farah_app_instance_terraform"
  }

  #security cridentials
  key_name = var.ssh_key

  # SSH into machine to start app
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key =   "${file(var.key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"export DB_HOST=${var.db_private_ip}\" >> /home/ubuntu/.bashrc",
      "export DB_HOST=${var.db_private_ip}",
      "cd app/ && pm2 start app.js",
    ]
  }
}
