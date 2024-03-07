# provider "aws" {
#   region = "us-west-2" # Use your AWS region
# }

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-security-group"
  description = "Security group for Bastion host allowing SSH access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.ingress_ports[0]    #22
    to_port     = var.ingress_ports[0] #22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami                    = var.bastion_ami
  instance_type          = var.instance_type      
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "BastionHost"
  }
}

