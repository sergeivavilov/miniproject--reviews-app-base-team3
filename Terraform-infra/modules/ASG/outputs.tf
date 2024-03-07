output "frontend_asg_sg_id" {
  value = aws_security_group.frontend_asg_sg.id
}

output "backend_asg_sg_id" {
  value = aws_security_group.backend_asg_sg.id
}
output "asg_name_frontend" {
  value = "${aws_autoscaling_group.frontend_asg.name}"
}
output "asg_name_backend" {
  value = "${aws_autoscaling_group.backend_asg.name}"
}