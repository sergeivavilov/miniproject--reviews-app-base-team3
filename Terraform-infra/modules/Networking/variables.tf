variable "project_vpc" {
  description = "Name of the VPC"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_1_cidr_block" {
  description = "CIDR block for public subnet 1"
}

variable "public_subnet_2_cidr_block" {
  description = "CIDR block for public subnet 2"
}

variable "private_subnet_1_cidr_block" {
  description = "CIDR block for private subnet 1"
}

variable "private_subnet_2_cidr_block" {
  description = "CIDR block for private subnet 2"
}

variable "availability_zone_1" {
  description = "Availability Zone for subnet 1"
}

variable "availability_zone_2" {
  description = "Availability Zone for subnet 2"
}
