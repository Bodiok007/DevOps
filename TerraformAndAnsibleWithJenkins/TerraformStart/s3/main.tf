provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my-state-bucket" {
  bucket = "my-state-bucket-u4109"
}

resource "aws_s3_bucket_versioning" "my-state-bucket-versioning" {
  bucket = aws_s3_bucket.my-state-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "my-state-bucket-encryption" {
  bucket = aws_s3_bucket.my-state-bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "dynamodb-lock" {
  name           = "my-state-bucket-lock-table"
  read_capacity  = 1
  write_capacity = 1
  billing_mode   = "PROVISIONED"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "TF Lock Table"
    Env  = "Dev"
  }
}