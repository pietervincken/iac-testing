run "test-1" {
  assert {
    condition     = data.aws_s3_bucket.this.region == "eu-west-1"
    error_message = "Incorrect region for ${data.aws_s3_bucket.this.bucket}\n was ${data.aws_s3_bucket.this.region} expected eu-west-1"
  }
}
