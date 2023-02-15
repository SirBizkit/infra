variable "bucket_name" {
  description = "The S3 bucket name"
  type        = string
}

variable "file_versioning" {
  description = "Should file versioning be turned on for this bucket"
  default     = false
  type        = bool
}

variable "prevent_destroy" {
  description = "Should this bucket be protected from accidental deletion"
  default     = false
  type        = bool
}
