resource "aws_iam_role" "ec2_role_for_ssm" {
  count = var.is_ssm_enabled ? 1 : 0

  name = "ec2-role-for-ssm"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name        = "ec2-role-for-ssm"
    Description = "EC2 role for SSM"
  }
}

resource "aws_iam_role_policy_attachment" "ssm_managed_to_ec2_role" {
  count = var.is_ssm_enabled ? 1 : 0

  role       = aws_iam_role.ec2_role_for_ssm[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_connection" {
  count = var.is_ssm_enabled ? 1 : 0

  name = "ssm-connection"
  role = aws_iam_role.ec2_role_for_ssm[0].name

  tags = {
    Name        = "ssm-connection"
    Description = "Instance profile for conntecting to instances with SSM"
  }
}