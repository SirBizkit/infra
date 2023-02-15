provider "aws" {
  region = "eu-central-1"
}

module "terraform_state" {
  source = "../../modules/s3/encrypted-private-s3-bucket"

  bucket_name = "sirbizkit-infra-terraform-state"
}

#resource "aws_s3_bucket" "terraform_state" {
#  bucket = "sirbizkit-infra-terraform-state"
#
#  tags = {
#    Name = "terraform_state"
#  }
#
#  lifecycle {
#    prevent_destroy = true # Prevent accidental deletion of this S3 bucket
#  }
#}

## Turn on file versioning
#resource "aws_s3_bucket_versioning" "enabled" {
#  bucket = aws_s3_bucket.terraform_state.id
#  versioning_configuration {
#    status = "Enabled"
#  }
#}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "sirbizkit-infra-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "file-backup" {
  bucket = "sirbizkit-infra-file-backup"

  lifecycle {
    prevent_destroy = true # Prevent accidental deletion of this S3 bucket
  }
}