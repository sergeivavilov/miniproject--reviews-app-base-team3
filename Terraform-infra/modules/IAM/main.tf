data "aws_iam_role" "existing_role" {
  name = var.role_name
}
resource "aws_iam_role" "admin_role" {
  name               = var.role_name
  max_session_duration = var.duration_of_a_role
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": var.allowed_accounts
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

locals {
  policy_arns = {
    for name in var.policy_names : name => "arn:aws:iam::aws:policy/${name}"
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachments" {
  for_each = local.policy_arns

  role       = aws_iam_role.admin_role.name
  policy_arn = each.value
}