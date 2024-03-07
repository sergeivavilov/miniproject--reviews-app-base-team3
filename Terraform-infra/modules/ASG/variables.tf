# ASG Variables
variable "frontend_ami" {}
variable "frontend_tg_arn" {}
variable "subnets" {}
variable "backend_ami" {}
variable "secrets_permission" {}
variable "backend_tg_arn" {}
variable "vpc_id"{}
variable "frontend_asg_name"{}
variable "backend_asg_name"{}
#variable "frontend_asg_sg"{}
#variable "backend_asg_sg"{}
variable "alb_sg"{}