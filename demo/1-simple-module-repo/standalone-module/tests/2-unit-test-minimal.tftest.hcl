run "minimal" {

  command = apply

  variables {
    env="tst"
    name="standalone-module-test"
  }

  assert {
      condition     = strcontains(aws_s3_bucket.this.id, "standalone-module-test")
      error_message = "S3 bucket name doesn't contain the standalone module name"
  }

  assert {
      condition     = contains(keys(aws_s3_bucket.this.tags_all), "environment")
      error_message = "S3 bucket environment tag should be set"
  }

  assert {
      condition     = aws_s3_bucket.this.tags_all["environment"] == "tst"
      error_message = "S3 bucket environment tag is not set to 'tst'"
  }

  
  assert {
      condition     = output.name == "s3-tst-standalone-module-test"
      error_message = "S3 bucket name must follow the naming convention"
  }
    
  assert {
      condition     = strcontains(output.arn, "s3-tst-standalone-module-test")
      error_message = "S3 bucket ARN doesn't contain the naming convention"
  }
}