
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL traffic from back-end-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [var.backend_sg, var.back_sg]
  }
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"] #All outbound traffic allowed
  }
  tags = {
    Name = "rds-ec-sg"
  }
}

 resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "mysql_subnet_group"
  subnet_ids = var.private_subnet_ids 

}

resource "random_password" "db_password" {
  length = 16
  special = true
  override_special = "-!"
}

resource "aws_secretsmanager_secret" "rds2_credentials" {
  name = "secret_credintials"
  description = "RDS credentials"
  
}

resource "aws_secretsmanager_secret_version" "rds2_credentials" {
  secret_id     = aws_secretsmanager_secret.rds2_credentials.id
  secret_string = jsonencode({
    DB_USERNAME = var.db_username
    DB_PASSWORD = random_password.db_password.result,
    DB_ENDPOINT = aws_db_instance.mysql_instance.endpoint
    DB_NAME     = var.db_name
  })
}

resource "aws_db_instance" "mysql_instance" {
  allocated_storage     = var.db_allocated_storage
  engine                = var.engine
  engine_version        = var.db_engine_version
  instance_class        = var.db_instance_class
  username              = var.db_username
  password              = random_password.db_password.result
  db_subnet_group_name  = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = var.skip_final_snapshot
  depends_on = [
    aws_db_subnet_group.mysql_subnet_group,  # This ensures that the DB instance is created after the subnet group
  ]
}
output "db_username" {
  value     = jsondecode(aws_secretsmanager_secret_version.rds2_credentials.secret_string)["DB_USERNAME"]
  sensitive = true
}
output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}



