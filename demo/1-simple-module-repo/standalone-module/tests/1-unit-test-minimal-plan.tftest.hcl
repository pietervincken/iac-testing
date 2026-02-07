run "minimal" {

  command = plan

  variables {
    env="tst"
    name="standalone-module-test"
  }

  assert {
      condition     = strcontains(aws_s3_bucket.this.bucket, "standalone-module-test")
      error_message = "S3 bucket name doesn't contain the standalone module name"
  }
}