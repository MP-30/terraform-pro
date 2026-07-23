# Create an IAM Role for an EC2 Instance
resource "aws_iam_role" "my_first_role" {
  name = "MyFirstEC2Role"

  # Trust Policy: Allows EC2 to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
      }
    ]
  })
}