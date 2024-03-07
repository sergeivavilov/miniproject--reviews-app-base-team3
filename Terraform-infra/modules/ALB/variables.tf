variable "alb_name" {
  description = "Name of the Application Load Balancer"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "subnet_ids" {
  description = "Subnet IDs in VPC"
}


variable "frontend_target_port" {
  description = "Port for the frontend target group"
}

variable "backend_target_port" {
  description = "Port for the backend target group"
}

variable "frontend_domain" {
  description = "Frontend domain for ALB listener rules"
}

variable "backend_domain" {
  description = "Backend domain for ALB listener rules"
}

variable "s3_maintenance_page_endpoint" {
  description = "Website Endpoint of S3 bucket hosting maintenance page"
}

variable "s3_maintenance_page_hosted_zone_id" {
  description = "Hosted Zone ID of S3 bucket hosting maintenance page"
}

variable "frontend_autoscaling_group_name" {
  description = "Frontend Auto Scaling Group name for attaching to ALB Target Groups"
}

variable "backend_autoscaling_group_name" {
  description = "Backend domain for ALB listener rules"
}

variable "route53_zone_id" {
  description = "Route53 hosted zone ID"
}
variable "frontend_dns" {
  
}