# Launch Templates for Frontend
resource "aws_launch_template" "frontend_template" {
  name                   = "mini_project_frontend_template"
  image_id               = var.frontend_ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.frontend_asg_sg.id]
  key_name = "Frontend-new"
}

# # Frontend Auto Scaling Group
resource "aws_autoscaling_group" "frontend_asg" {
  name              = var.frontend_asg_name
  depends_on        = [aws_launch_template.frontend_template]
  target_group_arns = [var.frontend_tg_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.frontend_template.id
    version = "$Latest"
  }

  min_size            = 1
  max_size            = 5
  desired_capacity    = 1
  vpc_zone_identifier = var.subnets
}


# Frontend Scaling Policy
resource "aws_autoscaling_policy" "frontend_scaling_policy" {
  name                   = "frontend-scaling-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.frontend_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60
  }
}



# Backend autoscaling group

# Launch Templates for Backend
resource "aws_launch_template" "backend_templete" {
  name                   = "mini_project_backend_template"
  image_id               = var.backend_ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.backend_asg_sg.id]
  iam_instance_profile {
    name = "Secret_manager_role"
  }
  
}

# Backend Auto Scaling Group
resource "aws_autoscaling_group" "backend_asg" {
  name              = "back_sg"
  depends_on        = [aws_launch_template.backend_templete]
  target_group_arns = [var.backend_tg_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.backend_templete.id
    version = "$Latest"
  }

  min_size            = 1
  max_size            = 5
  desired_capacity    = 1
  vpc_zone_identifier = var.subnets
}


# Backend Scaling Policy
resource "aws_autoscaling_policy" "backend_scaling_policy" {
  name                   = "backend-scaling-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.backend_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60
  } 
  }
# Create Security Group for Frontend ASG: open port 80 allowing traffic from ALB sg

resource "aws_security_group" "frontend_asg_sg" {
  name        = "frontend-asg-sg"
  vpc_id      = var.vpc_id
  description = "Open port 80, allow traffic from ALB"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    security_groups = [var.alb_sg.id]
    # cidr_blocks = ["0.0.0.0/0"]
  }

      ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group for Backend ASG: open port 8080 allowing traffic from ALB sg

resource "aws_security_group" "backend_asg_sg" {
  name        = "backend-asg-sg"
  vpc_id      = var.vpc_id  
  description = "Open port 8080, allow traffic from ALB"

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    security_groups = [var.alb_sg.id]
    # cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    security_groups = [var.alb_sg.id]
    # cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}