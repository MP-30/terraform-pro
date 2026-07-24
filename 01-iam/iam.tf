# Create an IAM Role for an EC2 Instance
resource "aws_iam_role" "my_first_role1" {
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

resource "aws_iam_group" "developers1" {
  name = "DeveloperGroup"
  path = "/"
}

# Create an NEW IAM user
resource "aws_iam_user" "aditya1" {
  name = "aditya1"
  path = "/"

  tags = {
    Environment = "Dev1"
  }
}

# Add user to the group
resource "aws_iam_group_membership" "team1" {
  name = "developer-group-membership1"

  users = [
      aws_iam_user.aditya1.name,
  ]

  group = aws_iam_group.developers1.name
}