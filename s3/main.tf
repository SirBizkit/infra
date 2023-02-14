provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "sirbizkit-infra-terraform-state"

  lifecycle {
    prevent_destroy = true # Prevent accidental deletion of this S3 bucket
  }
}

resource "aws_s3_bucket" "file-backup" {
  bucket = "sirbizkit-infra-file-backup"

  lifecycle {
    prevent_destroy = true # Prevent accidental deletion of this S3 bucket
  }
}