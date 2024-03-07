/*  Set CloudWatch dashboard for monitoring RDS and ELB metrics  */

resource "aws_cloudwatch_dashboard" "cloudwatch-dashboard" {
  dashboard_name = var.dashboard_name
  dashboard_body = <<-EOF
    {
      "widgets": [
        {
          "type": "text",
          "x": 0,
          "y": 0,
          "width": 24,
          "height": 1,
          "properties": {
            "markdown": "## RDS Metrics"
          }
        },
        {
          "type": "metric",
          "x": 0,
          "y": 1,
          "width": 8,
          "height": 6,
          "properties": {
            "metrics": [
              ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "${var.rds_instance_id}"],
              ["AWS/RDS", "FreeableMemory", "DBInstanceIdentifier", "${var.rds_instance_id}"]
            ],
            "region": "us-west-2", 
            "title": "RDS CPU and Memory Utilization",
            "period": 300
          }
        },
        {
          "type": "text",
          "x": 8,
          "y": 1,
          "width": 8,
          "height": 1,
          "properties": {
            "markdown": "## ALB Metrics"
          }
        },
        {
          "type": "metric",
          "x": 8,
          "y": 2,
          "width": 8,
          "height": 6,
          "properties": {
            "metrics": [
              ["AWS/ApplicationELB", "HTTPCode_ELB_5XX_Count", "LoadBalancer", "${var.alb_name}"],
              ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", "${var.alb_name}"]
            ],
            "region": "us-west-2", 
            "title": "ALB HTTP 5XX Errors and Request Count",
            "period": 300
          }
        },
        {
          "type": "text",
          "x": 16,
          "y": 1,
          "width": 8,
          "height": 1,
          "properties": {
            "markdown": "## ASG Metrics"
          }
        },
        {
          "type": "metric",
          "x": 16,
          "y": 2,
          "width": 8,
          "height": 6,
          "properties": {
            "metrics": [
              ["AWS/AutoScaling", "GroupTotalInstances", "AutoScalingGroupName", "${var.asg_name}"]
            ],
            "region": "us-west-2", 
            "title": "ASG Instance Count",
            "period": 300
          }
        }
      ]
    }
  EOF
}



/*  SNS topic for ELB and RDS  */

resource "aws_sns_topic" "alarm_topic" {
  name = "alarm_topic"
}

/*  Set SNS subscription for email address  */

resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  count     = length(var.emails)
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = var.emails[count.index]
}
/*  CloudWatch alarm for RDS CPU errors  */

resource "aws_cloudwatch_metric_alarm" "rds_cpu_alarm" {
  alarm_name          = "RDS_CPU_Utilization_Alarm"
  comparison_operator = var.comparison_operator
  evaluation_periods  = 10
  metric_name         = var.rds_cpu_metric_name
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = 75
  alarm_description   = "RDS CPU utilization exceeds 75% for 10 minutes"
  alarm_actions       = [aws_sns_topic.alarm_topic.arn]

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }
}

/*  CloudWatch alarm for ELB HTTP errors  */

resource "aws_cloudwatch_metric_alarm" "elb_http_alarm" {
  alarm_name          = "elb_http_alarm"
  comparison_operator = var.comparison_operator
  evaluation_periods  = 2
  metric_name         = var.elb_alarm_metric_name
  namespace           = "AWS/ELB"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "ELB HTTP errors detected"
  alarm_actions       = [aws_sns_topic.alarm_topic.arn]
  dimensions = {
    LoadBalancerName = var.alb_name
  }
}
