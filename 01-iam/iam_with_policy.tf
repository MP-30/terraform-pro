resource "aws_iam_user" "rohit" {
  name = "rohit"

  tags = {
    ENVIRONMENT = "Dev"
  }
}

resource "aws_iam_group" "developers" {
  name = "DeveloperGroup"
  path = "/"
}

resource "aws_iam_group_membership" "developers" {
  group = aws_iam_group.developers.name
  name  = "developer-group-membership"
  users = [
    aws_iam_user.rohit.name
    ]
}

# create a custom IAM policy for s3 read-only access
resource "aws_iam_policy" "s3_read_only" {
  name   = "DeveloperS3ReadOnlyPolicy"
  description = "Allows developers to list and view objects in s3"

  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "s3:Get*",
            "s3:List*"
          ]
          Resource = "*"
        }
      ]
    }
  )
}

# Attack policy to the Deveoper Group
resource "aws_iam_group_policy_attachment" "developer_s3_attack" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}

# IAM roles
resource "aws_iam_role" "my_first_role" {
  name = "MyFirstEC2Role"
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {Service = "ec2.amazonaws.com"}
        }
      ]
    }
  )
}