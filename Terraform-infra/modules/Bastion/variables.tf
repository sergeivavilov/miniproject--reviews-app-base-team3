variable "vpc_id" {
  description = "ID of the VPC where the bastion host will be launched"
}

variable "bastion_allowed_ip" {
  description = "Your home public IP to allow SSH access to the bastion host"
}

variable "bastion_ami" {
  description = "The AMI for the Bastion host"
}

variable "key_name" {
  description = "The key pair name for SSH access to Bastion"
}


variable "subnet_id" {
  description = "The ID of the subnet where the Bastion host will be deployed"
}

variable "my_ip" {
  description = "Ip to allow SSH to bastion"
}



variable "ingress_ports" {
  type = list(number)
  default = [ 22 ]
}


variable "instance_type" {
  type = string 
  
}