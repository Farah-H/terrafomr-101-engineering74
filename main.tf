module myip {
 source  = "4ops/myip/http"
 version = "1.0.0"
}

provider "aws" {
 region = var.region
}

module "vpc" {
  source = "./modules/subnets"
  my_ip = module.my_ip.address
}

# call the app module
module "app" {
  source = "./modules/app_tier"
  vpc-terraform-name-id = aws_vpc.vpc-terraform-name.id
  eng_class_person = var.eng_class_person
  gw_id = aws_internet_gateway.gw.id
  nodejs_app = var.nodejs_app
  ssh_key = var.ssh_key
}


# Monitor
# Decide trigger
# ask it to scale out
# replicate ec2 withing public subnet
# Load balancer to distribute traffic to new ec2
# We will use built in tools from AWS
