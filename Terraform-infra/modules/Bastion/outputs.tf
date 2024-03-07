output "bastion_ip" {
  value       = aws_instance.bastion.public_ip
  description = "Public IP address of the Bastion host"
}

output "sg_to_pass_to_db" {
  value = aws_security_group.bastion_sg.id
  description = "Security group to be added to Database security group"
}