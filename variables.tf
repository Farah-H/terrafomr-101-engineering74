# research how to create variables in terraform to use in main.tf
# use the variable instead of hard coding in main.tf

variable "region" {
default = "eu-west-1"
}

#this is leo's app AMI 
variable "app_ami" {
default = "ami-0651ff04b9b983c9f"
}

variable "db_ami" {
# this is my db AMI 
default = "ami-0cdf4cfcf91182fd8"
}

variable "ssh_key" {
default = "eng74.farah.aws.key"
}

variable "key_path" {
default = "~/.ssh/eng74farahawskey.pem"

}

variable "inst_type" {
default = "t2.micro"
}


variable "eng_class_person" {
  default = "eng74_farah_"
}
