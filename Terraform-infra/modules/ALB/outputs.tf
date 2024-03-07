output "alb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.alb.dns_name
}

output "alb_arn" {
  description = "The ARN of the load balancer."
  value       = aws_lb.alb.arn
}

output "alb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)."
  value       = aws_lb.alb.zone_id
}

output "alb_frontend_target_group" {
  description = "The Target Group ARN will be used by ASG Attachment."
  value       = aws_lb_target_group.frontend.arn
}

output "alb_backend_target_group" {
  description = "The Target Group ARN will be used by ASG Attachment."
  value       = aws_lb_target_group.backend.arn
}
output "alb_sg_id" {
  value = aws_security_group.allow_tls
}