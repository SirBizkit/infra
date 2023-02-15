provider "aws" {
  region = "eu-central-1"
}

# S3 bucket for shared Terraform state
module "terraform_state" {
  source = "../../modules/s3/encrypted-private-s3-bucket"

  bucket_name = "sirbizkit-infra-terraform-state"
  file_versioning = true
}

# S3 bucket for misc file backups
module "file_backup" {
  source = "../../modules/s3/encrypted-private-s3-bucket"

  bucket_name = "sirbizkit-infra-file-backup"
  file_versioning = false
}

# Locks table for Terraform state
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "sirbizkit-infra-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
