variable "bucket" {
  description = "The name of the S3 bucket to create"
  type        = string
}


resource "aws_s3_object" "this" {
  bucket = var.bucket
  key    = "test-fixture"
  content = "This is a test fixture for validating S3 object creation."
}