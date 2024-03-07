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


variable "db_name" {
  description = "Name of the initial database"

}

variable "db_username" {
  description = "Username for the database"
}

variable "db_allocated_storage" {
  description = "Allocated storage for the database instance (in GB)"
  default     = 20
}
variable "db_storage_type" {
  description = "Storage type for the database instance (e.g., gp2)"
  default     = "gp2"
}
variable "db_instance_class" {
  description = "Database instance class (e.g., db.t2.micro)"
  default     = "db.t2.micro"
}
variable "db_engine_version" {
  description = "db engine version"
  type        = string

}

variable "engine" {
  description = "mysql"
  type        = string

}
variable "skip_final_snapshot" {
  description = "true"
  type        = string

}


#############BASTION###################
#############BASTION###################
#############BASTION###################
#############BASTION###################
#############BASTION###################


variable "my_ip" {
  description = "Your public IP address to allow SSH access to the Bastion host"
}

variable "bastion_ami" {
  description = "The AMI to use for the Bastion host"
}

variable "key_name" {
  description = "The name of the SSH key pair"
}


variable "instance_type" {
  type = string

}
#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################

###########ASG#########
variable "frontend_ami" {

}
variable "backend_ami" {

}
variable "secrets_permission" {

}
variable "frontend_asg_name" {

}

variable "backend_asg_name" {

}

#ALB####
variable "alb_name" {
  type        = string
  description = "Name of the Application Load Balancer"
}
variable "frontend_target_port" {
  type        = string
  description = "Target port of Frontend"
}
variable "backend_target_port" {
  type        = string
  description = "Target port of Backend"
}
variable "frontend_domain" {
  type        = string
  description = "Fully Qualified Domain Name (FQDN) of Frontend"
}
variable "backend_domain" {
  type        = string
  description = "Fully Qualified Domain Name (FQDN) of Backend"
}
variable "s3_maintenance_page_hosted_zone_id" {
  type        = string
  description = "Hosted Zone ID of S3 Bucket"
}


# variable s3_bucket_region {
#type        = string
#description = "Hosted Zone ID of S3 Bucket"

# variable route53_domain_name {
# type        = string
# description = "Domain Name in Route53"
# }

/*  S3  */
variable "bucket" {
  type    = string
  default = "S3-default-23d"
}


/* CloudWtch  */

variable "emails" {
  type = list(string)
}
variable "frontend_dns_address" {
  
}


# variables for IAM role module

# declaration of variables for IAM users
variable "ID" {
  type = list(string)
  description = "Account numbers of users who will asume role"
}

variable "policies" {
  type = list(string)
  description = "names of policies to be attached to users"
}

variable "role" {
  type = string
  description = "name of a role to create"
}

variable "time_limit" {
  type = number
  description = "time limit for a session"
}