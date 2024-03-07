/*  Set CloudWatch dashboard variables  */

variable "dashboard_name" {
  type    = string
  default = "cloudwatch-dashboard"
}
variable "rds_instance_id" {
  type = string
}
variable "alb_name" {
  type = string
}
variable "asg_name" {
  type = string
}

/* Emails  */

variable "emails" {
  description = "teammates' email addresses"
  type        = list(string)
}

/*  SET ELB alarm variables  */

variable "comparison_operator" {
  default = "GreaterThanOrEqualToThreshold"
}
variable "elb_alarm_metric_name" {
  type    = string
  default = "elb_alarm_metric_name"
}

/*  Set RDS CPU alarm variables  */

variable "rds_cpu_metric_name" {
  type    = string
  default = "rds_cpu_metric_name"
}
