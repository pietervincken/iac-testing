variable "bucket" {
  description = "The name of the S3 bucket to create"
  type        = string
}

data "aws_s3_object" "this" {
  bucket = var.bucket
  key    = "test-fixture"
}
