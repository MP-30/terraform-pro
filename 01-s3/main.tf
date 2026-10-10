locals {
  bucket_name = terraform.workspace == "default" ? var.bucket_name : "${var.bucket_name}-${terraform.workspace}"
}

resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}