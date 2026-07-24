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

# Create an IAM group

resource "aws_iam_group" "developers" {
  name = "DeveloperGroup"
  path = "/"
}

# Create an NEW IAM user
resource "aws_iam_user" "aditya" {
  name = "aditya"
  path = "/"

  tags = {
    Environment = "Dev"
  }
}

# Add user to the group
resource "aws_iam_group_membership" "team" {
  name = "developer-group-membership"

  users = [
      aws_iam_user.aditya.name,
  ]

  group = aws_iam_group.developers.name
}