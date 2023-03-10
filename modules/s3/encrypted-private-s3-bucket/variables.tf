variable "bucket_name" {
  description = "The S3 bucket name"
  type        = string
}

variable "file_versioning" {
  description = "Should file versioning be turned on for this bucket"
  type        = bool
  default     = false
}

## Disabling for now as variables can't be used
## in prevent_destroy as per https://github.com/hashicorp/terraform/issues/22544
#variable "prevent_destroy" {
#  description = "Should this bucket be protected from accidental deletion"
#  type        = bool
#  default     = false
#}
