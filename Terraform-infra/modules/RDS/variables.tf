
variable "vpc_id" {
  description = "VPC ID"
}

#variable "subnet_ids" {
  #description = "List of subnet IDs"
  #type        = list(string)
#}

#variable "db_identifier" {
  #description = "Database instance identifier"
#}

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

variable "db_name" {
  description = "Name of the initial database"
}

variable "db_username" {
  description = "Username for the database"
}


variable "db_publicly_accessible" {
  description = "Whether the database is publicly accessible"
  default     = false
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

#variable "backend_security_group" {
    #description = "backend sg"
    #type = list(string)
  
#}

#variable "ec2_sg_id" {
  #description = "ID of the EC2 security group"
#}
 variable "db_engine_version" {
    description = "db engine version"
    type = string
   
 }

 variable "engine" {
    description = "mysql"
    type = string
   
 }

 variable "backend_sg" {
    description = "backend sg"
    type = string
 }
 
 variable "skip_final_snapshot" {
    description = "true"
    type = string
   
 }

 variable "back_sg" {
   
 }