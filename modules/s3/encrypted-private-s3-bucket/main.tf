resource "aws_s3_bucket" "terraform_state" {
  bucket = "sirbizkit-infra-terraform-state"

  tags = {
    Name = "terraform_state"
  }

  lifecycle {
    prevent_destroy = true # Prevent accidental deletion of this S3 bucket
  }
}