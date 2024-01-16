locals {
  name   = "jworks-iac-testing"
  region = "eu-west-1"
}

resource "aws_s3_bucket" "this" {
  bucket_prefix = "s3-${local.name}"
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}
