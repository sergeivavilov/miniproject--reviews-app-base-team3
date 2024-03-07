# Security Group

resource "aws_security_group" "allow_tls" {
  name        = var.alb_name
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.alb_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 83
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Load Balancer

resource "aws_lb" "alb" {
  name                       = var.alb_name
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = var.subnet_ids
  security_groups            = [aws_security_group.allow_tls.id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "frontend" {
  name     = "frontend-target-group"
  port     = var.frontend_target_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "backend" {
  name     = "backend-target-group"
  port     = var.backend_target_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
    }
  }
#####################################
resource "aws_lb_listener" "api_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
    }
  }
resource "aws_lb_listener_rule" "frontend_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 100

  condition {
    host_header {
      values = [var.frontend_domain]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}
###########################
resource "aws_lb_listener_rule" "api_rule" {
  listener_arn = aws_lb_listener.api_listener.arn
  priority     = 110

  condition {
    host_header {
      values = [var.backend_domain]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}

resource "aws_lb_listener_rule" "backend_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 110

  condition {
    host_header {
      values = [var.backend_domain]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "frontend" {
   autoscaling_group_name = var.frontend_autoscaling_group_name
   lb_target_group_arn    = aws_lb_target_group.frontend.arn
}

resource "aws_autoscaling_attachment" "backend" {
  autoscaling_group_name = var.backend_autoscaling_group_name
  lb_target_group_arn    = aws_lb_target_group.backend.arn

}

# Defines frontend DNS records pointing to the ALB as PRIMARY
resource "aws_route53_record" "frontend_primary" {
  zone_id        = var.route53_zone_id
  name           = var.frontend_domain
  type           = "A"
  set_identifier = "frontend-primary"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
  failover_routing_policy {
    type = "PRIMARY"
  }
}

# Defines frontend DNS records pointing to the S3 Bucket (when ALB is down) as SECONDARY
resource "aws_route53_record" "frontend_secondary" {
  zone_id        = var.route53_zone_id
  name           = var.frontend_domain
  type           = "A"
  set_identifier = "frontend-secondary"

  alias {
    name                   = var.s3_maintenance_page_endpoint
    zone_id                = var.s3_maintenance_page_hosted_zone_id
    evaluate_target_health = true
  }

  failover_routing_policy {
    type = "SECONDARY"
  }
}

resource "aws_route53_health_check" "frontend_primary" {
  fqdn              = var.frontend_domain
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "1"
  request_interval  = "10"

  tags = {
    Name = "frontend-failover-healthcheck"
  }
}

resource "aws_route53_health_check" "backend_healthcheck" {
  fqdn              = var.backend_domain
  port              = 80
  type              = "HTTP"
  resource_path     = "/product"
  failure_threshold = "1"
  request_interval  = "10"

  tags = {
    Name = "frontend-failover-healthcheck"
  }
}

# Define backend DNS records pointing to the ALB
resource "aws_route53_record" "backend_dns" {
  zone_id = var.route53_zone_id
  name    = var.backend_domain
  type    = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
