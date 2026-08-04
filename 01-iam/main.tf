# ==============================================================================
# 1. IAM USERS
# ==============================================================================

resource "aws_iam_user" "aditya1" {
  name = "aditya1"
  path = "/"

  tags = {
    Environment = "Dev1"
  }
}

resource "aws_iam_user" "rohit" {
  name = "rohit"

  tags = {
    Environment = "Dev"
  }
}

# ==============================================================================
# 2. IAM GROUP & MEMBERSHIP
# ==============================================================================

resource "aws_iam_group" "developers" {
  name = "DeveloperGroup"
  path = "/"
}

# Add both users to the DeveloperGroup in one place
resource "aws_iam_group_membership" "team" {
  name  = "developer-group-membership"
  group = aws_iam_group.developers.name

  users = [
    aws_iam_user.aditya1.name,
    aws_iam_user.rohit.name,
  ]
}

# ==============================================================================
# 3. IAM POLICY & ATTACHMENT
# ==============================================================================

resource "aws_iam_policy" "s3_read_only" {
  name        = "DeveloperS3ReadOnlyPolicy"
  description = "Allows developers to list and view objects in s3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:Get*",
          "s3:List*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach policy to the Developer Group
resource "aws_iam_group_policy_attachment" "developer_s3_attach" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}

# ==============================================================================
# 4. IAM ROLE
# ==============================================================================

resource "aws_iam_role" "my_first_role" {
  name = "MyFirstEC2Role"

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